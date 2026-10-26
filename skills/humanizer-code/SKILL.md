---
name: humanizer-code
description: |
  Remove AI slop from code and from the text around it without changing behavior: narrating
  comments, vacuous tests, defensive clutter, debug leftovers, plus AI-sounding commit messages,
  PR descriptions, docstrings, READMEs and error messages. Works on the current diff or branch
  by default. Use when the user says deslop, clean up the AI code, humanize a commit or PR, or tidy
  comments. Supersedes the deslop skill. For prose use humanizer; for papers and reports use
  humanizer-paper.
metadata:
  version: "1.0.0"
  builds-on: "deslop + humanizer 1.0.0 (same repo)"
---

# Code humanizer

Clean the latest changes so they read like code a careful engineer wrote by hand: no session narration, nothing that exists only because a model was being cautious, and commit and PR text a reviewer can take in at a glance.

## Scope

- Default: the diff of the latest changes on the current branch (`git diff <base>...HEAD` plus uncommitted work). Only touch lines the branch introduced unless asked to go wider.
- If the user names files, a PR or a commit message, work on exactly that.
- For prose in docs, READMEs and PR text, use the patterns in `../humanizer/SKILL.md` (§1–§31; installed at `~/.claude/skills/humanizer/SKILL.md`); the rules below say how they apply to code.
- If the repository has an `AGENTS.md`, `CLAUDE.md` or contributing guide, read it first; its rules override this skill.

## Code

### Comments

- Comments that narrate the editing session rather than the code: "now handles X", "updated to use Y", "changed from the old approach", "as requested". (Humanizer §25: text about its own history.)
- Comments written from recency bias: they explain the thing the author happened to be thinking about during the edit, not what a reader six months later needs. A comment justifying a line that is already obvious from the line is slop.
- Comments restating the code, dead TODOs, and section banners nobody maintains.
- Do NOT preserve a bad comment because the surrounding file is full of them. Local style is not authority; if the file's convention is itself slop, cut against it.
- Delete causal or quantitative comments when later evidence contradicts them. Do not soften a refuted explanation into speculation; a wrong explanation is worse than none.
- Default to few comments: only where the why is not obvious from the code.

### Docstrings

- One line when the name and signature already say what it does. Document arguments only when something about them is not obvious (units, ownership, allowed ranges).
- No sales language ("a robust and efficient utility that seamlessly..."); no "This function..." restating the name. Match the docstring style already in the file.

### Tests

- Tests that assert nothing meaningful: asserting a mock was called, asserting a constructor returns non-None, re-asserting the literal the test just wrote in.
- Tests that pin behaviour we do not actually want. These are the expensive ones: future code gets built around the frozen behaviour and the slop compounds. Flag the pinned behaviour explicitly before deleting.
- Tests whose setup is so mock-heavy they only exercise the mocks.

### Code

- Defensive checks or try/catch blocks that are abnormal for trusted code paths.
- Casts to `any` (or `# type: ignore`, `as unknown as`) used only to bypass type issues.
- Deeply nested code that should be simplified with early returns.
- A caller importing a callee's private constant is a contract bypass.
- The same quantity fetched through several different accessors.
- Names that carry the session instead of the meaning: `new_`, `improved_`, `_v2`, `fixed_`, `final_`, `helper_util_manager`.

### Investigation leftovers

- Diagnostic prints, ablation flags and env gates, widened logging, commented-out probes. All slop once finished investigating.
- A verbosity or debug-interval constant tightened to chase a bug must go back to its shipped value.
- Before calling an investigation finished, grep for the names of your own gates, flags and prints. They ship otherwise.

### Compensations

- Remove compensations that patch around an underlying bug when the root cause can be fixed instead. These patches often outlive the conditions that motivated them and become bugs themselves.

## Text around the code

### Commit messages

- Read `git log --oneline -20` first and match the repo's style (prefixes, tense, length).
- Subject: imperative, specific, about 60 characters, no trailing period, no emoji.
- Body only when the why is not obvious from the diff; wrap at about 72 characters.
- Cut: "This commit...", a bullet for every touched file, triads by habit (§6), "comprehensive", "robust", "enhance", "streamline", and any closer that restates the subject.

**Before:** ✨ Enhance robustness: This commit comprehensively refactors the parser, improves error handling, and streamlines the codebase for better maintainability.
**After:** Return parse errors instead of raising in config loader

(Only if that is what the diff does. Write the subject from the diff, never from the old message's adjectives.)

### PR descriptions and review replies

- Short: what changed and why in a few lines, then how it was tested. A few bullets at most.
- Use the repo's PR template if it has one; otherwise no "Summary / Changes / Impact" scaffolding with bold labels (§19).
- Do not restate the diff file by file, and do not argue with objections nobody raised (§5).
- In a reply to a reviewer, lead with the decision (§26).

### READMEs and docs

- Lead with what it is and how to run it. Apply the general patterns, especially §12 words, §16 sales language, §19 bold labels and §20 emoji headings ("🚀 Features").

### Error and log messages

- Say what failed and what to do: "config.yaml: missing key `port`", not "Oops! Something went wrong."
- Log lines are for whoever debugs this later: identifiers and values, not adjectives.

## Guardrails

- Keep production behavior unchanged unless fixing a clear bug.
- Deleting a test needs a stated reason (vacuous, or pins unwanted behavior X).
- Prefer minimal, focused edits over broad rewrites.
- Build and run the tests after the cleanup. Never commit an edit you did not check, and never commit without the user's review.
- **Attribution and disclosure follow each repository's and course's rule, never this skill's taste.** Do not add or remove `Co-Authored-By` lines or AI mentions on your own; use the rule the user or the repository has set. If a course requires AI-written code to be acknowledged (for example a comment with tool, URL, date and prompt), never remove or weaken that comment.
- Not a detector bypass: the goal is code and text a reviewer trusts, not hiding where it came from.
- Keep the final summary concise (1-3 sentences).
