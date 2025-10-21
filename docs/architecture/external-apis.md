# External APIs

MAestro 采用 **最小外部依赖** 原则，本地优先架构意味着大部分功能在用户本地完成。

## API 1: Claude Code (内置 AI 模型调用)

- **Purpose:** 核心 AI 功能 - 论文分析、数据提取、统计代码生成
- **Documentation:** Claude Code 官方文档
- **Base URL(s):** N/A（通过 Claude Code CLI/Desktop 应用内置调用）
- **Authentication:** 由 Claude Code 管理（用户无需单独配置 API key）
- **Rate Limits:** 由 Claude Code/Anthropic 账户限制决定

**Integration Notes:**

**MVP 阶段：** 用户手动将 prompt 模板内容复制到 Claude Code 会话

**CROS 阶段可能的集成方式：**
- **选项 A:** 调用 Claude Code CLI（如果支持）
- **选项 B:** 使用 Claude Code 作为 MCP Server
- **选项 C:** 仅 prompt 管理（用户手动执行）- **当前采用**

**当前架构建议：** 选项 C - CROS 工具作为"prompt 管理和数据工具"，不是"AI 调用包装器"

## API 2: GitHub API（可选 - CROS Phase 2）

- **Purpose:** 社区模块发现和下载
- **Documentation:** https://docs.github.com/en/rest
- **Base URL(s):** https://api.github.com
- **Authentication:** Public read access (无需认证，受限 60 req/hr)
- **Rate Limits:** Unauthenticated: 60 requests/hour

**实现优先级：** ⬇️ 低（Epic 3 之后，社区增长阶段）

---
