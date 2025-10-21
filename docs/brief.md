# Project Brief: MAestro

## Executive Summary

**MAestro** is a conversation-driven Meta-analysis workflow system powered by Claude Code that transforms systematic evidence synthesis from a complex, software-intensive process into an accessible, dialogue-based experience. The system addresses the fundamental challenge that traditional Meta-analysis tools require steep learning curves, rigid workflows, and significant technical expertise, limiting accessibility to a small expert community.

**Primary problem:** Conducting rigorous Meta-analyses currently demands mastery of specialized software (RevMan, Stata), statistical programming, and weeks-to-months of manual data processing, creating barriers for individual researchers, small teams, and students.

**Target market:** Individual researchers and small research teams across disciplines (medicine, psychology, education, economics) who need to conduct systematic reviews but lack resources for expensive specialized software or dedicated statistical support.

**Key value proposition:** MAestro serves as an "idea catalyst" rather than a "precision measurement instrument," enabling researchers to complete exploratory Meta-analyses in days rather than weeks through natural language interaction, while maintaining transparency through innovative three-color source labeling and data card architecture.

## Problem Statement

**Current State & Pain Points:**

Meta-analysis—the systematic synthesis of research evidence to answer scientific questions—has become the gold standard for evidence-based decision making across disciplines. However, conducting a rigorous Meta-analysis remains an elite practice:

- **Specialized software barriers:** Tools like RevMan, Stata, or R packages require weeks-to-months of training and ongoing technical proficiency
- **Statistical expertise prerequisite:** Researchers must understand complex concepts (heterogeneity, effect sizes, publication bias, random-effects models) to use tools effectively
- **Rigid, software-dictated workflows:** Existing tools impose fixed processes that don't accommodate disciplinary variations or exploratory approaches
- **Manual data processing burden:** Extracting data from dozens or hundreds of papers into structured formats is tedious, error-prone, and consumes 40-60% of project time
- **Team coordination overhead:** Multi-investigator projects require complex protocols for dual screening, conflict resolution, and version control

**Impact (Quantified):**

- **Timeline:** A typical Meta-analysis takes 6-18 months from protocol to publication, with 2-4 weeks alone spent on data extraction for 20-30 studies
- **Cost:** Commercial platforms (Covidence, DistillerSR) cost $1,500-$5,000+ per year; statistical consultation adds $50-150/hour
- **Accessibility:** Estimated <10% of researchers who could benefit from Meta-analysis methods actually conduct them due to resource constraints
- **Innovation bottleneck:** The high barrier delays rapid evidence synthesis in fast-moving fields (e.g., COVID-19 research, AI safety)

**Why Existing Solutions Fall Short:**

Traditional software tools are designed as "precision measurement instruments"—optimized for publication-grade rigor but at the cost of flexibility and accessibility. They assume:
- Users have dedicated time for software mastery
- Teams have access to statistical support
- Projects follow standardized protocols (PRISMA, Cochrane)
- The goal is always formal publication rather than exploratory insight

**Urgency & Importance:**

The convergence of three factors creates a unique opportunity NOW:
1. **AI capability breakthrough:** Large language models can understand research papers, extract structured data, generate statistical code, and explain complex analyses in natural language
2. **Democratization imperative:** Evidence-based practice is expanding beyond medicine into education, policy, business—but current tools don't scale
3. **Methodological innovation window:** The academic community is actively debating AI use in research, creating space to establish transparent, rigorous standards before norms solidify

## Proposed Solution

**Core Concept & Approach:**

MAestro reimagines Meta-analysis as a **conversation-driven workflow** built on three atomic tools that combine like building blocks:

1. **📌 Microscope:** Deep analysis of individual papers through structured dialogue—screening, quality assessment, and data extraction in one continuous conversation
2. **📌 Compiler:** Aggregation of data fragments from multiple data cards into unified datasets ready for analysis
3. **📌 Oracle:** Natural language interface to statistical analysis—researchers describe what they want to understand, AI translates to code and interprets results

This "Three-Element Toolbox" philosophy delivers maximum flexibility with minimal cognitive load, allowing researchers to compose workflows that match their specific needs rather than conforming to rigid software processes.

**Key Differentiators:**

- **Zero development complexity:** Pure prompt-based workflow leveraging Claude Code's existing capabilities—no custom software to build or maintain
- **Data Card Microservice Architecture:** Each paper generates an independent markdown data card with built-in version control (Git), eliminating fragile long-conversation state management
- **Three-Color Source Labeling System:** Every data point is tagged as 🟢 direct quote + evidence, 🟡 computed inference + calculation, or 🔴 uncertain/missing + warning—transforming AI hallucination risk into transparent data quality stratification
- **Conversation > GUI:** Natural language commands replace repetitive clicking and form-filling; context memory enables continuous refinement without starting over
- **Discipline-agnostic with pluggable modules:** Core workflow universal across fields, with specialized quality assessment tools (medical RoB2, social science Campbell) loaded as needed

**Why This Will Succeed:**

Traditional tools failed to democratize Meta-analysis because they optimized for the wrong goal—they pursued **comprehensiveness** (covering every possible feature) at the cost of **accessibility**. MAestro inverts this:

- **Embraces the 80/20 rule:** Delivers 80% of value for exploratory/rapid assessments with 20% of complexity
- **Meets users where they are:** Leverages familiar paradigms (markdown files, natural conversation, Git) rather than requiring specialized training
- **Transparency as competitive advantage:** Rather than hiding AI involvement, actively surfaces it through source labeling and audit trails (RAAA appendix standard)
- **Three-Stage Human-AI Collaboration:** AI-driven divergent creation → Human-driven convergent validation → AI-assisted polish—each agent does what it does best

