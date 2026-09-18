---
name: notification
description: notify user, feedback needed, completion notification, pending feedback queue. Use when user feedback is required, when a run completes, or when notification mechanics are needed.
---

# Notification

## Purpose

Use this skill to notify the user outside the chat when attention is needed or when a run completes.

Prefer both channels when available:

- Desktop notification via `notify-send`.
- Tmux navigation notification via `~/.local/bin/tmux-notify`.

Do not let notification failure break the main task. Use `|| true` or equivalent guarding.

## Feedback Required

Use this when waiting for user input, approval, credentials, conflict resolution, destructive-action confirmation, or a decision that blocks progress.

Desktop format:

```bash
notify-send \
  "🐶 Agent Feedback Needed: <PLAN_NAME>" \
  "Project: <PROJECT>\nSummary: <WHAT_I_AM_DOING>\nAction required: <FEEDBACK_REQUEST>"
```

Tmux format:

```bash
~/.local/bin/tmux-notify "<PLAN_NAME>: <BRIEF_FEEDBACK_REQUEST>"
```

Safe combined form:

```bash
if command -v notify-send >/dev/null 2>&1; then
  notify-send \
    "🐶 Agent Feedback Needed: <PLAN_NAME>" \
    "Project: <PROJECT>\nSummary: <WHAT_I_AM_DOING>\nAction required: <FEEDBACK_REQUEST>" || true
fi

if [ -x "$HOME/.local/bin/tmux-notify" ]; then
  "$HOME/.local/bin/tmux-notify" "<PLAN_NAME>: <BRIEF_FEEDBACK_REQUEST>" || true
fi
```

## Completion

Use this when a planned run finishes or reaches a meaningful completed checkpoint.

Desktop format:

```bash
notify-send \
  "✅ Agent Complete: <PLAN_NAME>" \
  "Project: <PROJECT>\nSummary: <WHAT_COMPLETED>"
```

Tmux format:

```bash
~/.local/bin/tmux-notify "<PLAN_NAME>: complete - <BRIEF_RESULT>"
```

Safe combined form:

```bash
if command -v notify-send >/dev/null 2>&1; then
  notify-send \
    "✅ Agent Complete: <PLAN_NAME>" \
    "Project: <PROJECT>\nSummary: <WHAT_COMPLETED>" || true
fi

if [ -x "$HOME/.local/bin/tmux-notify" ]; then
  "$HOME/.local/bin/tmux-notify" "<PLAN_NAME>: complete - <BRIEF_RESULT>" || true
fi
```

## Pending Feedback Queue

When waiting for user feedback, keep this file accurate:

```text
/home/waiq/.config/opencode/pending-feedback-queue.md
```

Add or update an entry containing:

- Plan name.
- Project.
- Timestamp.
- Why feedback is needed.
- Exact request.
- Current blocking status.

Remove or mark the entry resolved once the user responds and the blocker is gone.

## Message Rules

- Keep `<BRIEF_FEEDBACK_REQUEST>` short because tmux navigation uses it.
- Include the exact user action needed in `Action required`.
- Include plan name and project when known.
- If no plan exists, use the repo or task name as `<PLAN_NAME>`.
- Do not send notifications for routine progress updates.
