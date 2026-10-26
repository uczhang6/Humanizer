# humanizer

Three agent skills that edit AI-sounding writing so it reads like the person who wrote it. They change wording, never facts.

| Skill | Use it for |
| --- | --- |
| `humanizer` | General prose in English or Chinese: posts, emails, essays, documentation |
| `humanizer-paper` | Research papers, LaTeX sources, bibliographies, course and lab reports |
| `humanizer-code` | Code slop in a diff, plus comments, docstrings, commit messages, PR descriptions and READMEs |

`humanizer-paper` and `humanizer-code` read the pattern list in `humanizer`, so install all three together.

## Install

Claude Code looks for skills in `~/.claude/skills`. From a clone of this repo:

```sh
./install.sh          # macOS, Linux, WSL, Git Bash
```

```powershell
.\install.ps1         # Windows PowerShell
```

Both scripts copy `skills/*` into `~/.claude/skills`, replacing older copies of these three skills. Other agents that support `SKILL.md` skills can load the same folders.

## Use

Ask in plain words ("humanize this paragraph", "clean up the AI slop in this branch", "tighten the related-work section") or call a skill by name, for example `/humanizer-paper main.tex`.

For pasted text you get the rewrite and a short list of what changed. For a file the skill edits it in place and reports a summary. Nothing is committed without your review.

## Rules every skill follows

- **No invented facts.** A rewrite keeps every number, name, date, citation and claim. When a sentence needs a detail that is missing, the skill marks it (`[?]`, `\todo{N}`, `% TODO cite`) and asks you.
- **Not a detector bypass.** The aim is writing a careful reader trusts. The skills never add deliberate errors, odd synonyms or random rhythm to fool an AI detector.
- **Disclosures stay.** AI-use statements that a venue or course requires, `Co-Authored-By` lines and course-mandated acknowledgments are never removed or added on the skill's own initiative.
- **Project rules win.** If a repository has an `AGENTS.md`, `CLAUDE.md` or style guide, it overrides the skill.

## What is different from upstream

This started from [blader/humanizer](https://github.com/blader/humanizer) v3.1.0 and adds:

- Chinese patterns (`skills/humanizer/references/chinese.md`), loaded when the text is Chinese or mixed.
- Patterns §27 to §31 for analytical prose: colon reveals, verdict sentences, semicolon chains, personified systems, staged questions.
- A paper skill for any field: what reviewers check first in each paper type (ML, systems, security, theory, HCI, benchmarks, robotics, LLM studies), academic voice, word choice, common weak spots, reporting checks, LaTeX safety, citations, figures, anonymous submissions, course and lab reports, and a final checklist.
- A code skill that merges `deslop` with rules for commit messages, PR text, docstrings and error messages.

## Roadmap

- Replace the before/after examples inherited from upstream with original ones.
- An evaluation set: AI-sounding inputs with reference rewrites, and a script that checks rewrites for lost or invented numbers and citations.
- More Chinese academic patterns (本文旨在, 具有重要的理论意义和现实意义).

## Credits and license

MIT. See `LICENSE` and `CREDITS.md` for what comes from blader/humanizer, Wikipedia's "Signs of AI writing" and the `deslop` skill.
