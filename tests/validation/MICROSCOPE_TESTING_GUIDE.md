# Microscope v1.0 自动化测试指南

**创建日期：** 2025-10-21
**目的：** 完成Story 1.6核心验收标准 - 实际测试Microscope自动化工具

---

## 测试目标

通过实际运行Microscope v1.0处理3篇论文，验证：
1. **自动化可行性** - Microscope能否成功生成数据卡
2. **提取时间** - 是否达到<5分钟目标
3. **准确性** - 自动提取vs金标准的误差率
4. **失败模式** - 记录真实错误，不是预测
5. **提示词改进** - 基于真实错误创建v1.1

---

## 测试论文选择

从11篇已获取论文中选择3篇进行测试，优先选择**已有金标准**的论文以便对比：

### 推荐测试组合（跨学科）

**论文1：hwang_2015_rct（Psychology）**
- **金标准：** ✅ 已完成（136个数据点，51%🟢/21%🟡/28%🔴）
- **论文信息：** Hwang et al., Psychiatric Services 2015, PMC4591116
- **特点：** 简单2臂RCT, n=50, 中等复杂度
- **PMC链接：** https://pmc.ncbi.nlm.nih.gov/articles/PMC4591116/
- **预期挑战：** 缺失统计细节（端点SDs），完成者分析偏倚

**论文2：banda_2022_quasi（Education）**
- **金标准：** ✅ 已完成（130个数据点，43%🟢/22%🟡/35%🔴）
- **论文信息：** Banda & Nzabahimana, J Sci Educ Technol 2022, PMC9761040
- **特点：** 准实验设计, n=280, 双重结局（成就+动机）
- **PMC链接：** https://pmc.ncbi.nlm.nih.gov/articles/PMC9761040/
- **预期挑战：** 干预细节稀疏，7个动机构念部分缺失统计

**论文3：nakashima_2003_cohort（Medicine）**
- **金标准：** ✅ 已完成（~120个数据点，54%🟢/33%🟡/13%🔴）
- **论文信息：** Nakashima et al., Surgery 2003
- **特点：** 前瞻性队列, n=54, 3个时间点采样
- **文件位置：** `examples/sample_meta_analysis/source_papers/`（如果有PDF）
- **预期挑战：** 多时间点CTC检测，生存分析数据

---

## 测试流程（每篇论文）

### 步骤1：准备论文文本

**选项A：PMC开放获取论文**（推荐用于hwang_2015和banda_2022）

1. 打开PMC链接
2. 点击右上角"PMC Full Text"
3. 复制全文（包括标题、作者、摘要、正文、表格、参考文献）

**选项B：PDF论文**（用于nakashima_2003如果有PDF）

1. 使用PDF阅读器打开论文
2. 复制全文文本
3. 或者将PDF直接上传到Claude Code（如果支持）

---

### 步骤2：在新Claude Code会话中运行Microscope

**⚠️ 重要：必须在新的独立会话中运行，不要在当前会话中测试**

**操作步骤：**

1. **打开新的Claude Code会话**（新终端窗口）

2. **加载Microscope v1.0 prompt**
   - 方式1：手动复制 `prompts/microscope/microscope_v1.0.md` 全文
   - 方式2：使用命令（如果Claude Code支持文件引用）

3. **开始计时** ⏱️
   - 记录开始时间：当你粘贴完论文文本后按回车的瞬间

4. **粘贴论文全文**
   - 在Microscope prompt后面粘贴完整论文文本
   - 包括：标题、作者、摘要、方法、结果、表格、参考文献

5. **让Claude Code完成提取**
   - 等待Claude Code完成3个阶段：Screening → Quality → Data Extraction
   - 不要中断，让它自动完成整个流程

6. **停止计时** ⏱️
   - 当数据卡完全生成（看到完整YAML frontmatter + 所有表格）时停止计时
   - 记录总提取时间（分钟:秒）

---

### 步骤3：保存自动生成的数据卡

**文件命名：**
```
tests/validation/microscope_automated/{study_id}_automated.md
```

**示例：**
- `hwang_2015_rct_automated.md`
- `banda_2022_quasi_automated.md`
- `nakashima_2003_cohort_automated.md`

