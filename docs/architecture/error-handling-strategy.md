# Error Handling Strategy

MAestro 的错误处理策略优先考虑 **用户友好性**和**学术透明度**。

## General Approach

**错误模型:** 结构化异常 + 用户友好消息

**异常层次结构（Python）:**

```python
class MaestroError(Exception):
    """所有 MAestro 异常的基类"""
    def __init__(self, message: str, suggestion: str = None, context: dict = None):
        self.message = message
        self.suggestion = suggestion
        self.context = context or {}

class DataCardParseError(MaestroError):
    """数据卡片解析失败"""
    pass

class ValidationError(MaestroError):
    """数据验证失败"""
    pass

class CompilationError(MaestroError):
    """数据编译失败"""
    pass
```

**错误传播规则:**
- 底层函数：抛出具体异常
- 中层组件：捕获并添加上下文
- CLI 入口：转换为用户友好消息

## Logging Standards

**日志库:** Python `logging` + Rich handler

**日志级别:**

| 级别 | 用途 | 示例 |
|------|------|------|
| DEBUG | 详细调试信息 | "Parsing YAML frontmatter: 15 keys found" |
| INFO | 正常操作 | "✅ Data card saved" |
| WARNING | 警告但不影响执行 | "⚠️ Missing optional field 'doi'" |
| ERROR | 错误但可恢复 | "❌ Validation failed" |
| CRITICAL | 严重错误 | "❌ Cannot access database" |

**Required Context:**
- **Correlation ID:** 每个命令执行生成唯一 ID
- **Service Context:** 组件名、prompt 版本、模型版本
- **User Context:** 项目 ID（不记录研究数据）

## Error Handling Patterns

### Pattern 1: External API Errors (Claude Code)

由于 MAestro 不直接调用 API，错误处理主要是提供指导：

```python
def handle_claude_code_error(error_type: str):
    suggestions = {
        'context_limit': "Paper exceeds context window. Try extracting only Methods and Results sections",
        'rate_limit': "API rate limit reached. Wait and retry",
    }
    raise ClaudeCodeIntegrationError(
        message=f"Claude Code error: {error_type}",
        suggestion=suggestions.get(error_type)
    )
```

### Pattern 2: Business Logic Errors (验证失败)

```python
class ValidationError(MaestroError):
    def __init__(self, errors: List[str], file_path: Path = None):
        self.errors = errors
        message = f"Validation failed with {len(errors)} error(s)"
        suggestion = "Add missing fields to data card YAML frontmatter"
        super().__init__(message, suggestion, {'file_path': str(file_path)})
```

**用户友好错误示例:**
```
❌ Validation failed with 2 error(s)
📁 File: data_cards/study_003.md

Errors:
  1. Missing required field: 'sample_size'
  2. Invalid type for 'year': expected integer

💡 Suggestion: Check data types match the schema
📚 See docs/data-card-format.md
```

### Pattern 3: Data Consistency (编译时异构数据)

```python
def compile_dataset(data_cards: List[Path], output_path: Path):
    temp_output = output_path.with_suffix('.tmp')
    try:
        compiled_data = aggregate_data_cards(data_cards)
        compiled_data.to_csv(temp_output)
        validate_compiled_dataset(temp_output)
        temp_output.rename(output_path)
    except Exception as e:
        if temp_output.exists():
            temp_output.unlink()
        raise CompilationError(...)
```

## Logging Restrictions

**不要记录:**
- ❌ 论文完整内容
- ❌ 提取的研究数据
- ❌ 用户的完整文件路径
- ❌ API keys

**可以记录:**
- ✅ 文件名（不含路径）
- ✅ 操作类型
- ✅ 计数统计
- ✅ 性能指标

---
