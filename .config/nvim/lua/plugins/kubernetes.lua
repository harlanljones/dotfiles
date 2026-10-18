-- Kubernetes: the Kubernetes schema for manifests in yamlls (the yaml extra adds
-- SchemaStore on top), and kubectl.nvim for browsing clusters (needs kubectl).
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                kubernetes = { "k8s/**/*.{yml,yaml}", "manifests/**/*.{yml,yaml}", "*.k8s.{yml,yaml}" },
              },
            },
          },
        },
      },
    },
  },
  {
    "ramilito/kubectl.nvim",
    version = "2.*",
    dependencies = "saghen/blink.download",
    cmd = { "Kubectl", "Kubectx", "Kubens" },
    keys = {
      { "<leader>k", function() require("kubectl").toggle({ tab = true }) end, desc = "Kubectl" },
    },
    opts = {},
  },
}
