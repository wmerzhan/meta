# Core Workflows

以下序列图展示 MAestro 的关键系统工作流。

## Workflow 1: Microscope - 单篇论文数据提取 (CROS 阶段)

```mermaid
sequenceDiagram
    actor User as 研究者
    participant CLI as MAestro CLI
    participant PTM as Prompt Template Manager
    participant CC as Claude Code
    participant DCP as Data Card Parser
    participant SV as Schema Validator
    participant FS as 文件系统

    User->>CLI: maestro microscope paper.pdf --study-id study_001
    CLI->>PTM: load_template("microscope", "v1.0")
    PTM->>FS: 读取 prompts/microscope_v1.md
    FS-->>PTM: 返回模板内容
    PTM-->>CLI: 返回完整 prompt

    CLI->>User: 🔵 请在 Claude Code 中运行以下 prompt
    User->>CC: 粘贴 prompt + 论文文本
    CC->>CC: 分析论文
    CC-->>User: 返回 markdown 格式数据卡片
    User->>CLI: 粘贴 AI 响应

    CLI->>DCP: parse_data_card(ai_response)
    DCP-->>CLI: 返回 DataCard 对象

    CLI->>SV: validate_data_card(data_card)
    alt 验证失败
        SV-->>CLI: ValidationError
        CLI-->>User: ❌ 验证失败：缺少 'sample_size' 字段
    else 验证成功
        SV-->>CLI: ValidationResult(success=True)
        CLI->>FS: 写入 data_cards/study_001.md
        CLI-->>User: ✅ 数据卡片已保存<br/>📊 数据质量：🟢 85%, 🟡 12%, 🔴 3%
    end
```

## Workflow 2: Compiler - 数据集编译

```mermaid
sequenceDiagram
    actor User as 研究者
    participant CLI as MAestro CLI
    participant PM as Project Manager
    participant DCP as Data Card Parser
    participant CE as Compiler Engine
    participant FS as 文件系统

    User->>CLI: maestro compile --output compiled_data.csv
    CLI->>PM: list_data_cards(project_id)
    PM->>FS: 扫描 data_cards/ 目录
    FS-->>PM: 返回数据卡片路径列表

    CLI->>User: 📁 发现 15 个数据卡片，开始编译...

    loop 每个数据卡片
        CLI->>DCP: parse_data_card(file_path)
        DCP->>FS: 读取文件
        FS-->>DCP: 返回 markdown 内容
        DCP-->>CLI: 返回 DataCard 对象
    end

    CLI->>CE: compile_dataset(data_cards, output_path)
    CE->>CE: 聚合数据点到 DataFrame
    CE->>FS: 写入 CSV 文件

    CE->>CE: generate_quality_summary()
    CE-->>CLI: 返回质量报告

    CLI-->>User: ✅ 编译完成：compiled_data.csv<br/>📊 15 篇论文，245 个数据点<br/>🟢 85.7% 🟡 11.4% 🔴 2.9%
```

## Workflow 3: Oracle - 统计分析生成

```mermaid
sequenceDiagram
    actor User as 研究者
    participant CLI as MAestro CLI
    participant PTM as Prompt Template Manager
    participant CC as Claude Code
    participant OAG as Oracle Analysis Generator
    participant FS as 文件系统

    User->>CLI: maestro oracle "What is the pooled effect size?" --language r
    CLI->>PTM: load_template("oracle", "v1.0")
    PTM-->>CLI: 返回 prompt

    CLI->>FS: 读取 compiled_data.csv（获取数据上下文）
    CLI->>OAG: prepare_oracle_prompt(question, dataset_context, language)
    OAG-->>CLI: 返回完整 prompt

    CLI->>User: 🔵 请在 Claude Code 中运行以下 prompt
    User->>CC: 粘贴 prompt
    CC->>CC: 生成 R 统计代码 + 解释
    CC-->>User: 返回代码和解释

    User->>CLI: 粘贴 AI 生成的代码
    CLI->>FS: 写入 analyses/pooled_effect.R
    CLI->>FS: 写入 analyses/pooled_effect_interpretation.md

    CLI-->>User: ✅ 分析已保存<br/>💡 建议：数据包含 2.9% 🔴 标签数据，考虑敏感性分析
```

## Workflow 4: 端到端 Meta-analysis 流程

```mermaid
sequenceDiagram
    actor User as 研究者
    participant CLI as MAestro CLI
    participant FS as 文件系统
    participant CC as Claude Code

    Note over User,CC: Phase 1: 项目初始化
    User->>CLI: maestro init "Intervention-X-Meta-Analysis"
    CLI->>FS: 创建项目文件夹结构
    CLI-->>User: ✅ 项目已创建

    Note over User,CC: Phase 2: 数据提取（10-30 篇论文）
    loop 对每篇论文
        User->>CLI: maestro microscope paper_N.pdf
        CLI->>User: 显示 prompt
        User->>CC: 执行数据提取
        CC-->>User: 返回数据卡片
        User->>CLI: 提交数据卡片
        CLI->>FS: 保存 data_cards/study_N.md
    end

    Note over User,CC: Phase 3: 数据验证
    User->>CLI: maestro validate
    CLI-->>User: 📋 验证报告

    Note over User,CC: Phase 4: 数据编译
    User->>CLI: maestro compile
    CLI->>FS: 写入 compiled/main_analysis.csv
    CLI-->>User: ✅ 编译完成

    Note over User,CC: Phase 5: 统计分析
    User->>CLI: maestro oracle "Pooled effect size"
    User->>CC: 执行 Oracle prompt
    CC-->>User: 生成 R 代码
    CLI->>FS: 写入 analyses/pooled_effect.R
```

---
