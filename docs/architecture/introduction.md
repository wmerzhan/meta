# Introduction

This document outlines the overall project architecture for **MAestro**, including backend systems, shared services, and non-UI specific concerns. Its primary goal is to serve as the guiding architectural blueprint for AI-driven development, ensuring consistency and adherence to chosen patterns and technologies.

**Relationship to Frontend Architecture:**
MAestro's CROS phase includes a VS Code Extension with a conversational UI. A separate Frontend Architecture Document may be created to detail the frontend-specific design, which MUST be used in conjunction with this document. Core technology stack choices documented herein (see "Tech Stack") are definitive for the entire project, including any frontend components.

## Starter Template or Existing Project

Based on the PRD and project context, MAestro is a **greenfield project** with a unique architectural approach:

**MVP Phase:** No traditional starter template applies. The system is a collection of markdown prompt templates stored in a Git repository. There's no application to "start" - users directly interact with Claude Code using the prompts.

**CROS Phase:** The project will build:
1. **Python CLI** - A command-line interface tool distributed via PyPI
2. **VS Code Extension** - A conversational interface integrated into VS Code

**Decision:** N/A for MVP (pure markdown templates). For CROS phase, individual project scaffolding tools will be used as needed.

## Change Log

| Date | Version | Description | Author |
|------|---------|-------------|--------|
| 2025-10-19 | v0.1 | Initial architecture document draft | Winston (Architect) |

---