**保存方法：**
1. 复制Claude Code生成的完整数据卡（从`---`开始到最后）
2. 在项目目录创建文件 `tests/validation/microscope_automated/`（如果不存在）
3. 保存为对应文件名

---

### 步骤4：记录提取时间和初步观察

**立即记录到：** `tests/validation/extraction_time_log.md`

**记录内容：**

| Paper ID | Discipline | Start Time | End Time | Duration (min:sec) | Word Count | Pages | Notes |
|----------|-----------|------------|----------|-------------------|------------|-------|-------|
| hwang_2015_rct | Psychology | 14:23:00 | 14:27:30 | 4:30 | ~8,500 | 7 | 流程顺利，所有3个阶段完成 |
| banda_2022_quasi | Education | 14:35:00 | 14:41:15 | 6:15 | ~12,000 | 9 | 复杂度更高，7个动机构念 |
| nakashima_2003_cohort | Medicine | 15:00:00 | 15:04:45 | 4:45 | ~9,000 | 8 | 多时间点采样处理良好 |

**初步观察示例：**
- ✅ Claude Code成功完成所有3个阶段
- ✅ 生成了完整的YAML frontmatter
- ⚠️ 质量评分有1处可能不准确（需对比金标准）
- ❌ 缺失了2个基线特征（在金标准中有）

---

## 对比分析流程

完成3篇论文的自动提取后，进行系统对比：

### 步骤1：创建误差对比表

**对于每篇论文，创建：** `tests/validation/accuracy_comparison_{study_id}.md`

**对比维度：**

1. **数据点准确性**
   - 总数据点数：自动提取 vs 金标准
   - 正确值数量
   - 错误值数量（值不匹配）
   - 缺失数据点（金标准有但自动提取漏掉）
   - 多余数据点（自动提取有但金标准没有/幻觉）

2. **源标签准确性**
   - 🟢🟡🔴 分布：自动 vs 金标准
   - 标签错误数量（如：应该🔴但标了🟢）
   - 证据缺失数量（标签有但证据不完整）

3. **质量评分对比**
   - 5个领域评分：自动 vs 金标准
   - 总体质量评分：自动 vs 金标准
   - 不一致的领域及原因

**示例对比表格式：**

```markdown
# hwang_2015_rct - 自动提取 vs 金标准对比

## 数据点准确性

| 类别 | 金标准 | 自动提取 | 差异 | 准确率 |
|------|--------|---------|------|--------|
| 总数据点 | 136 | 128 | -8 | 94.1% |
| 正确值 | - | 115 | - | 84.6% |
| 错误值 | - | 5 | - | 3.7% |
| 缺失数据点 | - | 8 | - | 5.9% |
| 幻觉数据点 | - | 0 | - | 0% |

## 源标签分布对比

| 标签 | 金标准 | 自动提取 | 差异 |
|------|--------|---------|------|
| 🟢 | 51% (69) | 48% (61) | -8 |
| 🟡 | 21% (29) | 23% (30) | +1 |
| 🔴 | 28% (38) | 29% (37) | -1 |

## 质量评分对比

| 领域 | 金标准 | 自动提取 | 一致？ |
|------|--------|---------|--------|
| Selection Bias | MEDIUM | MEDIUM | ✅ |
| Measurement Validity | LOW | LOW | ✅ |
| Confounding Control | LOW | LOW | ✅ |
| Attrition/Missing Data | **HIGH** | **MEDIUM** | ❌ **关键差异** |
| Reporting Transparency | MEDIUM | MEDIUM | ✅ |
| **Overall Quality** | **MEDIUM** | **MEDIUM** | ✅ |

## 关键错误示例

### 错误1：缺失端点标准差
- **金标准：** CA-CBT endpoint SD: not_reported 🔴
- **自动提取：** 数据点缺失（完全没有提取这个字段）
- **类型：** Missing Data Point (MODERATE)
- **影响：** 无法完整评估统计报告质量

### 错误2：退出率领域评分过于乐观
- **金标准：** Attrition/Missing Data: HIGH (completers-only analysis)
- **自动提取：** Attrition/Missing Data: MEDIUM
- **类型：** Quality Assessment Error (MODERATE)
- **原因：** 未识别completers-only分析自动触发HIGH风险
- **影响：** 低估了偏倚风险

### 错误3：基线特征值不匹配
- **金标准：** Mean age: 42.3 years 🟢 (Table 1, p. 329)
- **自动提取：** Mean age: 42 years 🟢 (Table 1, p. 329)
- **类型：** Incorrect Value (MINOR - 精度差异)
- **原因：** 可能四舍五入或OCR问题
```

