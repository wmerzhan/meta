# Security

MAestro 的安全策略优先考虑 **学术数据隐私** 和 **本地优先原则**。

## Input Validation

**必需规则:**

**1. 文件路径验证（防止路径遍历）:**
```python
def validate_safe_path(file_path: Path, base_dir: Path) -> Path:
    resolved = file_path.resolve()
    base_resolved = base_dir.resolve()

    if not str(resolved).startswith(str(base_resolved)):
        raise ValidationError("Path traversal detected")
    return resolved
```

**2. 文件名清理:**
```python
def sanitize_filename(filename: str) -> str:
    safe_name = re.sub(r'[^a-zA-Z0-9_.-]', '_', filename)
    safe_name = safe_name.lstrip('.')
    return safe_name[:255]
```

**3. YAML 安全加载:**
```python
# ✅ 使用 safe_load
return yaml.safe_load(content)
# ❌ 不使用 load（可执行代码）
```

**4. 命令注入防护:**
```python
# ✅ 安全：使用列表参数
subprocess.run(['maestro', arg1, arg2], shell=False)
# ❌ 危险：shell=True
```

## Authentication & Authorization

**重要:** MAestro 是本地单用户应用，无需传统用户认证。

**文件系统权限:**
```python
def create_secure_directory(path: Path, mode: int = 0o700):
    path.mkdir(mode=mode, parents=True, exist_ok=True)
```

## Secrets Management

**关键决策:** MAestro 通过 Claude Code 调用 AI，**不存储 API keys**。

如果未来支持直接 API 调用：
```python
import keyring

def store_api_key(key: str):
    keyring.set_password("maestro", "anthropic_api_key", key)

def retrieve_api_key() -> str:
    return keyring.get_password("maestro", "anthropic_api_key")
```

## Data Protection

**加密 at Rest:** 依赖 OS 级加密（BitLocker, FileVault, LUKS）

**PII Handling:**
```python
# 数据卡片不应包含 PII
# ⚠️ 警告文档：不要包含参与者级别数据
```

**Logging Restrictions:**
```python
class PrivacyAwareFilter(logging.Filter):
    REDACT_PATTERNS = [
        r'sk-ant-[a-zA-Z0-9]+',  # API keys
        r'\b\d{3}-\d{2}-\d{4}\b',  # SSN
    ]

    def filter(self, record):
        # 修改日志，移除敏感信息
        ...
```

## Dependency Security

**扫描工具:** `safety`, `pip-audit`, `npm audit`

**GitHub Actions:**
```yaml
- name: Run Safety check
  run: safety check --json

- name: Run npm audit
  run: npm audit --audit-level=moderate
```

**更新策略:**

| 漏洞严重性 | 响应时间 | 操作 |
|----------|---------|------|
| Critical | 24 小时 | 紧急补丁 |
| High | 1 周 | 计划修复 |
| Moderate | 1 月 | 定期更新 |

## Security Testing

**SAST:**
```bash
# Python
bandit -r maestro/

# TypeScript
npm install --save-dev eslint-plugin-security
```

**手动安全测试检查清单:**
- [ ] 路径遍历测试
- [ ] 恶意 YAML 测试
- [ ] 依赖漏洞扫描
- [ ] 日志隐私检查

---
