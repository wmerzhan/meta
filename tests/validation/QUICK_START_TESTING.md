# Microscope测试快速开始指南

**目标：** 在30分钟内完成3篇论文的自动化测试

---

## 📝 准备工作清单

在开始测试前，确保你有：

- [x] Microscope v1.0 prompt文件（`prompts/microscope/microscope_v1.0.md`）
- [x] 3篇测试论文的访问链接
- [x] 计时工具（手机、秒表或电脑计时器）
- [ ] 新的Claude Code终端窗口（**每篇论文需要单独的新会话**）

---

## 🚀 测试步骤（重复3次）

### 论文1：hwang_2015_rct（Psychology）

#### 步骤1：获取论文全文（2分钟）

**PMC链接：** https://pmc.ncbi.nlm.nih.gov/articles/PMC4591116/

**操作：**
1. 点击链接打开PMC页面
2. 如果看到"Full Text"按钮，点击它
3. **复制全文内容：**
   - 按 `Ctrl+A`（全选）
   - 按 `Ctrl+C`（复制）
   - 或手动选择从标题到参考文献的所有内容

**提示：** PMC文章通常有很好的文本格式，直接复制即可

---

#### 步骤2：准备Microscope prompt（1分钟）

**操作：**
1. 打开文件：`D:\pclaudecode\Meta-analysis\meta\prompts\microscope\microscope_v1.0.md`
2. 按 `Ctrl+A` 全选
3. 按 `Ctrl+C` 复制

**或者直接从这里复制：**
```
已准备好完整prompt在 prompts/microscope/microscope_v1.0.md
```

---

#### 步骤3：在新Claude Code会话中运行Microscope（4-6分钟）

**⚠️ 关键：必须打开新的Claude Code终端窗口**

**操作：**

1. **打开新的Claude Code会话**
   - Windows: 打开新的命令提示符/PowerShell窗口
   - 输入：`claude-code`（或你的Claude Code启动命令）

2. **粘贴Microscope prompt**
   - 在新会话中粘贴完整的Microscope v1.0 prompt
   - 按回车

3. **粘贴论文全文**
   - 在prompt下方粘贴hwang_2015的全文
   - **⏱️ 开始计时（记录准确的时间：HH:MM:SS）**
   - 按回车

4. **等待Microscope完成**
   - 观察3个阶段的进度：
     - Stage 1: Screening Decision
     - Stage 2: Quality Assessment
     - Stage 3: Data Extraction
   - **不要中断，让它自动完成**

5. **⏱️ 停止计时**
   - 当你看到完整的数据卡生成（YAML frontmatter + 所有表格）
   - 记录结束时间：HH:MM:SS
   - 计算总时长：MM:SS

---

#### 步骤4：保存结果（1分钟）

**操作：**

1. **复制完整数据卡**
   - 从 `---` 开头到最后的"Additional Notes"
   - 按 `Ctrl+C` 复制

2. **保存文件**
   - 文件路径：`D:\pclaudecode\Meta-analysis\meta\tests\validation\microscope_automated\hwang_2015_rct_automated.md`
   - 粘贴内容并保存

3. **记录提取时间**
   - 打开：`tests/validation/extraction_time_log_TEMPLATE.md`
   - 填写hwang_2015行：
     - Start Time: 你的开始时间
     - End Time: 你的结束时间
     - Duration: 计算出的时长（如：4:35）
     - Success?: 勾选☑️

4. **快速初步观察**
   - 在"初步问题观察"区域勾选完成的项
   - 记录任何明显的错误或差异

---

### 论文2：banda_2022_quasi（Education）

**重复上述步骤1-4，使用以下信息：**

- **PMC链接：** https://pmc.ncbi.nlm.nih.gov/articles/PMC9761040/
- **保存文件名：** `banda_2022_quasi_automated.md`
- **新会话：** ⚠️ 必须再次打开新的Claude Code会话

---

### 论文3：nakashima_2003_cohort（Medicine）

**如果有PDF文件：**

