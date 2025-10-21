# Source Tree

MAestro 采用 **Monorepo 结构**，包含 prompt 模板、文档、CROS 工具和示例项目。

```plaintext
maestro/                                    # 仓库根目录
│
├── .github/                                # GitHub 配置
│   └── workflows/                          # CI/CD workflows
│       ├── test.yml
│       ├── publish-cli.yml
│       └── publish-extension.yml
│
├── prompts/                                # ✨ MVP 核心：Prompt 模板
│   ├── microscope/
│   │   ├── microscope_v1.0.md
│   │   └── CHANGELOG.md
│   ├── compiler/
│   │   ├── compiler_v1.0.md
│   │   └── CHANGELOG.md
│   └── oracle/
│       ├── oracle_v1.0.md
│       └── CHANGELOG.md
│
├── modules/                                # 学科特定质量检查表
│   ├── generic/
│   │   └── generic_quality_checklist.md
│   └── rob2/
│       └── rob2_checklist.md
│
├── templates/                              # 文件模板
│   ├── data_card.md
│   ├── raaa_appendix.md
│   └── project_config.yaml
│
├── docs/                                   # 📚 文档
│   ├── index.md
│   ├── quickstart.md
│   ├── best-practices.md
│   ├── architecture.md                    # 本文档
│   └── api/
│
├── tools/                                  # 🔧 CROS 工具
│   ├── cli/                                # Python CLI
│   │   ├── pyproject.toml
│   │   ├── maestro/
│   │   │   ├── __init__.py
│   │   │   ├── cli.py
│   │   │   ├── core/
│   │   │   ├── models/
│   │   │   ├── database/
│   │   │   └── utils/
│   │   └── tests/
│   │       ├── unit/
│   │       ├── integration/
│   │       └── fixtures/
│   │
│   └── vscode-extension/                   # VS Code Extension
│       ├── package.json
│       ├── src/
│       │   ├── extension.ts
│       │   ├── commands/
│       │   ├── webview/
│       │   └── integration/
│       └── test/
│
├── tests/                                  # 🧪 跨工具验证测试
│   ├── validation/
│   └── performance/
│
├── examples/                               # 📁 示例项目
│   └── sample_meta_analysis/
│       ├── data_cards/
│       ├── compiled/
│       └── analyses/
│
├── scripts/                                # 🔨 仓库管理脚本
│
├── LICENSE
├── README.md
└── mkdocs.yml
```

---
