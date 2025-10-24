# Story 3.1: Quick Start Guide - User Testing Protocol

**Version:** 1.0
**Date Created:** 2025-10-23
**Status:** Ready for Execution

---

## Objective

Validate that the Quick Start Guide (`docs/quickstart.md`) enables naive users (researchers without prior MAestro exposure) to complete a full meta-analysis workflow in **<45 minutes** with **zero blocking errors**.

---

## Test Setup Requirements

### Pre-Test Checklist

- [ ] Identify 2 naive test users (researchers/students unfamiliar with MAestro)
- [ ] Confirm they have basic familiarity with meta-analysis concepts (but NOT MAestro)
- [ ] Schedule 60-minute testing sessions (45 min workflow + 15 min feedback)
- [ ] Prepare testing environment:
  - [ ] Python 3.9+ installed
  - [ ] Git installed
  - [ ] Claude Code installed and working
  - [ ] Text editor available
  - [ ] Internet access for downloading papers (if using real papers)
- [ ] Have copy of `docs/quickstart.md` ready (ONLY this file, no other docs)
- [ ] Have example papers ready OR link to `examples/e2e_test_meta_analysis/source_papers/`

### Test User Profiles

**User A:** [Name: ___________] | Background: [Discipline: ___________] | Meta-analysis Experience: [None / Basic / Moderate]

**User B:** [Name: ___________] | Background: [Discipline: ___________] | Meta-analysis Experience: [None / Basic / Moderate]

---

## Test Execution Procedure

### Phase 1: Introduction (5 minutes)

**Script for Tester:**

> "Thank you for participating. Today, we're testing a new user guide for MAestro—an AI-assisted meta-analysis tool. Your job is to follow ONLY this guide (quickstart.md) and try to complete a full meta-analysis workflow.
>
> You have 45 minutes. I won't help you beyond clarifying what the guide says. Your feedback is valuable—please speak out loud if you get stuck, confused, or if something is unclear.
>
> Ready? Let's start timing."

**Actions:**
- [ ] Start timer (45 minutes)
- [ ] Hand user printed or digital copy of `docs/quickstart.md` ONLY
- [ ] No other documentation allowed
- [ ] Observe silently; note confusion points

### Phase 2: Workflow Execution (45 minutes)

**User's Task:** Complete the full workflow as described in the guide:

1. **Setup** (2 min) - Create project directories
2. **Research Question** (5 min) - Formulate RQ (can use esophageal cancer example)
3. **Paper Selection** (5-10 min) - Prepare 5 sample papers (use examples provided)
4. **Microscope Extraction** (15-20 min) - Extract data from 2-3 papers using Microscope prompt
5. **Compiler** (2 min) - Compile data cards into CSV
6. **Oracle** (5 min) - Generate analysis code
7. **Interpretation** (5 min) - Understand results

**Tester's Role:**
- [ ] **DO NOT HELP** with technical issues unless guide is wrong
- [ ] Observe silently
- [ ] Note timestamps for each phase completion
- [ ] Record: confusion points, pauses, questions asked
- [ ] Mark: which sections were unclear
- [ ] Watch for: blockers that prevent progress

**Observation Template:**

| Time | Phase | What User Did | Confusion? | Questions? | Blocker? |
|------|-------|---|---|---|---|
| 0:00 | Setup | Created directories | [ ] Y [ ] N | | [ ] Y [ ] N |
| | | | | | |

---

### Phase 3: Validation (when workflow complete or 45 min elapsed)

**Validation Checklist - Can the user demonstrate understanding?**

Ask these questions (user should answer without looking at guide):

1. **Three-Color Labeling:** "What does 🟢 mean vs 🟡 vs 🔴?"
   - [ ] Correct (Green=direct, Yellow=computed, Red=uncertain)
   - [ ] Partially correct
   - [ ] Incorrect

2. **Pooled Effect Size:** "What does HR 2.94 mean in our example?"
   - [ ] Correct (3x increased risk, CTC+ higher mortality)
   - [ ] Partially correct
   - [ ] Incorrect

3. **Heterogeneity:** "What does I² = 62.5% tell us?"
   - [ ] Correct (Substantial variation between studies)
   - [ ] Partially correct
   - [ ] Incorrect

4. **Data Quality:** "What does our 🟢55% / 🟡35% / 🔴10% distribution mean?"
   - [ ] Correct (55% directly from papers, 35% computed, 10% uncertain)
   - [ ] Partially correct
   - [ ] Incorrect

5. **Next Steps:** "If you wanted to add more papers, what would you do?"
   - [ ] Correct (Repeat Microscope for each paper, then re-compile and re-analyze)
   - [ ] Partially correct
   - [ ] Incorrect

---

### Phase 4: Feedback Interview (10-15 minutes)

**Open-Ended Questions:**

1. "What was the most confusing part of the guide?"
2. "Were there any sections that were unclear or hard to follow?"
3. "What did you find most helpful?"
4. "Is there anything missing from the guide?"
5. "Would you feel confident doing this with your own data?"
6. "Rate clarity (1-5): _____ | Rate completeness (1-5): _____"

