# Infrastructure and Deployment

MAestro 采用 **本地优先架构**，无需传统云基础设施。"部署"指的是 **分发包到公共仓库**。

## Infrastructure as Code

**工具:** N/A（无云基础设施）

**说明:** MAestro 是本地桌面应用，不需要云服务器。

## Deployment Strategy

### 1. MVP Prompt 模板（即时可用）

**部署方式:** Git 仓库直接访问

**发布流程:**
1. 创建新 prompt 版本
2. 更新 CHANGELOG.md
3. 提交并 push
4. 打 Git tag
5. 创建 GitHub Release

### 2. Python CLI（PyPI 发布）

**构建命令:**
```bash
cd tools/cli
poetry build
```

**发布流程（GitHub Actions）:**
```yaml
# .github/workflows/publish-cli.yml
- name: Publish to PyPI
  env:
    POETRY_PYPI_TOKEN_PYPI: ${{ secrets.PYPI_TOKEN }}
  run: poetry publish
```

**用户安装:**
```bash
pip install maestro-meta
```

### 3. VS Code Extension（Marketplace 发布）

**构建命令:**
```bash
cd tools/vscode-extension
vsce package
```

**发布流程（GitHub Actions）:**
```yaml
# .github/workflows/publish-extension.yml
- name: Publish to Marketplace
  env:
    VSCE_PAT: ${{ secrets.VSCODE_MARKETPLACE_TOKEN }}
  run: vsce publish
```

### 4. 文档站点（GitHub Pages）

**构建工具:** MkDocs + Material 主题

**部署（GitHub Actions）:**
```yaml
# .github/workflows/deploy-docs.yml
- name: Build and deploy
  run: mkdocs gh-deploy --force
```

**访问地址:** https://maestro-meta.github.io

## Environments

| Environment | Purpose | Details |
|-------------|---------|---------|
| **Development** | 本地开发 | Poetry/npm install, 热重载 |
| **CI Testing** | GitHub Actions 自动化测试 | 跨平台 matrix 测试 |
| **User Production** | 最终用户本地环境 | pip/VS Code Marketplace 安装 |

## Rollback Strategy

**回滚方法:**

| 组件 | 目标 RTO | 回滚方法 |
|------|---------|---------|
| **Python CLI** | < 4 小时 | 发布修复版本或指导用户降级 |
| **VS Code Extension** | < 2 小时 | Unpublish + 重新发布旧版本 |
| **文档站点** | < 30 分钟 | Git revert + 重新部署 |
| **Prompt 模板** | 立即 | 用户切换到旧版本（无需回滚） |

---