---

### 步骤2：计算总体准确性指标

**汇总3篇论文的对比结果：** `tests/validation/overall_accuracy_summary.md`

**关键指标：**

1. **数据点级准确率**
   ```
   准确率 = (正确值数量) / (金标准总数据点)

   示例：
   - hwang_2015: 115/136 = 84.6%
   - banda_2022: 108/130 = 83.1%
   - nakashima_2003: 105/120 = 87.5%
   - **总体准确率：** 328/386 = 85.0%
   ```

2. **标签分布对比**
   ```
   金标准：52%🟢 / 27%🟡 / 21%🔴
   自动提取：50%🟢 / 25%🟡 / 25%🔴

   差异分析：
   - 🟢 slightly lower (-2%)
   - 🔴 slightly higher (+4%) - 可能过于保守
   ```

3. **质量评分一致性**
   ```
   15个领域评分（3篇论文 × 5领域）：
   - 完全一致：11/15 (73.3%)
   - 差1级（LOW↔MEDIUM或MEDIUM↔HIGH）：3/15 (20%)
   - 差2级（LOW↔HIGH）：1/15 (6.7%)
   ```

4. **提取时间**
   ```
   平均提取时间：5.1分钟
   - hwang_2015: 4:30
   - banda_2022: 6:15
   - nakashima_2003: 4:45

   vs 目标：<5分钟
   vs 手工基线：166分钟
   **时间节省：96.9%**
   ```

---

## 失败模式记录

**更新：** `tests/validation/failure_modes.md`

将预测的失败模式替换为**真实观察到的错误**：

### 真实失败模式模板

```markdown
## Category 1: Incorrect Values (CRITICAL)

### Failure Mode 1.1: Precision Loss in Numeric Extraction

**Observed Frequency:** 3/386 data points (0.8%)
**Severity:** MINOR (精度差异) to MODERATE (实质差异)

**Examples:**
1. **hwang_2015, baseline age:**
   - Gold Standard: 42.3 years
   - Automated: 42 years
   - Error: 0.3-year difference (likely rounding)

2. **banda_2022, achievement posttest:**
   - Gold Standard: 63.85
   - Automated: 63.9
   - Error: 0.05 difference (acceptable rounding)

**Root Cause:**
- Microscope可能从不同源提取（文本 vs 表格）
- OCR精度问题（如果使用PDF）
- 四舍五入策略不一致

**Mitigation:**
- Short-term: Manual verification for critical values
- Long-term: Strengthen prompt to prefer table values over text, specify rounding rules
```

---

## Microscope v1.1 创建流程

基于真实错误数据创建改进版本：

### 步骤1：分析错误模式

从3篇论文的对比中识别：
1. **高频错误**（出现在2+篇论文）
2. **关键错误**（影响元分析结果）
3. **可通过prompt改进的错误**

### 步骤2：起草v1.1改进

**示例改进（基于假设的真实错误）：**

如果发现错误：**Completers-only分析未被识别为HIGH风险**

**v1.1改进：**
```markdown
#### Domain 4: Attrition/Missing Data

**CRITICAL RULE - Completers-Only Analysis:**

If the study analyzed ONLY participants who completed the intervention (not intention-to-treat), this domain is **automatically HIGH RISK**, regardless of other factors.

**Red Flags for Completers-Only Analysis:**
- Phrases like "completers analysis," "per-protocol analysis," "participants who completed"
- Sample sizes in results tables smaller than randomized N
- No mention of "intention-to-treat" (ITT) analysis

**Automatic HIGH Risk Triggers:**
- ❌ "25 participants completed CA-CBT, 17 completed CBT" → HIGH if randomized N was larger
- ❌ Differential attrition >10% between groups → HIGH
- ❌ No ITT analysis mentioned in RCT → HIGH
```