**Record Response:**

User A Feedback:
```
Q1 Confusion: _______________
Q2 Unclear: _______________
Q3 Helpful: _______________
Q4 Missing: _______________
Q5 Confidence: _______________
Q6 Ratings: Clarity ___ | Completeness ___
Notes: _______________
```

User B Feedback:
```
Q1 Confusion: _______________
Q2 Unclear: _______________
Q3 Helpful: _______________
Q4 Missing: _______________
Q5 Confidence: _______________
Q6 Ratings: Clarity ___ | Completeness ___
Notes: _______________
```

---

## Validation Criteria (PASS/FAIL)

### PASS Criteria (All must be true):
- [ ] **User A:** Completed workflow within 45 minutes
- [ ] **User B:** Completed workflow within 45 minutes
- [ ] **User A:** Zero blocking errors (guide was sufficient)
- [ ] **User B:** Zero blocking errors (guide was sufficient)
- [ ] **User A:** Correctly answered ≥3 of 5 understanding questions
- [ ] **User B:** Correctly answered ≥3 of 5 understanding questions
- [ ] **User A:** Rated clarity ≥4/5
- [ ] **User B:** Rated clarity ≥4/5
- [ ] **All code snippets:** Functional (no syntax errors)
- [ ] **All links:** Working (no broken references)
- [ ] **Emoji rendering:** Correct in data cards and CSV

### FAIL Criteria (Any of these):
- [ ] Either user exceeded 45 minutes
- [ ] Either user encountered blocking error not addressed in guide
- [ ] Either user scored <3/5 on understanding questions
- [ ] Either user rated clarity <3/5
- [ ] Code snippets have syntax errors
- [ ] Multiple broken documentation links
- [ ] Emoji rendering garbled

---

## Data Collection

### Time Log

**User A:**
- Setup completed: _______ min
- Research question: _______ min
- Paper selection: _______ min
- Microscope extraction (2-3 papers): _______ min
- Compiler: _______ min
- Oracle: _______ min
- Interpretation: _______ min
- **Total time: _______ min** | Target: <45 min | ✅ PASS / ❌ FAIL

**User B:**
- Setup completed: _______ min
- Research question: _______ min
- Paper selection: _______ min
- Microscope extraction (2-3 papers): _______ min
- Compiler: _______ min
- Oracle: _______ min
- Interpretation: _______ min
- **Total time: _______ min** | Target: <45 min | ✅ PASS / ❌ FAIL

### Confusion/Blocker Log

**User A - Confusion Points:**
1. Section: _____________ | Issue: _____________ | Resolved: ✅ / ❌
2. Section: _____________ | Issue: _____________ | Resolved: ✅ / ❌
3. Section: _____________ | Issue: _____________ | Resolved: ✅ / ❌

**User B - Confusion Points:**
1. Section: _____________ | Issue: _____________ | Resolved: ✅ / ❌
2. Section: _____________ | Issue: _____________ | Resolved: ✅ / ❌
3. Section: _____________ | Issue: _____________ | Resolved: ✅ / ❌

### Understanding Assessment

| Question | User A | User B |
|----------|--------|--------|
| Three-color labeling | ✅ / 🟡 / ❌ | ✅ / 🟡 / ❌ |
| HR 2.94 meaning | ✅ / 🟡 / ❌ | ✅ / 🟡 / ❌ |
| I² = 62.5% interpretation | ✅ / 🟡 / ❌ | ✅ / 🟡 / ❌ |
| Data quality distribution | ✅ / 🟡 / ❌ | ✅ / 🟡 / ❌ |
| Next steps (adding papers) | ✅ / 🟡 / ❌ | ✅ / 🟡 / ❌ |
| **Score** | __/5 | __/5 |

---

## Results Summary

### Overall Assessment

**FINAL RESULT: ✅ PASS / ⏳ CONDITIONAL PASS / ❌ FAIL**

**Time Performance:**
- User A: _____ min (Target: <45 min)
- User B: _____ min (Target: <45 min)
- Average: _____ min

**Understanding:**
- User A: __/5 correct (Target: ≥3)
- User B: __/5 correct (Target: ≥3)

**Clarity Rating:**
- User A: __/5 (Target: ≥4)
- User B: __/5 (Target: ≥4)

**Blockers Encountered:**
- User A: [ ] None [ ] Minor (resolved in guide) [ ] Major (guide insufficient)
- User B: [ ] None [ ] Minor (resolved in guide) [ ] Major (guide insufficient)

---

## Iteration Plan (if FAIL or CONDITIONAL)

**If test results show issues, complete this before final publication:**

| Issue | Priority | Fix | Owner | ETA |
|-------|----------|-----|-------|-----|
| | HIGH / MED / LOW | | | |
| | | | | |

---

## Sign-Off

**Tester Name:** _________________ | **Date:** _________________ | **Signature:** _________________

**Test User A:** _________________ | **Date:** _________________ | **Signature:** _________________

**Test User B:** _________________ | **Date:** _________________ | **Signature:** _________________

---

**Protocol Version:** 1.0 | **Created:** 2025-10-23 | **Status:** Ready for Execution