**High-Level Product Vision:**

**Near-term (3-6 months):** Validated prompt templates (Microscope, Compiler, Oracle) + data card workflow + best practices documentation = immediate value for individual researchers

**Medium-term (6-12 months):** Discipline-specific module library + PRISMA automation toolkit + academic transparency standards (RAAA appendix) = community adoption and credibility

**Long-term (12-24 months):** CROS (Conversational Research Operating System)—local Python script or VS Code extension that manages project files, orchestrates Claude Code API interactions, and maintains robust conversation state across sessions = production-grade reliability with conversation-first UX

**Ultimate vision:** MAestro becomes the "second brain curator" for evidence synthesis—accumulating personal knowledge bases that compound across projects, enabling researchers to ask meta-questions like "What patterns appear across all nutrition interventions I've analyzed?" and receive instant, evidence-grounded insights.

## Target Users

### Primary User Segment: Individual Academic Researchers (Post-docs & Junior Faculty)

**Demographic/Firmographic Profile:**
- **Position:** Post-doctoral researchers, assistant professors, doctoral candidates in final dissertation stages
- **Disciplines:** Medicine, psychology, education, public health, social sciences, economics
- **Institution type:** Mid-tier universities, teaching-focused institutions, resource-constrained settings
- **Technical background:** Comfortable with academic writing and literature databases; limited statistical programming experience
- **Team structure:** Solo or 2-3 person collaborations; rarely have dedicated research assistants

**Current Behaviors & Workflows:**
- Conduct literature searches using PubMed, Google Scholar, Web of Science
- Manually screen abstracts in Excel or reference managers (Zotero, Mendeley)
- Extract data by hand into spreadsheets with custom-designed columns
- Seek statistical consultation for analysis or attempt to self-learn R/Stata through YouTube tutorials
- Spend 60-80% of project time on mechanical tasks (screening, data entry) vs. intellectual work (interpretation, writing)
- Often abandon Meta-analysis plans mid-project due to overwhelming complexity

**Specific Needs & Pain Points:**
- **"I don't have time to become a programmer"**: Need analysis capabilities without learning R or Python
- **"I can't afford $3,000 software licenses"**: Operate on minimal or zero research budgets
- **"Every paper is slightly different"**: Need flexibility to handle heterogeneous study designs, not rigid templates
- **"I just want to know if this intervention works"**: Exploratory evidence synthesis to inform grant proposals or preliminary research, not always publication-bound
- **"I'm drowning in PDFs"**: Need help processing 50-200 papers efficiently without sacrificing rigor

**Goals They're Trying to Achieve:**
- Synthesize evidence to support grant applications or thesis proposals
- Establish expertise in emerging research areas through comprehensive literature understanding
- Produce exploratory rapid reviews for time-sensitive questions (e.g., curriculum design decisions)
- Learn Meta-analysis methodology in practical, hands-on context
- Build CV with systematic review publications despite limited resources

### Secondary User Segment: Graduate Students & Research Teams in Applied Fields

**Demographic/Firmographic Profile:**
- **Position:** Master's/PhD students, practitioners pursuing part-time research (clinicians, educators, policy analysts)
- **Disciplines:** Evidence-based practice fields—nursing, clinical psychology, educational leadership, social work
- **Technical background:** Minimal to moderate; prioritize practical application over methodological sophistication
- **Time constraints:** Conducting research alongside clinical/teaching duties; project timelines measured in weeks/months, not years

**Current Behaviors & Workflows:**
- Often use simplified review methods (narrative reviews, scoping reviews) instead of Meta-analysis due to perceived complexity
- Rely heavily on advisors or collaborators for statistical aspects
- Prioritize "good enough" evidence synthesis for decision-making over publication-grade rigor
- Use free tools exclusively (Google Sheets, free reference managers)

**Specific Needs & Pain Points:**
- **"I need this for my thesis defense in 3 months"**: Urgent timelines incompatible with traditional Meta-analysis learning curves
- **"My advisor expects statistical rigor but won't pay for software"**: Caught between quality expectations and resource reality
- **"I understand the concepts but not the technical execution"**: Gap between methodological knowledge and implementation skills
- **Learning context**: Need educational scaffolding that explains "why" behind each step, not just "how"

**Goals They're Trying to Achieve:**
- Complete thesis/dissertation requirements demonstrating advanced research skills
- Apply evidence synthesis to real-world practice problems (treatment selection, policy recommendations)
- Develop Meta-analysis competency as career skill without formal biostatistics training
- Collaborate with peers despite geographic distribution

## Goals & Success Metrics

### Business Objectives

- **Validate core workflow by Q2 2026**: 10+ researchers successfully complete end-to-end exploratory Meta-analyses using MAestro three-element toolbox, with documented case studies across 3+ disciplines
- **Achieve 50% time reduction benchmark**: Users complete data extraction phase in 50% less time compared to manual Excel-based workflows, measured through controlled comparison studies
- **Establish academic credibility by end of 2026**: Publish methodology paper in Meta-research journal (e.g., *Research Synthesis Methods*, *Systematic Reviews*) AND secure 3+ testimonials from established Meta-analysis methodologists
- **Build sustainable community by end of 2026**: 100+ active users, 50+ GitHub stars on prompt template repository, 20+ community-contributed discipline modules
- **Secure pathway to CROS development**: Validate technical feasibility through prototype development AND identify funding source (grant, open-source sponsorship, or commercial partnership) by Q4 2026

### User Success Metrics

