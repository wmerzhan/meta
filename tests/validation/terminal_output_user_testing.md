# Terminal Output User Testing Results

<!-- Powered by BMAD™ Core -->

**Story:** 1.6 - Test Microscope with Sample Papers
**Purpose:** Validate terminal output readability with non-technical users (AC #9)
**Testing Date:** [Date]

## Testing Overview

**Goal:** Validate that Microscope prompt output is readable and usable for researchers without programming background

**Participants:** [N] non-technical users (researchers, not developers)

**Platforms tested:**
- Windows Terminal (Windows 10+)
- macOS Terminal.app
- Linux terminal (Ubuntu or similar)

## Test Scenario

### Materials Provided

1. **Written instructions** based on `docs/microscope-usage.md`
2. **Sample paper** (medium-complexity RCT selected)
3. **Microscope prompt** (`prompts/microscope/microscope_v1.0.md`)

### Test Protocol

1. Ask user to open Claude Code
2. Provide Microscope prompt and sample paper
3. Ask user to complete extraction workflow
4. Ask user to save resulting data card to file
5. Observe user during process (screen share or in-person)
6. Ask user to "think aloud" during extraction
7. Gather feedback via questionnaire

### Observation Method

- [ ] Screen sharing (remote)
- [ ] In-person observation
- [ ] Screen recording
- [ ] Think-aloud protocol

## Participant Demographics

| Participant ID | Role | Research Discipline | Programming Experience | Platform |
|---------------|------|-------------------|----------------------|----------|
| P1 | [e.g., PhD Student] | [e.g., Psychology] | [None/Minimal/Some] | [Windows/macOS/Linux] |
| P2 | | | | |
| P3 | | | | |

## Evaluation Results

### Aspect 1: Emoji Visibility (🟢🟡🔴)

**Question:** Can participants clearly see three-color emojis in terminal output?

| Participant | Platform | 🟢 Visible? | 🟡 Visible? | 🔴 Visible? | Pass/Fail | Notes |
|-------------|----------|-----------|-----------|-----------|-----------|-------|
| P1 | [Platform] | [Y/N] | [Y/N] | [Y/N] | [P/F] | |
| P2 | [Platform] | [Y/N] | [Y/N] | [Y/N] | [P/F] | |
| P3 | [Platform] | [Y/N] | [Y/N] | [Y/N] | [P/F] | |

**Overall Result:** [PASS/FAIL]

**Issues identified:**
- [Issue or "None"]

**Recommendations:**
- [Recommendation or "No changes needed"]

---

### Aspect 2: Markdown Rendering

**Question:** Are markdown tables and headers readable in terminal?

| Participant | Platform | Tables Aligned? | Headers Clear? | Lists Readable? | Pass/Fail | Notes |
|-------------|----------|----------------|---------------|----------------|-----------|-------|
| P1 | [Platform] | [Y/N] | [Y/N] | [Y/N] | [P/F] | |
| P2 | [Platform] | [Y/N] | [Y/N] | [Y/N] | [P/F] | |
| P3 | [Platform] | [Y/N] | [Y/N] | [Y/N] | [P/F] | |

**Overall Result:** [PASS/FAIL]

**Issues identified:**
- [Issue or "None"]

**Example problematic output:**
```
[If tables don't align, show example]
```

**Recommendations:**
- [Recommendation or "No changes needed"]

---

### Aspect 3: YAML Clarity

**Question:** Can participants identify YAML frontmatter section?

| Participant | Platform | Recognizes `---` Delimiters? | Understands YAML Structure? | Pass/Fail | Notes |
|-------------|----------|---------------------------|---------------------------|-----------|-------|
| P1 | [Platform] | [Y/N] | [Y/N] | [P/F] | |
| P2 | [Platform] | [Y/N] | [Y/N] | [P/F] | |
| P3 | [Platform] | [Y/N] | [Y/N] | [P/F] | |

**Overall Result:** [PASS/FAIL]

**Issues identified:**
- [Issue or "None"]

**Recommendations:**
- [Recommendation or "No changes needed"]

---

### Aspect 4: Error Message Clarity

**Question:** If errors occur, are they understandable to non-technical users?

| Participant | Error Encountered? | Error Type | Could User Interpret? | Pass/Fail | Notes |
|-------------|------------------|-----------|---------------------|-----------|-------|
| P1 | [Y/N] | [Type] | [Y/N] | [P/F] | |
| P2 | [Y/N] | [Type] | [Y/N] | [P/F] | |
| P3 | [Y/N] | [Type] | [Y/N] | [P/F] | |

**Overall Result:** [PASS/FAIL]

**Example error messages:**
```
[Show any confusing error messages encountered]
```

**Recommendations:**
- [Recommendation or "No changes needed"]

---

### Aspect 5: Instruction Clarity

**Question:** Could participant complete task following documentation?

| Participant | Completed Extraction? | Saved Data Card? | Needed Help? | Pass/Fail | Notes |
|-------------|---------------------|----------------|-------------|-----------|-------|
| P1 | [Y/N] | [Y/N] | [Y/N] | [P/F] | |
| P2 | [Y/N] | [Y/N] | [Y/N] | [P/F] | |
| P3 | [Y/N] | [Y/N] | [Y/N] | [P/F] | |

**Overall Result:** [PASS/FAIL]

**Help requested:**
- [What users needed help with, or "None"]

**Recommendations:**
- [Improvements to documentation]

---

### Aspect 6: Confusion Points

**Question:** Where did participants get stuck or confused?

#### Confusion Point 1: [Name]

**Description:** [What confused users]

**Frequency:** [N/Total participants]

**Severity:** [High/Medium/Low]

**User Quotes:**
> "[Verbatim user feedback]"

**Root Cause:** [Analysis]

**Recommended Fix:**
- [How to address in documentation or prompt]

#### Confusion Point 2: [Name]

_Repeat for each confusion point..._

---

## Cross-Platform Testing

### Windows Terminal

**Version:** [e.g., Windows Terminal 1.x on Windows 11]

**Issues identified:**
- [Issue or "None"]

**Emoji rendering:** [Excellent/Good/Poor]

**Table alignment:** [Excellent/Good/Poor]

**Overall assessment:** [PASS/FAIL]

---

### macOS Terminal.app

**Version:** [e.g., Terminal 2.x on macOS 14.x]

**Issues identified:**
- [Issue or "None"]

**Emoji rendering:** [Excellent/Good/Poor]

**Table alignment:** [Excellent/Good/Poor]

**Overall assessment:** [PASS/FAIL]

---

### Linux Terminal

**Distribution:** [e.g., Ubuntu 22.04 with GNOME Terminal]

**Issues identified:**
- [Issue or "None"]

**Emoji rendering:** [Excellent/Good/Poor]

**Table alignment:** [Excellent/Good/Poor]

**Overall assessment:** [PASS/FAIL]

---

## User Feedback Summary

### Positive Feedback

**What worked well:**
1. [Positive feedback from users]
2. [Positive feedback from users]
3. [Positive feedback from users]

**User Quotes:**
> "[Verbatim positive feedback]"

---

### Critical Feedback

**What needs improvement:**
1. [Critical feedback from users]
2. [Critical feedback from users]
3. [Critical feedback from users]

**User Quotes:**
> "[Verbatim critical feedback]"

---

### Suggestions

**User recommendations:**
1. [User suggestion]
2. [User suggestion]
3. [User suggestion]

---

## Quantitative Results

### Task Completion

- **Successfully completed extraction:** [N]/[Total] participants ([X%])
- **Successfully saved data card:** [N]/[Total] participants ([X%])
- **Completed without assistance:** [N]/[Total] participants ([X%])

### Time to Completion

| Participant | Time to Complete | Notes |
|-------------|-----------------|-------|
| P1 | [X minutes] | |
| P2 | [X minutes] | |
| P3 | [X minutes] | |

**Mean time:** [X] minutes

### Satisfaction Rating

**Question:** "On a scale of 1-5, how easy was it to use Microscope?"
- 1 = Very difficult
- 5 = Very easy

| Participant | Rating | Comments |
|-------------|--------|----------|
| P1 | [1-5] | |
| P2 | [1-5] | |
| P3 | [1-5] | |

**Mean rating:** [X.X] / 5

---

## Recommendations for Documentation Updates

Based on user testing results:

### `docs/microscope-usage.md` Updates

1. **Add terminal compatibility section**
   - Recommended terminals: Windows Terminal, macOS Terminal.app, GNOME Terminal
   - Not recommended: cmd.exe (limited emoji support)

2. **Add troubleshooting guidance**
   - [Issue]: [How to fix]
   - [Issue]: [How to fix]

3. **Clarify confusing instructions**
   - [Section]: [How to improve]
   - [Section]: [How to improve]

4. **Add screenshots/examples**
   - [What to illustrate]
   - [What to illustrate]

### Prompt Modifications

_If testing reveals prompt-level issues:_

1. **[Issue requiring prompt change]**
   - Current behavior: [Description]
   - Recommended change: [How to fix in prompt]

2. **[Issue requiring prompt change]**
   - Current behavior: [Description]
   - Recommended change: [How to fix in prompt]

---

## Overall Assessment

### Terminal Output Usability

**Result:** [PASS / FAIL / CONDITIONAL]

**Rationale:**

_If PASS:_
- Terminal output is readable across all tested platforms
- Non-technical users can successfully complete extraction
- Minor issues have workarounds documented

_If FAIL:_
- Critical usability issues identified: [List]
- Required fixes: [List]
- Re-testing needed after fixes

_If CONDITIONAL:_
- Works on [platforms] but not on [platforms]
- Users need to [condition] to succeed
- Document limitations clearly for users

### Acceptance Criteria Validation

**AC #9:** Terminal output formatting validated with 2-3 non-technical users for readability

- [x] Tested with [N] non-technical users (target: 2-3)
- [x] Multiple platforms tested (Windows/macOS/Linux)
- [x] Markdown rendering evaluated
- [x] Three-color emoji visibility assessed
- [x] Error message clarity evaluated
- [x] Progress indicator comprehensibility assessed

**Status:** [MET / NOT MET]

---

## Files Modified

Based on user testing findings:

- [ ] `docs/microscope-usage.md` - Added troubleshooting section
- [ ] `docs/microscope-usage.md` - Added terminal compatibility notes
- [ ] `docs/microscope-usage.md` - Clarified confusing instructions
- [ ] `prompts/microscope/microscope_v1.1.md` - Prompt improvements (if needed)
- [ ] `prompts/microscope/CHANGELOG.md` - Documented user testing insights

---

**Testing conducted by:** [Tester name]
**Report completed:** [Date]
**Participants thanked:** [Y/N]