**文件位置：** 检查 `examples/sample_meta_analysis/source_papers/` 是否有nakashima_2003 PDF

**操作（如果有PDF）：**
1. 用PDF阅读器打开
2. 全选文本并复制（Ctrl+A, Ctrl+C）
3. 重复上述步骤2-4

**如果没有PDF：**
- 跳过这篇论文
- 只用前2篇（Psychology + Education）完成测试
- 2篇已足够验证核心功能

---

## ⏱️ 计时重要提示

**严格遵守计时规则：**

✅ **计时开始：** 在新会话中粘贴完论文文本并按回车的瞬间
✅ **计时结束：** 完整数据卡生成完毕的瞬间

❌ **不计时：**
- 准备论文文本（复制粘贴）
- 保存数据卡到文件
- 阅读或验证数据卡内容

**目标：** <5分钟/篇
**可接受：** ≤7分钟/篇（允许2分钟缓冲）

---

## ✅ 完成后检查清单

完成3篇（或2篇）论文测试后，确认：

- [ ] 所有自动生成的数据卡已保存到 `microscope_automated/` 目录
  - [ ] `hwang_2015_rct_automated.md`
  - [ ] `banda_2022_quasi_automated.md`
  - [ ] `nakashima_2003_cohort_automated.md`（如果完成）

- [ ] 提取时间已记录到 `extraction_time_log_TEMPLATE.md`
  - [ ] hwang_2015: Start/End/Duration填写完整
  - [ ] banda_2022: Start/End/Duration填写完整
  - [ ] nakashima_2003: Start/End/Duration填写完整（如果完成）

- [ ] 每篇论文的"初步观察"已填写
  - [ ] 工作流完整性勾选
  - [ ] 立即发现的错误记录
  - [ ] 明显差异记录

---

## 🎯 完成测试后回来找我

测试完成后，**回到当前这个Claude Code会话**，告诉我：

```
"测试完成，3篇论文都已提取"
```

我会帮你：
1. ✅ 分析自动提取 vs 金标准的误差
2. ✅ 计算准确率和统计指标
3. ✅ 记录真实失败模式
4. ✅ 创建Microscope v1.1（基于真实错误）
5. ✅ 更新Story 1.6为真正100%完成

---

## 🆘 遇到问题？

**常见问题：**

**Q: 新会话是什么意思？**
A: 完全关闭当前Claude Code，重新打开一个新的终端窗口并启动Claude Code。每篇论文需要独立的新会话。

**Q: Microscope运行卡住了怎么办？**
A: 等待5分钟。如果超过10分钟还没完成，记录为"超时"，标记Success为"否"，继续下一篇。

**Q: 生成的数据卡看起来不完整？**
A: 没关系，照样保存。我们后续分析时会标记这是"不完整提取"错误。

**Q: 找不到nakashima_2003 PDF？**
A: 只测试前2篇（hwang + banda）也足够验证Microscope。2篇也算完成测试。

**Q: PMC文章复制后格式乱了？**
A: 没关系，Microscope应该能处理。如果真的导致错误，这也是有价值的失败模式数据。

---

## 📊 预期结果

**如果测试成功：**
- ✅ 每篇论文提取时间 4-7分钟
- ✅ 生成完整YAML + 多个表格
- ✅ 三色标签被正确应用
- ✅ 质量评分5个领域都有

**如果遇到问题：**
- ⚠️ 提取时间>10分钟 → 记录为性能问题
- ⚠️ 数据卡不完整 → 记录为格式问题
- ⚠️ YAML解析错误 → 记录为语法问题
- ⚠️ 完全失败 → 记录为阻塞性问题

**所有结果都是有价值的数据！** 即使测试失败，也帮助我们识别真实的失败模式。

---

## 开始测试吧！🚀

**估计总时间：** 25-35分钟（3篇论文）

**准备好了吗？打开第一个新的Claude Code会话，开始测试hwang_2015！**

完成后回来告诉我结果。祝顺利！
