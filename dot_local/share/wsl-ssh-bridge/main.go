package main

import (
	"io"
	"log"
	"net"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"syscall"
)

func main() {
	home, err := os.UserHomeDir()
	if err != nil {
		log.Fatalf("failed to get user home dir: %v", err)
	}

	sockDir := filepath.Join(home, ".1password")
	sockPath := filepath.Join(sockDir, "agent.sock")

	_ = os.MkdirAll(sockDir, 0700)
	_ = os.Remove(sockPath)

	listener, err := net.Listen("unix", sockPath)
	if err != nil {
		log.Fatalf("failed to listen on %s: %v", sockPath, err)
	}
	defer os.Remove(sockPath)
	defer listener.Close()
	_ = os.Chmod(sockPath, 0600)

	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)
	go func() {
		<-sigChan
		_ = os.Remove(sockPath)
		os.Exit(0)
	}()

	relayBin, err := exec.LookPath("npiperelay.exe")
	if err != nil {
		relayBin = filepath.Join(home, ".local", "bin", "npiperelay.exe")
	}

	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Printf("accept error: %v", err)
			continue
		}

		go func(c net.Conn) {
			defer c.Close()

			cmd := exec.Command(relayBin, "-ep", "-s", "//./pipe/openssh-ssh-agent")
			stdin, err := cmd.StdinPipe()
			if err != nil {
				return
			}
			stdout, err := cmd.StdoutPipe()
			if err != nil {
				return
			}

			if err := cmd.Start(); err != nil {
				return
			}

			done := make(chan struct{}, 2)
			go func() {
				_, _ = io.Copy(stdin, c)
				_ = stdin.Close()
				done <- struct{}{}
			}()
			go func() {
				_, _ = io.Copy(c, stdout)
				done <- struct{}{}
			}()

			<-done
			_ = cmd.Process.Kill()
		}(conn)
	}
}