- **Task completion rate**: 80%+ of users who start with MAestro Microscope complete data extraction for at least 10 papers (indicates usable workflow, not overwhelming)
- **Learning curve**: New users can process their first paper using Microscope within 30 minutes of reading documentation (indicates accessible onboarding)
- **Quality maintenance**: Data extracted via MAestro achieves 90%+ agreement with expert manual extraction on standardized test papers (indicates reliability despite AI involvement)
- **User confidence**: 70%+ of users report feeling "confident" or "very confident" in their ability to conduct Meta-analyses after using MAestro (indicates empowerment, not dependency)
- **Workflow adoption breadth**: Users employ all three elements (Microscope, Compiler, Oracle) in their projects, not just one (indicates ecosystem value, not single-feature utility)

### Key Performance Indicators (KPIs)

- **Adoption velocity**: Number of new users per month who complete at least one full data card | **Target**: 20/month by month 6, 50/month by month 12
- **Prompt template iteration rate**: Versions released based on user feedback | **Target**: Monthly updates for first 6 months, quarterly thereafter (indicates active refinement)
- **Documentation engagement**: Time spent on best practices docs, bounce rate | **Target**: Avg 10+ min session time, <40% bounce rate (indicates quality resources)
- **Academic transparency adoption**: Percentage of users who include RAAA appendix in their reports | **Target**: 60%+ by end of year 1 (indicates cultural norm establishment)
- **Error detection rate**: Percentage of AI-generated data flagged with 🟡 or 🔴 labels that users catch and correct | **Target**: 95%+ (indicates three-color system effectiveness)
- **Session persistence**: Average number of papers processed before workflow abandonment | **Target**: 15+ papers (indicates sustained usability, not novelty effect)

## MVP Scope

### Core Features (Must Have)

- **Microscope Prompt Template v1.0:** Structured prompt for single-paper analysis that guides users through screening decision → quality assessment → data extraction in one conversation. Includes three-color source labeling (🟢 direct quote, 🟡 computed, 🔴 uncertain) embedded directly in output format. **Rationale:** This is the foundational atomic unit—without reliable single-paper processing, nothing else matters.

- **Compiler Prompt Template v1.0:** Aggregation prompt that ingests multiple data cards (markdown files) and generates unified datasets ready for statistical analysis. Outputs standardized CSV/TSV format compatible with R/Python. **Rationale:** Bridges the gap between distributed data cards and analysis tools, proving the microservice architecture works.

- **Oracle Prompt Template v1.0:** Natural language statistical analysis interface that translates research questions ("Is there a significant effect?" "What explains heterogeneity?") into executable R/Python code with annotated interpretations. **Rationale:** Completes the three-element toolbox, demonstrating end-to-end value.

- **Data Card Markdown Format Standard:** Documented structure for storing extracted data as independent .md files with YAML frontmatter (metadata) + markdown tables (data) + three-color labels. Includes Git integration guidance. **Rationale:** Without standardized format, data cards can't be reliably compiled; format must be version 1.0 stable to prevent breaking changes.

- **Quick Start Guide & Best Practices Documentation:** Step-by-step tutorial walking through example Meta-analysis (5-10 papers) plus troubleshooting guide for common failure modes (context limits, ambiguous prompts, formatting errors). **Rationale:** Accessibility depends on frictionless onboarding; documentation is as critical as prompts themselves.

- **RAAA (Reproducible AI-Assisted Analysis) Appendix Template:** Standardized transparency report format documenting prompts used, AI model version, human validation steps, and data quality breakdown by color labels. **Rationale:** Academic credibility requires transparent reporting; providing template removes barrier to adoption.

### Out of Scope for MVP

- **Automated literature search/screening:** Users manually conduct searches and initial screening using existing tools (PubMed, Google Scholar). MAestro enters workflow at full-text review stage.
- **Dual independent screening workflows:** No built-in conflict resolution or blind review protocols for team projects.
- **PRISMA flow diagram automation:** Users manually create flow diagrams; future automation deferred to Phase 2.
- **Discipline-specific quality assessment modules:** MVP uses generic quality checklist; specialized tools (RoB2, Campbell) are post-MVP.
- **CROS (Conversational Research OS):** Local software/VSCode extension deferred to long-term vision; MVP is pure prompt-based workflow.
- **Reference management integration:** No direct Zotero/Mendeley/EndNote connectors; users manually export .ris/.bib and work with text files.
- **Real-time collaboration features:** No shared workspaces or simultaneous multi-user editing; async Git-based collaboration only.
- **Advanced statistical methods:** Oracle v1.0 covers basic pooled effects, heterogeneity (I²), subgroup analysis; meta-regression, publication bias tests, network Meta-analysis are future features.

### MVP Success Criteria

**The MVP is successful if:**

1. **Technical validation:** 5 beta testers (diverse disciplines) each complete data extraction for 10+ papers using Microscope, with 85%+ data accuracy compared to manual extraction
2. **Workflow completeness:** At least 3 beta testers execute full pipeline (Microscope → Compiler → Oracle) and produce interpretable forest plots with statistical summaries
3. **Usability threshold:** Average time-to-first-data-card <45 minutes for new users (from reading docs to completing first paper)
4. **Risk mitigation proof:** Three-color labeling system successfully flags 90%+ of uncertain/computed data in validation studies
5. **Community signal:** Documentation receives positive feedback from 2+ established Meta-analysis methodologists (academic validators) confirming approach is methodologically sound
6. **Sustainability indicator:** At least 2 beta testers volunteer to contribute improvements (prompt refinements, discipline modules, or documentation edits)—proving community-driven model viability

**If these criteria are met, proceed to Phase 2 (discipline modules + PRISMA automation). If not, iterate on core prompts based on failure analysis.**

## Post-MVP Vision

### Phase 2 Features (6-12 months post-MVP)

