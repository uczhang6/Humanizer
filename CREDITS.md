# Credits

This project builds on other people's work. What came from where:

| Source | License | What this repo uses |
| --- | --- | --- |
| [blader/humanizer](https://github.com/blader/humanizer) by Siqi Chen, v3.1.0 (commit `8c307f3`) and v2.1.1 | MIT | `skills/humanizer/SKILL.md` sections A to F (patterns §1 to §26), their examples, and the working method. The voice guidance for personal writing comes from v2.1.1. The copyright notice is kept in `LICENSE`. |
| [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing), maintained by [WikiProject AI Cleanup](https://en.wikipedia.org/wiki/Wikipedia:WikiProject_AI_Cleanup) | CC BY-SA 4.0 | The pattern catalogue that upstream is based on. Some before/after examples inherited from upstream may be adapted from that page; they are being replaced with original examples (see the roadmap in `README.md`). |
| The `deslop` command shared widely online; the earliest copy found is in Cursor's plugin collection (`cursor/plugins`) | original author and license not confirmed | The idea of cleaning a branch diff and the Code list (unusual defensive try/catch, casts to `any`, deep nesting) in `skills/humanizer-code/SKILL.md`. The Comments, Tests, Investigation leftovers and Compensations rules were rewritten or added by the author of this repo. |

Written for this repo: the Chinese patterns (`skills/humanizer/references/chinese.md`), patterns §27 to §31, all of `humanizer-paper`, and the commit, PR, docstring, README and error-message rules in `humanizer-code`.

Thanks to a lab colleague whose internal writing guide first collected several of the paper-writing concerns this project addresses. The text here is written independently for general use.
