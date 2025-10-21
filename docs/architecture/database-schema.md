# Database Schema

MAestro 采用 **混合存储架构**：文件系统存储研究数据（主要），SQLite 存储元数据和日志（辅助，仅 CROS 阶段）。

**数据库文件位置：** `<project_root>/.maestro/maestro.db`

## Table 1: projects

```sql
CREATE TABLE projects (
    project_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    research_question TEXT NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_cards_path TEXT DEFAULT 'data_cards',
    compiled_datasets_path TEXT DEFAULT 'compiled',
    analyses_path TEXT DEFAULT 'analyses',
    extraction_criteria TEXT,
    quality_checklist_module TEXT DEFAULT 'generic',
    status TEXT CHECK(status IN ('planning', 'extracting', 'analyzing', 'complete')) DEFAULT 'planning',
    total_data_cards INTEGER DEFAULT 0,
    total_compilations INTEGER DEFAULT 0,
    total_analyses INTEGER DEFAULT 0
);
```

## Table 2: conversation_logs

```sql
CREATE TABLE conversation_logs (
    log_id TEXT PRIMARY KEY,
    project_id TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    prompt_template_id TEXT,
    prompt_type TEXT CHECK(prompt_type IN ('microscope', 'compiler', 'oracle', 'custom')),
    model_version TEXT NOT NULL,
    input_tokens INTEGER,
    output_tokens INTEGER,
    estimated_cost_usd REAL,
    context_items TEXT,
    data_card_id TEXT,
    success BOOLEAN DEFAULT TRUE,
    error_message TEXT,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);
```

## Table 3: prompt_templates

```sql
CREATE TABLE prompt_templates (
    template_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    version TEXT NOT NULL,
    type TEXT CHECK(type IN ('microscope', 'compiler', 'oracle')) NOT NULL,
    file_path TEXT NOT NULL,
    compatible_models TEXT NOT NULL,
    created_date TIMESTAMP,
    description TEXT,
    parameters TEXT,
    usage_count INTEGER DEFAULT 0,
    UNIQUE(name, version)
);
```

## Table 4: data_card_metadata

```sql
CREATE TABLE data_card_metadata (
    data_card_id TEXT PRIMARY KEY,
    project_id TEXT NOT NULL,
    file_path TEXT NOT NULL,
    file_hash TEXT,
    last_modified TIMESTAMP,
    title TEXT,
    authors TEXT,
    year INTEGER,
    doi TEXT,
    extraction_date TIMESTAMP,
    extractor TEXT,
    microscope_version TEXT,
    screening_decision TEXT CHECK(screening_decision IN ('include', 'exclude')),
    overall_quality TEXT CHECK(overall_quality IN ('high', 'medium', 'low')),
    total_data_points INTEGER,
    green_count INTEGER,
    yellow_count INTEGER,
    red_count INTEGER,
    validation_status TEXT CHECK(validation_status IN ('valid', 'warning', 'error', 'not_validated')) DEFAULT 'not_validated',
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);
```

## Table 5: compiled_datasets

```sql
CREATE TABLE compiled_datasets (
    dataset_id TEXT PRIMARY KEY,
    project_id TEXT NOT NULL,
    name TEXT NOT NULL,
    file_path TEXT NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    compiler_version TEXT,
    source_data_cards TEXT NOT NULL,
    output_format TEXT CHECK(output_format IN ('csv', 'tsv')) DEFAULT 'csv',
    row_count INTEGER,
    green_percentage REAL,
    yellow_percentage REAL,
    red_percentage REAL,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);
```

## Table 6: analyses

```sql
CREATE TABLE analyses (
    analysis_id TEXT PRIMARY KEY,
    project_id TEXT NOT NULL,
    dataset_id TEXT,
    name TEXT NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    research_question TEXT NOT NULL,
    oracle_version TEXT,
    language TEXT CHECK(language IN ('r', 'python')) NOT NULL,
    code_file_path TEXT NOT NULL,
    interpretation_file_path TEXT,
    executed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (dataset_id) REFERENCES compiled_datasets(dataset_id) ON DELETE SET NULL
);
```

## 文件系统 vs 数据库职责划分

| 数据类型 | 存储位置 | 真实来源 | 可重建？ |
|---------|---------|---------|---------|
| **数据卡片内容** | 文件系统 (.md) | ✅ 是 | ❌ 否（核心数据） |
| **数据卡片元数据** | SQLite | ❌ 否 | ✅ 是（扫描 .md 文件） |
| **编译数据集** | 文件系统 (.csv) | ✅ 是 | ✅ 是（重新编译） |
| **Prompt 模板** | 文件系统 (.md) | ✅ 是 | ❌ 否（核心资产） |
| **对话日志** | SQLite | ✅ 是 | ❌ 否（历史记录） |

---