**Discipline-Specific Module Library:**
Build curated collection of quality assessment tools adapted to major research fields:
- **Medical/Clinical:** Risk of Bias 2 (RoB2), GRADE assessment
- **Social Sciences:** Campbell Collaboration standards, ROBINS-I for observational studies
- **Psychology/Education:** Study design-specific checklists (RCT, quasi-experimental, correlational)
- **Economics:** Internal/external validity frameworks for policy interventions

Each module is a pluggable prompt fragment that integrates seamlessly with Microscope. Community-contributed modules stored in GitHub repository with peer review process.

**PRISMA Automation Toolkit:**
- **Smart Flow Diagram Generator:** Automatically creates PRISMA flow charts by tracking screening decisions across data cards
- **Checklist Wizard:** Interactive template that populates PRISMA 2020 checklist items from project metadata
- **Search Strategy Formatter:** Converts natural language search descriptions into standardized reporting format

**Enhanced Oracle Capabilities:**
- Meta-regression and moderator analysis (exploring "what explains heterogeneity?")
- Publication bias assessment (funnel plots, Egger's test, trim-and-fill)
- Sensitivity analyses (leave-one-out, influence diagnostics)
- Network Meta-analysis basics (multiple treatment comparisons)

**Collaboration Enhancements:**
- Dual-screening protocol templates with conflict resolution workflows
- Standardized team handoff documents (data card assignment, progress tracking)
- Quality control sampling protocols (random 10% re-extraction for validation)

### Long-term Vision (12-24 months)

**CROS: Conversational Research Operating System**

Evolution from prompt-based workflow to integrated local application:

- **Architecture:** Lightweight Python CLI or VS Code extension that orchestrates Claude Code API interactions
- **Key capabilities:**
  - Persistent project state management across sessions (no context loss)
  - Automated data card lifecycle (create → validate → compile → archive)
  - Smart prompt routing (automatically selects Microscope vs. Compiler vs. Oracle based on user intent)
  - Batch processing (process multiple papers in parallel with progress tracking)
  - Built-in quality checks (validates data card format, flags inconsistencies)

- **User experience:** Feels like conversational interface but with software-grade reliability—"best of both worlds"

**Personal Knowledge Base Ecosystem:**

Transform MAestro from single-project tool to lifelong research companion:

- **My_MA_Knowledge_Base.md:** Cumulative record of all Meta-analyses conducted, extractable insights, methodological learnings
- **Cross-project queries:** "Show me all education interventions with effect sizes >0.5 from my past work"
- **Pattern detection:** AI identifies recurring themes across researcher's entire evidence portfolio
- **Knowledge compounding:** Each project enriches future projects (reusable data, refined prompts, domain expertise)

**Academic Standard Establishment:**

- **AAER (AI-Accelerated Exploratory Review) designation:** Recognized research category distinct from traditional systematic reviews
- **Journal partnerships:** Collaborate with Meta-research journals to pilot AI transparency standards
- **Methodological validation studies:** Publish comparison studies demonstrating MAestro reliability vs. traditional tools

### Expansion Opportunities

**Beyond Quantitative Meta-Analysis:**

- **Qualitative systematic reviews:** Adapt Microscope for thematic extraction, argument mapping, narrative synthesis
- **Umbrella reviews:** "Meta-Meta-analysis"—synthesizing existing systematic reviews
- **Scoping reviews:** Rapid evidence mapping without statistical pooling
- **Realist synthesis:** Theory-driven reviews focusing on context-mechanism-outcome patterns

**Cross-Domain Applications:**

- **Market intelligence synthesis:** Aggregate competitor analyses, customer research, industry reports
- **Legal research:** Systematic case law analysis, precedent mapping, statutory interpretation
- **Policy analysis:** Evidence briefs for government decision-making, legislative impact assessment
- **Due diligence:** M&A research aggregation, risk assessment synthesis

**Personal Knowledge Management:**

- **Academic reading companion:** Process literature as you read, building personal evidence repositories
- **Second brain integration:** Connect with Obsidian, Roam Research, Notion ecosystems
- **Literature review automation:** Generate comprehensive literature reviews for grant proposals, dissertations

**Educational Market:**

- **Methods training platform:** Use MAestro as teaching tool for evidence synthesis courses
- **Student sandbox:** Low-stakes environment to learn Meta-analysis principles without software complexity
- **Certification programs:** "MAestro-certified researcher" credentials for CV-building

## Technical Considerations

### Platform Requirements

- **Target Platforms:** Cross-platform (Windows, macOS, Linux) via Claude Code CLI/Desktop application
- **Browser/OS Support:**
  - MVP: No browser requirements (pure terminal/desktop workflow)
  - CROS phase: VS Code extension requires VS Code 1.80+ on any OS
- **Performance Requirements:**
  - Microscope: Process single paper in <5 minutes (primarily AI response time, not compute-bound)
  - Compiler: Aggregate 100 data cards into unified dataset in <30 seconds
  - Oracle: Generate statistical analysis code + interpretation in <2 minutes
  - No real-time requirements; batch/async processing acceptable

### Technology Preferences

**Frontend:**
- **MVP Phase:** No frontend—pure markdown files + terminal interaction with Claude Code
- **CROS Phase:**
  - **Option 1 (Preferred):** VS Code extension using TypeScript + Webview API for rich UI components
  - **Option 2:** Python CLI with rich terminal UI (using `rich` library for formatting)
  - **Rationale:** VS Code extension aligns with developer/researcher workflows; Python CLI provides lighter alternative

**Backend:**
- **MVP Phase:** No backend—stateless prompt execution via Claude Code
- **CROS Phase:**
  - **API Integration:** Anthropic Claude API (claude-3.5-sonnet or successor models)
  - **State Management:** Local filesystem + SQLite for project metadata, conversation history
  - **Processing Engine:** Python 3.9+ for orchestration logic
  - **Rationale:** Local-first architecture ensures data privacy, works offline (except API calls), no server costs

**Database:**
- **MVP Phase:** Filesystem as database—markdown files are data source
- **CROS Phase:**
  - **SQLite** for structured metadata (project configs, processing logs, quality metrics)
  - **Filesystem** remains primary data store (data cards, outputs) for transparency and Git compatibility
  - **No cloud database**—all data remains local
  - **Rationale:** SQLite provides query capabilities without deployment complexity; filesystem ensures human-readable audit trail

**Hosting/Infrastructure:**
- **MVP Phase:**
  - GitHub repository for prompt templates, documentation (GitHub Pages for docs site)
  - No hosting costs—users run locally
- **CROS Phase:**
  - **Deployment:** Distributed via PyPI (Python package) or VS Code Marketplace (extension)
  - **Updates:** Standard package manager channels (pip, VS Code auto-update)
  - **Telemetry:** Optional, privacy-respecting usage analytics (opt-in only, anonymous)
- **No cloud services required** beyond Anthropic API
- **Rationale:** Local-first minimizes operational costs, maximizes user privacy/control

### Architecture Considerations

**Repository Structure:**
```
maestro/
├── prompts/              # Core prompt templates
│   ├── microscope_v1.md
│   ├── compiler_v1.md
│   └── oracle_v1.md
├── modules/              # Discipline-specific modules
│   ├── medical/
│   ├── psychology/
│   └── education/
├── templates/            # Document templates
│   ├── data_card.md
│   ├── raaa_appendix.md
│   └── project_template/
├── docs/                 # Documentation
│   ├── quickstart.md
│   ├── best_practices.md
│   └── examples/
├── tools/                # CROS phase only
│   ├── cli/              # Python CLI tool
│   └── vscode-extension/ # VS Code extension
└── tests/                # Validation datasets
```

**Service Architecture:**
- **MVP:** Single-tier—user interacts directly with Claude Code using prompt templates
- **CROS (Future):**
  ```
  User ↔ CROS Interface (CLI/VS Code) ↔ Claude API
                ↓
         Local Filesystem
         (Data Cards, Config)
                ↓
         SQLite (Metadata)
  ```
  - **No microservices**—monolithic local application for simplicity
  - **Modular design** allows prompt swapping without code changes

**Integration Requirements:**
- **Claude API:** RESTful API integration with retry logic, rate limiting, cost tracking
- **Git (Optional):** Shell commands for version control automation (`git add`, `git commit`)
- **Statistical Tools:** Output format compatible with R (readr::read_csv) and Python (pandas.read_csv)
- **Reference Managers (Future):** Parse .ris, .bib, .nbib formats for bibliography import
- **Export Formats:** Markdown, CSV, JSON for maximum interoperability

**Security/Compliance:**
- **Data Privacy:** All research data stays local; only prompts + paper text sent to Claude API
- **API Key Management:** Secure storage using OS keychain (macOS Keychain, Windows Credential Manager, Linux Secret Service)
- **Sensitive Data Handling:** User warnings against including PHI, PII in prompts; optional redaction helpers
- **Compliance Considerations:**
  - **GDPR:** Local-first architecture naturally compliant (no data transmission to MAestro servers)
  - **Research Ethics:** Documentation includes guidance on IRB considerations for AI-assisted research
  - **Intellectual Property:** Clear licensing (MIT or Apache 2.0 for code, CC-BY for templates) to enable academic reuse
- **Audit Trail:** All Claude API interactions logged locally with timestamps for reproducibility verification

## Constraints & Assumptions

### Constraints

**Budget:**
- **MVP Phase:** $0 development budget—pure volunteer/founder effort
- **Testing Phase:** ~$500-1,000 for Claude API costs during beta testing (5-10 users × 10-20 papers each)
- **CROS Phase:** Unfunded until grant secured or sponsorship obtained; bootstrap approach using open-source contributions
- **Assumption:** No paid staff until product-market fit validated and funding secured

**Timeline:**
- **MVP Development:** 6-8 weeks for three prompt templates + documentation (assumes 20-30 hrs/week effort)
- **Beta Testing:** 8-12 weeks for user validation across disciplines
- **Iteration Cycles:** 2-week sprints for prompt refinement based on feedback
- **Phase 2 Entry:** Contingent on MVP success criteria; no fixed timeline
- **Hard Constraint:** Must achieve measurable traction within 12 months to justify continued investment

**Resources:**
- **Team:** Solo founder initially; relying on open-source community contributions for scaling
- **Expertise Access:** Limited—need to recruit Meta-analysis methodologists and statisticians as advisors/validators (unpaid or equity-based)
- **User Recruitment:** Beta testers from personal academic network (limited to ~10-20 initial contacts)
- **Infrastructure:** GitHub free tier, personal Claude API account
- **Constraint:** No marketing budget; growth entirely organic (word-of-mouth, academic Twitter, r/scholar)

**Technical:**
- **Claude API Limitations:**
  - Context window: Currently 200K tokens (~150K words); long papers may exceed limits
  - Rate limits: API throttling may slow batch processing
  - Cost per request: ~$0.03-0.15 per paper (varies with length); users must fund their own API usage
  - Model updates: Anthropic may change models, requiring prompt re-validation
- **No Mobile Support:** Terminal/desktop workflow incompatible with mobile devices (deliberate choice)
- **Plain Text Only (MVP):** Cannot process scanned PDFs or images without OCR preprocessing
- **No Real-Time Collaboration:** Git-based async only; no live co-editing features
- **Statistical Limitations:** Oracle v1.0 limited to frequentist methods; Bayesian Meta-analysis out of scope

### Key Assumptions

**About Users:**
- Target users (post-docs, students) have Claude API access or willingness to pay $20/month for Claude Pro subscription
- Users are comfortable with markdown, Git, and terminal/CLI interfaces (or willing to learn)
- Academic researchers will trust AI-assisted workflows if transparency mechanisms (three-color labeling, RAAA appendix) are robust
- Users prefer speed/accessibility over publication-grade rigor for exploratory analyses (the "idea catalyst" positioning resonates)
- The 10% of researchers currently blocked by complexity barriers represents sufficient market size (~thousands globally)

**About Technology:**
- Claude Code's NLU, data extraction, and code generation capabilities are sufficient for Meta-analysis tasks without fine-tuning
- Three-color source labeling can be reliably implemented through prompt engineering alone (no model modifications needed)
- Claude API pricing and performance will remain stable enough for users to complete multi-week projects
- Markdown + Git provides "good enough" state management for MVP; CROS development needed only if workflow proves valuable
- Python/VS Code ecosystem adoption among researchers will continue growing

**About Market/Adoption:**
- Academic community's AI skepticism will decrease as transparency standards emerge
- Journals will accept AI-assisted research if methodology is disclosed (RAAA appendix sufficient)
- Early adopters exist who are willing to experiment with unconventional workflows
- Word-of-mouth in academic networks is sufficient for initial growth (no paid acquisition needed)
- Open-source model will attract contributors once value is demonstrated

**About Competition:**
- Traditional tools (RevMan, Covidence) will not rapidly adopt conversational AI interfaces due to organizational inertia
- Commercial vendors will not view MAestro as competitive threat (different market segment)
- No well-funded startup is currently building AI-first Meta-analysis tools (window of opportunity exists)

**About Academic/Regulatory Environment:**
- Research ethics boards will not prohibit AI-assisted evidence synthesis (remains acceptable practice)
- No new regulations will restrict academic use of LLMs for research
- Meta-analysis methodologists will engage constructively rather than dismiss AI approaches outright
- Sufficient methodological flexibility exists to define "exploratory Meta-analysis" as distinct category

**Critical Assumptions Requiring Validation:**
1. **Data extraction accuracy:** Can Claude achieve 90%+ agreement with expert manual extraction? (MVP validation will test)
2. **Context reliability:** Does three-color labeling successfully flag 90%+ of uncertain inferences? (Beta testing essential)
3. **User willingness to pay:** Will users fund their own API costs (~$3-10 per project)? (Pricing sensitivity unknown)
4. **Prompt stability:** Will prompts remain effective across Claude model updates? (Version tracking critical)
5. **Community contribution:** Will users contribute discipline modules without compensation? (Open-source model viability)

## Risks & Open Questions

### Key Risks

- **AI Hallucination in Data Extraction:** AI may generate plausible but incorrect numerical data (e.g., fabricating effect sizes, confidence intervals). **Impact:** Compromises research integrity; could lead to false conclusions. **Mitigation:** Three-color labeling system flags all computed/uncertain data; require human verification of all 🟡 and 🔴 labeled items; validation studies comparing AI vs. expert extraction.

- **Long Conversation Context Loss:** Processing 50+ papers in single conversation may exceed context limits or degrade AI memory of earlier extractions. **Impact:** Inconsistent data extraction criteria; loss of project-specific conventions. **Mitigation:** Data card microservice architecture isolates each paper; master_data.md serves as external memory; CROS phase implements persistent state management.

- **Academic Credibility Barrier:** Meta-analysis community may reject AI-assisted research as methodologically unsound or ethically problematic. **Impact:** Publications rejected; methodology paper unpublishable; user adoption stalls. **Mitigation:** RAAA appendix provides unprecedented transparency; position as "exploratory" not "publication-grade"; secure endorsements from established methodologists during beta phase.

- **Prompt Brittleness Across Model Updates:** Anthropic model changes could break carefully tuned prompts, invalidating months of optimization work. **Impact:** Workflow breaks; users lose confidence; requires emergency re-engineering. **Mitigation:** Version pin specific Claude models in documentation; maintain prompt library across model versions; build CROS with model abstraction layer for future-proofing.

- **User API Cost Sensitivity:** Students/researchers may abandon workflow if per-project costs exceed $10-15. **Impact:** Limits addressable market to well-funded users; contradicts "democratization" mission. **Mitigation:** Optimize prompts for token efficiency; provide cost estimation tools upfront; explore grant funding for student API subsidies; document "BYOK" (bring your own key) option for institutional accounts.

- **Insufficient Differentiation from ChatGPT + Manual Prompting:** Users may realize they can achieve similar results using generic ChatGPT without MAestro framework. **Impact:** No moat; zero network effects; commoditization. **Mitigation:** Deliver genuine value through prompt engineering expertise, standardized formats, validated workflows, community discipline modules; CROS phase adds proprietary orchestration layer.

- **Solo Founder Burnout:** Project depends on single individual's sustained effort without compensation. **Impact:** Development stalls; community loses momentum; project abandonment. **Mitigation:** Set realistic scope limits (MVP discipline); recruit co-maintainers early; apply for open-source grants (Mozilla, Chan Zuckerberg Initiative); define "good enough to hand off" criteria.

- **Regulatory/Ethical Constraints Emerge:** IRBs or funding agencies may prohibit AI-assisted data extraction in human subjects research. **Impact:** Entire user segment (medical/clinical researchers) becomes inaccessible. **Mitigation:** Proactive engagement with research ethics community; publish transparency standards ahead of regulations; position as "decision support" not "autonomous agent."

### Open Questions

**Methodological:**
- What level of inter-rater reliability (Cohen's kappa) should we expect between AI and human extractors? Is 0.8 sufficient, or do we need 0.9+?
- Can three-color labeling reliably distinguish between direct quotes, valid computations, and hallucinations? What false positive/negative rates are acceptable?
- How do we validate statistical analyses generated by Oracle? Should every analysis require manual code review by statistician?
- Should MAestro support multiple AI extractors (ensemble approach) for critical projects, or is single-pass adequate for exploratory use?
- What proportion of "exploratory" Meta-analyses eventually need upgrading to "publication-grade"? Does MAestro create technical debt?

**Technical:**
- What is optimal prompt length vs. accuracy trade-off? Longer prompts improve specificity but increase costs and may degrade performance.
- Can data card compilation scale to 500+ papers, or do we hit filesystem/memory limits?
- Should CROS use streaming API for real-time feedback, or batch processing with progress tracking?
- How do we handle multi-modal papers (equations, complex tables, figures)? Is text-only extraction fatally limiting?
- What's the backup plan if Anthropic significantly raises API prices or discontinues public access?

**User Experience:**
- Will non-technical users actually learn markdown, Git, and terminal workflows? Or do we need GUI from day one?
- How much documentation is "enough"? Can we achieve <30min time-to-first-data-card with text tutorials, or do we need video walkthroughs?
- What error recovery UX is needed when prompts fail? Should we provide troubleshooting flowcharts, example fixes, or direct support?
- Do users want prescriptive workflows ("follow these 10 steps") or flexible toolbox ("combine tools as needed")? Does this vary by experience level?

**Business/Sustainability:**
- Can open-source model sustain development long-term, or does commercialization become necessary?
- What monetization models are compatible with academic values (freemium, institutional licensing, training workshops, grant-funded development)?
- Should we pursue academic publication first (credibility) or user growth first (validation)? Which builds on which?
- Is there appetite for "MAestro as a service" (hosted version) among institutions with API cost concerns, or is local-first non-negotiable?

**Market/Adoption:**
- Are there cultural/linguistic barriers to adoption outside English-speaking academia? Does Claude perform equally well on papers in Chinese, Spanish, etc.?
- Will established researchers use MAestro, or only early-career/students? Does "expert adoption" matter for credibility, or is grassroots sufficient?
- How do we compete for attention in already crowded research tool landscape (Zotero, Mendeley, Notion, Obsidian all vying for researcher mindshare)?
- Is Meta-analysis the right beachhead, or should we pivot to adjacent markets (systematic reviews, literature reviews, evidence synthesis) if traction is slow?

### Areas Needing Further Research

- **Benchmark Dataset Creation:** Develop standardized test corpus of 20-30 papers with expert-validated "gold standard" extractions for quantitative accuracy testing
- **Multi-Discipline Validation:** Test workflow across medicine, psychology, education, economics to identify discipline-specific failure modes
- **Cost-Benefit Analysis:** Quantify time savings vs. accuracy trade-offs compared to traditional workflows through controlled user studies
- **Prompt Optimization Research:** Systematic experimentation with prompt variations (length, structure, examples) to maximize accuracy and minimize cost
- **Conversation Length Limits:** Empirical testing of Claude's context retention across 10, 25, 50, 100+ paper processing sessions
- **Statistical Code Verification:** Develop automated testing framework to validate Oracle-generated R/Python code against known results
- **Academic Stakeholder Interviews:** Survey journal editors, IRB members, Meta-analysis experts on AI acceptance criteria
- **Competitive Intelligence:** Deep dive into RevMan, Covidence, DistillerSR roadmaps—are they planning AI features?
- **Alternative LLM Evaluation:** Test GPT-4, Gemini, open-source models (Llama, Mistral) as potential Claude alternatives for cost/performance optimization
- **Long-Term Reproducibility:** Track prompt performance degradation over 6-12 months as Claude models evolve

## Appendices

### A. Research Summary

This Project Brief is informed by comprehensive brainstorming conducted on October 18, 2025, using structured ideation techniques (First Principles Thinking, Mind Mapping, SCAMPER, Six Thinking Hats). Full session results documented in `docs/brainstorming-session-results.md`.

**Key findings that shaped this brief:**

**From First Principles Analysis:**
- Meta-analysis deconstructed into 5 irreducible elements: (1) commensurable question definition, (2) exhaustive search, (3) standardization & quality calibration, (4) weighted synthesis, (5) heterogeneity interpretation
- MAestro architecture focuses on elements 3-5 (extraction, synthesis, interpretation), deliberately excluding elements 1-2 (planning, search) to minimize MVP scope

**From SCAMPER Innovation:**
- Three-element toolbox (Microscope, Compiler, Oracle) emerged as "Eliminate complexity" strategy—reducing cognitive load to LEGO-like building blocks
- Data card microservice architecture solves fragile conversation state management identified during "Combine" exercise
- Three-color source labeling transforms AI hallucination risk (Black Hat concern) into transparent quality stratification feature (Green Hat solution)

**From Six Thinking Hats Analysis:**
- **Red Hat intuition:** Position as "idea catalyst not precision measurement" became North Star for all design decisions
- **Black Hat risks:** AI hallucination and context loss identified as highest-impact failure modes, driving mitigation strategies
- **Green Hat solutions:** RAAA appendix, data card architecture, three-stage human-AI collaboration all originated from risk-mitigation ideation
- **Yellow Hat optimism:** "Technology democratization" and "unprecedented accessibility" themes validated by discovering 50% time reduction opportunity

**Strategic insights applied:**
- "Lightweight conversation workflow over complex system development" principle shaped MVP scope (pure prompts, no software)
- "Local-first, Git-based, markdown-centric" architecture aligns with researcher familiarity and transparency requirements
- Progressive evolution pathway (prompts → community → CROS) provides clear roadmap without premature commitment

**Methodological validation needed:**
Top 3 priority action items from brainstorming remain: (1) develop/test three-element prompts, (2) establish data card workflow, (3) design RAAA transparency standards—all reflected in MVP scope.

### B. Stakeholder Input

*No formal stakeholder consultation conducted prior to brief creation. Beta phase will gather input from:*
- Meta-analysis methodologists (academic validators)
- Target users (post-docs, students across 3+ disciplines)
- Research ethics experts (IRB perspective on AI-assisted research)
- Journal editors (publication acceptance criteria)
- Open-source community contributors (sustainability model validation)

### C. References

**Foundational Documents:**
- Brainstorming Session Results (October 18, 2025): `docs/brainstorming-session-results.md`

**Meta-Analysis Methodology Standards:**
- PRISMA 2020 Statement (Preferred Reporting Items for Systematic Reviews and Meta-Analyses)
- Cochrane Handbook for Systematic Reviews of Interventions
- Campbell Collaboration Systematic Review Standards

**Relevant Tools for Competitive Analysis:**
- RevMan (Cochrane's Review Manager): https://training.cochrane.org/online-learning/core-software/revman
- Covidence (systematic review platform): https://www.covidence.org/
- DistillerSR (evidence synthesis software): https://www.distillersr.com/

**AI-Assisted Research Ethics:**
- Future research: survey emerging guidelines on LLM use in academic research
- Future research: IRB considerations for AI-assisted evidence synthesis

**Technical Resources:**
- Claude API Documentation: https://docs.anthropic.com/
- VS Code Extension API: https://code.visualstudio.com/api

## Next Steps

### Immediate Actions

1. **Develop Microscope v1.0 prompt template** (Week 1-2)
   - Design structured prompt covering screening → quality assessment → data extraction
   - Integrate three-color labeling system into output format
   - Test with 3-5 sample papers across different disciplines
   - Document failure modes and edge cases

2. **Develop Compiler v1.0 prompt template** (Week 2-3)
   - Create aggregation prompt for multi-card compilation
   - Define standardized CSV output schema
   - Test compilation of 10-20 data cards
   - Validate compatibility with R and Python data import

3. **Develop Oracle v1.0 prompt template** (Week 3-4)
   - Design natural language → statistical code translation interface
   - Cover basic pooled effects, heterogeneity (I²), subgroup analysis
   - Generate R and Python code variants
   - Create interpretation annotation system

4. **Document data card markdown format standard** (Week 2)
   - Define YAML frontmatter schema
   - Establish markdown table conventions
   - Create template file with inline documentation
   - Write Git integration best practices guide

5. **Create quick start documentation** (Week 4-5)
   - Write step-by-step tutorial using 5-10 example papers
   - Develop troubleshooting guide for common errors
   - Record cost estimation methodology
   - Publish to GitHub Pages

6. **Design RAAA appendix template** (Week 5-6)
   - Research existing AI transparency reporting standards
   - Create standardized format for prompt disclosure
   - Document human validation workflow
   - Design data quality breakdown by color labels

7. **Recruit 5-10 beta testers** (Week 6-8)
   - Target diverse disciplines (medicine, psychology, education, economics)
   - Ensure mix of experience levels (students, post-docs, junior faculty)
   - Provide API cost subsidies if needed
   - Establish feedback collection protocol

8. **Conduct validation studies** (Week 8-16)
   - Compare AI extraction vs. expert manual extraction (target 90%+ agreement)
   - Test three-color labeling false positive/negative rates
   - Measure time-to-completion for 10+ paper projects
   - Document user confidence levels and workflow adoption patterns

9. **Iterate based on beta feedback** (Ongoing 2-week sprints)
   - Refine prompts based on accuracy/usability issues
   - Update documentation with real-world learnings
   - Expand troubleshooting guide
   - Optimize for token efficiency to reduce costs

10. **Evaluate MVP success criteria** (Week 16-20)
    - Review validation study results against success criteria
    - Decision point: proceed to Phase 2 or iterate further?
    - Document lessons learned and update roadmap
    - Publish methodology preprint (if criteria met)

### PM Handoff

This Project Brief provides the full context for **MAestro - Meta分析智能体系统 (Meta-Analysis Intelligent Agent System)**.

The brainstorming session has established strong conceptual foundations (three-element toolbox, data card architecture, transparency standards), validated through multiple analytical lenses (first principles, SCAMPER, Six Thinking Hats).

**For next phase development, please:**

1. Review this brief thoroughly and validate that it accurately captures the vision from brainstorming session
2. Identify any gaps or inconsistencies between brainstorming insights and brief content
3. Prioritize the 10 immediate actions based on dependencies and available resources
4. Establish communication channels with potential beta testers from academic networks
5. Begin prompt template development starting with Microscope (highest priority/highest risk)
6. Set up GitHub repository structure following the architecture outlined in Technical Considerations
7. Consider which open-source license (MIT vs Apache 2.0) best serves academic community needs
8. Research grant opportunities for open-source academic tool development (Mozilla MOSS, CZI, Sloan Foundation)

**Critical success factors moving forward:**

- Maintain "idea catalyst" positioning throughout all communications and design decisions
- Preserve extreme scope discipline (MVP = 6 features only, resist feature creep)
- Validate core assumptions (90% extraction accuracy, three-color labeling reliability) before scaling
- Build in public, engage academic community early for credibility
- Document everything transparently to model the RAAA standards we're promoting

**Questions or areas needing clarification should focus on implementation details that require strategic decisions (e.g., prompt optimization trade-offs, beta tester selection criteria, validation methodology specifics).**