### 步骤3：创建microscope_v1.1.md

```bash
# 复制v1.0
cp prompts/microscope/microscope_v1.0.md prompts/microscope/microscope_v1.1.md

# 编辑v1.1，添加改进
# 更新元数据：
# Version: 1.1
# Created: 2025-10-21
# Tested with: hwang_2015, banda_2022, nakashima_2003 (3 papers, 386 data points)

# 更新CHANGELOG
```

**CHANGELOG.md示例：**
```markdown
## v1.1 (2025-10-21)

**Testing Basis:** Story 1.6 empirical testing with 3 papers (Psychology, Education, Medicine)
**Overall Accuracy:** 85.0% data point agreement (328/386 correct)
**Extraction Time:** Avg 5.1 min/paper (96.9% faster than manual baseline)

### Improvements

**1. Strengthened Attrition Domain Guidance**
- Added automatic HIGH risk trigger for completers-only analysis
- Clarified differential attrition thresholds (>10% = HIGH)
- Emphasized ITT analysis importance in RCTs

**2. Improved Conservative Labeling Triggers**
- Added discipline-specific examples (Psychology: missing SDs, Education: intervention details)
- Strengthened "when in doubt, use 🔴" decision tree
- Added red flags for incomplete statistical reporting

**3. Enhanced Evidence Requirements**
- Specified preference for table values over text when precision differs
- Required explicit page AND table/section reference for all 🟢 labels
- Mandated calculation verification for all 🟡 effect sizes

### Bug Fixes

**Fixed:** Quality assessment inconsistency where completers-only analysis was rated MEDIUM instead of HIGH
**Fixed:** Missing data point detection - added checklist for commonly unreported fields (endpoint SDs, subgroup ns)

### Testing Results

| Paper | Data Points | Accuracy | Time | Key Issues |
|-------|------------|----------|------|-----------|
| hwang_2015 (Psychology) | 136 | 84.6% | 4:30 | Missed completers-only HIGH risk |
| banda_2022 (Education) | 130 | 83.1% | 6:15 | Intervention detail gaps |
| nakashima_2003 (Medicine) | 120 | 87.5% | 4:45 | Multi-timepoint handling good |

**Overall:** 85% accuracy meets beta testing threshold; remaining 15% errors mostly moderate severity
```

---

## 测试完成检查清单

完成3篇论文测试后，确认：

- [ ] 3篇自动生成的数据卡已保存到 `tests/validation/microscope_automated/`
- [ ] 提取时间已记录到 `extraction_time_log.md`
- [ ] 3篇对比分析已完成（`accuracy_comparison_{study_id}.md`）
- [ ] 总体准确性指标已计算（`overall_accuracy_summary.md`）
- [ ] 真实失败模式已记录（更新 `failure_modes.md`）
- [ ] Microscope v1.1已创建（`prompts/microscope/microscope_v1.1.md`）
- [ ] CHANGELOG已更新（`prompts/microscope/CHANGELOG.md`）
- [ ] Story 1.6状态已更新为"真正100%完成"

---

## 预期结果

**成功标准：**
- ✅ 提取时间 ≤ 7分钟（允许2分钟缓冲）
- ✅ 数据点准确率 ≥ 80%
- ✅ 质量评分一致性 ≥ 70%
- ✅ 所有关键数据点都被提取（即使标为🔴）
- ✅ 无幻觉数据（完全虚构的值）
- ✅ 至少识别3-5个可改进的真实错误模式

**如果未达标：**
- < 80% 准确率 → 分析根本原因，考虑prompt重大重构
- > 10分钟提取时间 → 检查论文长度，可能需要调整目标
- 发现幻觉数据 → 关键问题，必须在v1.1中解决

---

## 下一步行动

完成测试后：
1. 更新 `tests/validation/TESTING_STATUS.md` 为"Automation Testing Complete"
2. 更新 `docs/stories/1.6.test-microscope-sample-papers.md` 状态为"真正100%完成（实证验证）"
3. 提交所有更新到git
4. 准备Story 1.6最终报告
5. 继续Story 1.7（CI/CD Pipeline）

---

**祝测试顺利！有任何问题随时询问。**
