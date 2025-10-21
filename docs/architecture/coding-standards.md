# Coding Standards

这些标准是 **AI 开发代理的强制规则**。

## Core Standards

**Languages & Runtimes:**
- **Python:** 3.9+ with type hints (mandatory)
- **TypeScript:** 5.4+ with strict mode

**Style & Linting:**

Python:
```bash
poetry run black maestro/
poetry run ruff check maestro/
poetry run mypy maestro/
```

**Test Organization:**
```
tests/
  unit/test_{module}.py
  integration/test_{workflow}_workflow.py
  fixtures/{test_data}.md
```

## Naming Conventions

| Element | Python | TypeScript | Example |
|---------|--------|-----------|---------|
| **模块/文件** | snake_case | camelCase | `data_card.py`, `ChatPanel.ts` |
| **类** | PascalCase | PascalCase | `DataCardParser` |
| **函数** | snake_case | camelCase | `parse_data_card()` |
| **常量** | UPPER_SNAKE_CASE | UPPER_SNAKE_CASE | `MAX_TOKEN_LIMIT` |

## Critical Rules

### Rule 1: 文件系统是真实来源

```python
# ✅ 正确：写入文件系统，数据库仅存索引
def save_data_card(data_card: DataCard, file_path: Path):
    with open(file_path, 'w') as f:
        f.write(data_card.to_markdown())
    db.execute("INSERT INTO data_card_metadata ...")
```

### Rule 2: 保留三色标签完整性

```python
# ✅ 正确：编译时保留标签
def compile_data_points(data_cards: List[DataCard]) -> pd.DataFrame:
    data = []
    for card in data_cards:
        for point in card.extracted_data:
            data.append({
                'value': point.value,
                'source_label': point.source_label,  # 🟢/🟡/🔴
            })
    return pd.DataFrame(data)
```

### Rule 3: Prompt 模板版本化

```bash
# ✅ 正确：创建新版本
cp microscope_v1.0.md microscope_v1.1.md
# 修改新版本文件
```

### Rule 4: 类型安全优先

```python
# ✅ 正确：完整类型提示
def parse_data_card(file_path: Path) -> DataCard:
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    return DataCard.model_validate(data)
```

### Rule 5: 日志不得包含研究数据

```python
# ✅ 正确：仅记录操作
logger.info(f"Extracted {len(data_points)} data points")
# ❌ 错误：记录敏感数据
# logger.info(f"effect_size: {effect_size}")
```

### Rule 6: 生成的代码必须自包含

```r
# ✅ 正确：包含安装说明
# Install required packages:
# install.packages(c("metafor", "readr"))

library(metafor)
library(readr)
# ... analysis code
```

### Rule 7: 路径必须跨平台兼容

```python
# ✅ 正确：使用 pathlib
from pathlib import Path
data_card_path = Path("data_cards") / f"{study_id}.md"
```

### Rule 8: 数据卡片解析必须容错

```python
# ✅ 正确：转换为领域异常
try:
    return yaml.safe_load(content)
except yaml.YAMLError as e:
    raise DataCardParseError(
        message="Invalid YAML frontmatter",
        suggestion="Check YAML syntax",
        context={'line': e.problem_mark.line}
    )
```

### Rule 9: VS Code Extension 调用 Python CLI

```typescript
// ✅ 正确：调用 CLI
async function parseDataCard(filePath: string): Promise<DataCard> {
  const result = await execAsync(`maestro parse-data-card "${filePath}"`);
  return JSON.parse(result.stdout);
}
```

### Rule 10: 异步操作必须显示进度

```python
# ✅ 正确：显示进度
from rich.progress import track
for card_path in track(data_cards, description="Compiling..."):
    results.append(parse_data_card(card_path))
```

---
