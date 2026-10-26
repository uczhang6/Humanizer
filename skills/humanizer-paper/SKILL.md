---
name: humanizer-paper
description: |
  Edit academic and technical writing so it reads like a careful researcher wrote it: precise,
  calibrated, one term per concept, no AI tells, and no change to any claim, number or citation.
  Use for research papers in any field (abstract, intro, related work, method, evaluation,
  discussion), LaTeX sources, bibliographies, course and lab reports, academic essays, rebuttals
  and submission cover letters. For general prose use humanizer; for code, comments and commit
  messages use humanizer-code.
metadata:
  version: "1.0.0"
  builds-on: "humanizer 1.0.0 (same repo)"
---

# Paper humanizer

Academic readers look for claims they can check. Edit so that each sentence either gives the reader something they can verify, or sets up something they need for the next step. Remove what does neither. Leave the substance alone.

Read `../humanizer/SKILL.md` first (patterns §1 to §31; installed at `~/.claude/skills/humanizer/SKILL.md`), and `../humanizer/references/chinese.md` for Chinese text. Use those patterns in the academic voice described below. Skip the general skill's advice for personal writing (opinions, humor, "I").

## Ground rules

These come before every style rule in this file.

1. **The substance does not change.** No number, unit, result, dataset, citation, citation key, bibliography entry, author name, quotation, definition or theorem is added, removed or altered. A missing number becomes `\todo{N}` or `[?]`; a missing source becomes `% TODO cite`. Report every such marker to the author. Never write a placeholder that looks like a measurement.
2. **Claims keep the strength their evidence gives them.** Remove overstatement; do not soften a claim the results support. If you cannot tell, flag it.
3. **Local rules win.** A repository's `AGENTS.md`, `CLAUDE.md`, the venue's author kit or a course rubric overrides this skill. Read them first.
4. **AI assistance is the author's to disclose.** Never add or delete a disclosure on your own. If the project keeps a log of AI edits, add an entry: date, model, section, what changed.
5. **No detector evasion.** Do not plant typos, rare synonyms or erratic rhythm to get past a detector.
6. **Some text is frozen.** Pre-registered protocols, quoted rules, annotation guidelines and committed specifications get comments, not rewrites.
7. **Clarity over rules.** When a rule below would make a sentence harder to follow, keep the clearer sentence.

## How to work

1. **Identify the paper.** Field and paper type (see the table below), venue or course, template, spelling convention, and whether the authors write "we" or passive. Read neighbouring sections to learn their voice; a sample from the author overrides the defaults here.
2. **Verify before rewording.** If a sentence states something about the authors' own system, open the code, configuration or results it describes. If it states something about another paper, check that paper itself.
3. **Mark problems.** General patterns first, then the word list and W1 to W12 below.
4. **Edit prose only.** In LaTeX, keys inside `\cite`, `\ref` and `\label`, math, macros, environments, code listings, table data and `%` comments stay as they are. Make local edits without reorganising sections.
5. **Re-check.** Compare before and after: same numbers, same citations, same claim strength. If you touched LaTeX, compile and report the result and the page count. Do not commit; the author reviews first.
6. **Report.** For pasted text, return the edited version, a few lines on what changed, and the list of markers. For a file, edit in place and summarise.

## Know the paper type

Reviewers in each area check different things first. Use this to decide which sentences carry weight and what is missing.

| Paper type | Readers check first | Typical weak writing |
| --- | --- | --- |
| Machine learning, empirical | datasets and splits, baselines, seeds, variance | "state-of-the-art" from a single run; tuning effort hidden |
| Systems, networking, databases | workload, hardware, repeated runs, tail latency | averages only; setup too vague to reproduce |
| Security and privacy | threat model, attacker capabilities, assumptions, disclosure | "secure" without a model; attacks described more vaguely than defenses |
| Theory, formal methods | definitions, assumptions, what is proved | informal soundness claims; notation used before it is defined |
| HCI and user studies | participants, recruitment, measures, ethics approval | small samples written up as general findings |
| Benchmarks and datasets | task definitions, scoring, splits, leakage, licences | counts of what the tool could generate instead of what was run |
| Robotics and cyber-physical systems | simulation or hardware, number of trials, failure modes | simulated results worded like deployment results |
| LLM and agent studies | exact model versions and dates, prompts, decoding, cost | model behavior described as intention ("the model wanted") |

