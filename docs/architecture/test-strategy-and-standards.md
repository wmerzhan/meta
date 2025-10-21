# Test Strategy and Standards

MAestro 的测试策略平衡 **学术研究正确性** 和 **软件工程质量**。

## Testing Philosophy

**核心原则:**
1. **验证优先于自动化（MVP）**
2. **渐进式自动化（CROS）**
3. **金标准驱动**
4. **跨平台保证**

**覆盖率目标:**

| 阶段 | 单元测试覆盖率 | 集成测试 | E2E 测试 |
|------|---------------|---------|---------|
| **MVP** | N/A（无代码） | 手动 | 手动 |
| **CROS Phase 1** | 80%+ | 自动化 | 手动 |
| **CROS Phase 2** | 85%+ | 自动化 | 部分自动化 |

## Test Types and Organization

### 1. Unit Tests

**框架:** pytest 8.0+ (Python), Jest (@vscode/test-electron)

**测试结构（AAA 模式）:**
```python
def test_parse_valid_data_card(tmp_path):
    # Arrange
    parser = DataCardParser()
    file_path = tmp_path / "study_001.md"
    file_path.write_text(valid_content)

    # Act
    result = parser.parse(file_path)

    # Assert
    assert isinstance(result, DataCard)
    assert result.study_id == "study_001"
```

### 2. Integration Tests

**测试基础设施:**
- SQLite in-memory database
- 临时文件系统

```python
def test_microscope_workflow_end_to_end(temp_project):
    prompt_manager = PromptTemplateManager()
    parser = DataCardParser()
    validator = SchemaValidator()

    # 完整工作流测试
    prompt = prompt_manager.load_template('microscope', 'v1.0')
    # ...
    validation_result = validator.validate_data_card(data_card)
    assert validation_result.success
```

### 3. End-to-End Tests

```python
def test_complete_meta_analysis_workflow(tmp_path):
    # 1. 初始化项目
    subprocess.run(['maestro', 'init', 'test_project'], cwd=tmp_path)

    # 2. 处理论文
    # 3. 验证
    # 4. 编译
    # 5. 分析

    assert (project_dir / 'compiled' / 'test.csv').exists()
```

## Test Data Management

**Fixture 组织:**
```
tests/fixtures/
  sample_data_cards/valid/
  sample_data_cards/invalid/
  sample_papers/
  expected_outputs/
  claude_responses/
```

## Continuous Testing

**GitHub Actions:**
```yaml
jobs:
  test-python:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        python-version: ['3.9', '3.10', '3.11', '3.12']
    steps:
      - run: poetry run pytest --cov=maestro
```

---
