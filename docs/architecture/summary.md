# Summary

MAestro Architecture Document 定义了从 MVP（纯 prompt 模板）到 CROS（本地桌面应用）的完整技术架构。

**关键架构决策:**
- ✅ 本地优先（无云服务器）
- ✅ 文件系统为主要数据存储
- ✅ 双阶段演进（MVP → CROS）
- ✅ 三色标签系统（数据质量透明度）
- ✅ Monorepo 结构
- ✅ 通过 Claude Code 调用 AI（无需单独 API key 管理）

**实施优先级:** 按 PRD Epic 顺序（Epic 1 → Epic 2 → Epic 3）

**后续步骤:**
1. 提取 `tech-stack.md`, `coding-standards.md` 供 dev agent 使用
2. 开始 Epic 1 实施（仓库初始化、数据卡片格式、Microscope prompt）
3. 建立 CI/CD pipeline（GitHub Actions）

---

**Document Status:** ✅ Complete
**Next Review:** Before Epic 1 implementation