## Academic voice

- Choose "we" or the passive and stay with it. "We" is standard in most of computer science and engineering.
- Present tense for what the paper argues and shows; past tense for what was run and observed.
- **Terminology is fixed.** Define a term once and reuse exactly that term. Use the names the artifact itself uses (dataset names, API names, configuration keys). Swapping in a near-synonym for variety makes readers think a second thing exists. Common traps: model / system / method; participant / user / subject; run / trial / episode / experiment.
- Prefer verbs that say what happened: measured, compared, proved, estimated, observed. The general skill's §30 matters more here: software selects, returns, fails or times out; it does not think or want.
- Write for the venue's readers and define, once, whatever they cannot be expected to know.

## Word choice

Replace with the plain word or the number, or delete. Terms of art stay (robust optimisation, gated recurrent unit, loss landscape).

- **Inflation:** novel, groundbreaking, transformative, comprehensive, extensive, powerful, robust (as praise), state-of-the-art (unsupported), significant (without a test).
- **Filler adverbs:** notably, importantly, interestingly, clearly, obviously, indeed, simply, essentially, fundamentally, truly.
- **Stock academic phrasing:** delve into, shed light on, pave the way, in the realm of, a myriad of, plethora, multifaceted, holistic, nuanced, seamless, leverage, utilize, facilitate, underscore, showcase.
- **Vague quantity:** various, numerous, several, a wide range of. Give the count.
- **Metaphor standing in for a claim:** landscape, ecosystem, lens, blind spot, silver bullet, game changer, double-edged sword. Say the literal thing.
- **Connectors:** a run of moreover / furthermore / additionally / in addition. Most paragraphs need none.

## Weak spots in papers

### W1. Novelty and significance by adjective
"A novel and comprehensive framework that significantly outperforms prior work." Keep what is new and show the comparison. "Significant" belongs to a reported statistical test.

### W2. Openers about the field
"In recent years, X has attracted increasing attention." Start with the specific problem.
**Before:** In recent years, large language model agents have attracted increasing attention from both academia and industry. These agents increasingly rely on external tools, which raises important security concerns.
**After:** Large language model agents increasingly rely on external tools, which raises security concerns.

### W3. Contributions that cannot be checked
Each contribution names an artifact, a result, a proof or a dataset. Count what was built and run, not what could be.

### W4. Related work as a list of names
Organise by approach, and say for each group what it does not cover that this paper does.

### W5. Claims about other work that do not match it
A paraphrase of another paper must say what that paper says. Check the paper, not its abstract or a survey's summary. "Prior work has shown" needs a citation or goes.

### W6. Hedging that does not match the evidence
Remove stacked hedges ("may possibly suggest") and unearned certainty ("this proves", "obviously"). One hedge, or a scope statement: "on these three datasets".

### W7. Results without numbers
**Before:** Our approach significantly reduces latency compared to the baseline.
**After:** Our approach reduces median latency from \todo{N} ms to \todo{N} ms compared with \todo{baseline} (\todo{N} runs).

### W8. Summaries hung on the end of a sentence
"..., highlighting the importance of X." "..., demonstrating the effectiveness of our approach." Delete, or turn into a separate sentence that carries evidence.
**Before:** Accuracy dropped on the longer inputs, underscoring the limits of the model.
**After:** Accuracy dropped on the longer inputs.

### W9. Repetition across sections
An introduction that paraphrases the abstract; a conclusion that paraphrases the introduction; paragraphs that end by restating themselves. Each section should add something; end paragraphs on their last concrete point.

### W10. Limitations by template
"Future work will explore more settings." Name the actual limitation and which claims it weakens. Do not invent limitations or extra baselines to make a section look complete.

### W11. Signposting and padding
"In this section, we will discuss...", "It is worth noting that...", "As mentioned above...". Keep one short roadmap at the end of the introduction. Also shorten: in order to → to; due to the fact that → because; is able to → can; perform an analysis of → analyze; make use of → use.

### W12. Uniform sentences and decorative lists
Paragraphs where every sentence has the same length and shape read as generated; vary two of them. Use bullets only for genuinely separate items; a table is often clearer; no bold inside running text.

## Reporting checks

Flag what is missing. Do not supply it.

