# User Interface Design Goals

## Overall UX Vision

**MVP Phase (Prompt-Based Workflow):**
MAestro prioritizes **conversation over clicks**—the interface IS the conversation with Claude Code. Users interact through natural language in their terminal or Claude Code Desktop app, with the "UI" being well-formatted markdown outputs (data cards, analysis results, documentation). This deliberately minimalist approach eliminates GUI complexity that would delay MVP validation, focusing instead on workflow ergonomics: clear prompts, predictable outputs, and human-readable file artifacts.

**CROS Phase (Future Rich Interface):**
Evolve toward "conversational software"—maintaining natural language as primary input modality while adding visual scaffolding for complex operations. Think "VS Code Copilot meets data analysis workbench": users type intent, system provides contextual suggestions, visualizes project state (progress tracking, data quality heatmaps), and surfaces actionable insights without requiring command memorization.

**Core UX Principle:** The system should feel like collaborating with an expert colleague, not operating a machine. Every interaction should reduce cognitive load, preserve research context, and make expertise transparent (not hidden behind automation black boxes).

## Key Interaction Paradigms

1. **Natural Language Commands:** Primary interaction model—users describe intent ("analyze these 10 papers for treatment effects") rather than navigating menus or filling forms
2. **Markdown-Centric Artifacts:** All outputs (data cards, compilations, analyses) stored as human-readable .md files that serve as both data and documentation
3. **Progressive Disclosure:** Simple workflows accessible immediately (single-paper Microscope); advanced features (batch processing, custom quality modules) discovered through documentation and community examples
4. **Stateless Operations (MVP) → Stateful Sessions (CROS):** MVP treats each conversation independently; CROS maintains project memory across sessions (remembers extraction criteria, tracks progress, resumes interrupted workflows)
5. **Three-Stage Collaboration Loop:** (1) AI generates initial output → (2) Human validates/corrects using three-color labels as guide → (3) AI polishes based on feedback. This paradigm repeats at every workflow stage.

## Core Screens and Views

**MVP Phase (No GUI - File/Terminal Based):**
- **Project Folder Structure:** User organizes files in local directory (e.g., `my_meta_analysis/data_cards/`, `my_meta_analysis/compiled/`, `my_meta_analysis/analyses/`)
- **Claude Code Terminal Session:** Primary "screen"—scrolling conversation with command prompts and formatted markdown responses
- **Data Card View:** Individual .md files opened in user's text editor (VS Code, Sublime, Vim) showing structured data with color labels
- **Compiled Dataset View:** CSV/TSV files opened in Excel, R, or Python for statistical analysis
- **Documentation View:** GitHub Pages or local markdown files viewed in browser or editor

**CROS Phase (VS Code Extension Concept):**
- **Project Dashboard:** Visual overview showing extraction progress (15/30 papers completed), data quality summary (🟢 85%, 🟡 12%, 🔴 3%), recent activity
- **Interactive Data Card Editor:** Split view with paper text on left, extracted data table on right; inline three-color labeling with hover tooltips explaining label rationale
- **Conversation Sidebar:** Persistent chat interface for Oracle queries ("What's the pooled effect?") with statistical results embedded inline
- **Quality Control Panel:** Random sampling for validation; conflict flagging for team projects; audit trail visualization
- **PRISMA Flow Diagram Generator:** Auto-populated diagram based on screening decisions tracked across data cards

## Accessibility

**WCAG AA** (CROS Phase Target)

MVP relies on terminal/editor accessibility features. CROS phase targets WCAG AA compliance for VS Code extension (keyboard navigation, screen reader support, sufficient color contrast beyond three-color system, adjustable text sizes).

## Branding

**Minimalist, Academic, Trustworthy Design**

- **Visual Identity:** Academic tool aesthetic (LaTeX, Zotero, Jupyter style); avoid flashy startup branding
- **Color System:** Three-color labels (🟢🟡🔴) are functional, not decorative—consistent across all materials
- **Typography:** Monospace fonts for data/code (Fira Code, JetBrains Mono); serif fonts for documentation (Merriweather, Crimson Text)
- **Logo/Icon:** Microscope emoji 📌 for tool branding; abstract "convergent synthesis" visual concept
- **Tone & Voice:** Documentation is clear, pedagogical, respectful; error messages are helpful and educative; community communications emphasize collaborative open-source ethos

## Target Device and Platforms

**Desktop Cross-Platform: Web Responsive** (Windows, macOS, Linux)

**Supported:**
- Windows 10/11 (PowerShell, Windows Terminal, VS Code)
- macOS 10.15+ (Terminal.app, iTerm2, VS Code)
- Linux - Ubuntu, Fedora, Arch (bash terminals, VS Code)

**NOT Supported:**
- Mobile (iOS/Android) - Meta-analysis workflows require large screens and extended focus sessions
- Web-Only (Browser-Based) - Local-first architecture is non-negotiable for data privacy
- Tablets - Not prioritized for MVP or CROS phases
