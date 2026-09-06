---
name: grilling
description: Stress-test a plan or decision through dependency-aware rounds of questions. Use when the user requests grilling or an interview to expose assumptions; not routine implementation clarification.
---

Interview the user about the agreed scope. Map this as a **design tree**: every decision branches into the decisions that hang off it. Keep settled answers, open decisions and explicit deferrals visible; recommendations are not decisions until the user accepts them.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier when it is manageable; otherwise ask a bounded group and identify what remains. Number questions and give a recommendation with its tradeoff. Wait for the user's answers before asking dependent questions.

> Q-grilling-round-size: Preserve whole-frontier rounds or cap large rounds?
> Recommendation: keep whole-frontier rounds for small sets, but split large sets
> without hiding unanswered decisions. This preserves agency without overwhelming
> the interviewee.

Format a round like so:

```
1. <question title>: <question and choices>

Recommendation: <answer and tradeoff>

---

2. <question title>: <question and choices>

Recommendation: <answer and tradeoff>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Find accessible _facts_ through targeted inspection in-session. Delegate a bounded, independent evidence search when it materially helps; the interview stays with the parent. A running exploration is an unsettled prerequisite, so only downstream questions wait. For facts you cannot access, explain the limit and ask for the needed evidence without guessing. The _decisions_ are the user's: put each to them and wait. This interview is read-only unless the user separately asks for a saved artifact.

Finish by summarizing settled decisions, explicit assumptions, deferred branches and remaining uncertainty. The agreed scope is resolved only when it has no unanswered non-deferred decisions and the user confirms shared understanding; an empty frontier can also mean blocked prerequisites. If the user pauses, report the unresolved state rather than claiming completion. Confirmation of understanding is not permission to implement, publish or deploy the plan.