- **Every number:** unit, sample size, and spread (standard deviation, confidence interval or range).
- **Percentages:** the counts beside them, for example "45% (9/20)".
- **Comparisons:** same conditions and tuning effort for every method; the statistical test named, with an effect size, when a difference is claimed.
- **Repetition:** how many runs or seeds, and what changed between them.
- **Machine learning:** dataset versions and splits, search budget for hyperparameters, compute used.
- **Systems:** hardware, software versions, workload, warm-up, percentiles beyond the mean.
- **LLM-based work:** exact model identifiers and dates of use, prompts or where they are listed, decoding settings, cost and its date.
- **Simulation:** stated as simulation wherever a result could be read as real-world.
- **Safety and detection:** false positives and false negatives, with counts. A tested property is not a verified one.
- **People:** ethics approval, recruitment, consent, compensation (anonymised for review).
- **Artifacts:** what is released, where, under which licence.

## LaTeX and formatting

- Non-breaking space before references and units: `Figure~\ref{fig:x}`, `5~ms`, or `\SI{5}{\milli\second}` with `siunitx` if the template allows it.
- A citation is not a noun: "Smith et al. [4] show" rather than "[4] shows". Place each citation at the claim it supports, in the venue's citation style.
- Ranges with an en dash (`10--20`); an em dash (`---`) only for a real aside, and sparingly.
- LaTeX quotes (`` `` '' ``); no Markdown or emoji in `.tex` files.
- Define each abbreviation at first use in the body.
- Code identifiers in `\texttt{}`, introduced in words once.
- Names spelled as their owners spell them (Wi-Fi, PyTorch, LaTeX, ROS 2).
- Do not alter margins, fonts or spacing to gain room. Follow the template's guide on allowed packages and figure accessibility (alt text where supported).

## Citations

- Never cite a key that is not in the bibliography, and never invent a reference, page range or venue.
- Prefer the peer-reviewed version over a preprint; "submitted to" is not "published in".
- Check authors, year and venue against the publisher, DOI or DBLP (`https://dblp.org/search/publ/api?q=TITLE&format=json`).
- Cite what the argument uses; do not pad.
- Let the bibliography style do the formatting.

## Figures and tables

- Referenced in the text before they appear, readable at the size they will print.
- Vector graphics for plots and diagrams; distinctions that survive greyscale and colour blindness.
- The caption says what is shown and what to take from it; the text states the finding too.
- Units in headers; decimals matched to the precision of the measurement.
- Data figures come from scripts, not manual edits.

## Anonymous submissions

Nothing that identifies the authors: names, affiliations, lab or group names, acknowledgments, funding, links to code or personal pages, identifying paths or hostnames, or first-person references to the authors' earlier work. Check the PDF metadata. Use the template's anonymous mode rather than deleting the author block by hand.

## Course and lab reports

- One-sentence objective; procedure in past tense as actually performed; results as measured values with units and uncertainty; analysis comparing theory and measurement, with percent error and likely causes; a conclusion that answers the objective.
- Measured values are never filled in, smoothed or rounded to look better. Leave gaps.
- Follow the course's AI policy, including any required acknowledgment.

## Final pass

1. Is there a sentence a reviewer could not check and the argument does not need?
2. Any adjective doing the work of a number?
3. Any term used under two names?
4. Do all numbers and citations match the source files and the bibliography?
5. Does it still compile and fit the page limit?
6. Anything that breaks anonymity?
7. Markers (`\todo`, `[?]`, `% TODO cite`) listed for the author?

A quick search for leftovers (each hit needs a reason, not automatic deletion):

```sh
grep -nEi '\b(novel|groundbreaking|comprehensive|significantly|state-of-the-art|delve|shed light|pave the way|realm|myriad|plethora|multifaceted|holistic|nuanced|seamless|leverag|utiliz|facilitat|underscor|showcas|notably|importantly|interestingly|clearly|obviously|indeed|essentially|fundamentally|various|numerous|a wide range|landscape|ecosystem|game.changer|moreover|furthermore|it is worth noting|in this section)' *.tex
```

## When not to act

- Normal academic conventions stay: "In this paper, we", "To the best of our knowledge" (once, when true), "Without loss of generality".
- Definitions, theorems, pseudocode, quotations and frozen text get comments, not edits.
- Technical terms that resemble AI vocabulary are still technical terms.
