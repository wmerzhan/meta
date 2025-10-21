# Next Steps

## UX Expert Prompt

Review this PRD (docs/prd.md) and the Project Brief (docs/brief.md), then create a comprehensive UI/UX design specification for MAestro's MVP phase (terminal-based workflow with markdown outputs) and CROS phase vision (VS Code extension with conversational interface). Focus on designing the conversation flow for Microscope, Compiler, and Oracle prompts, and define the visual design for three-color labeling system and data card format. Address the terminal-first UX assumption and provide recommendations for reducing cognitive load for non-technical researchers.

## Architect Prompt

Review this PRD (docs/prd.md) and create a comprehensive technical architecture for MAestro MVP. Design the data card markdown format specification with YAML frontmatter schema, define the three-element prompt template architecture (Microscope, Compiler, Oracle), and establish validation frameworks for AI-generated outputs. Address the key technical risks: prompt stability across model updates, statistical code correctness, three-color labeling reliability, and context window limits. Provide implementation guidance for Epic 1 (Microscope & Data Card System) with particular attention to the generic quality assessment framework and Git integration patterns. Ensure all architectural decisions maintain local-first principles and support the 90% extraction accuracy target.
