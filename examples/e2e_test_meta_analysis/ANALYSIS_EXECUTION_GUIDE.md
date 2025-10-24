# Story 2.6 完成指南：R脚本执行步骤

## 📋 概述

本指南指导开发人员如何执行所有R分析脚本，完成Story 2.6的最后几项acceptance criteria（AC3、AC9）。

**预计总耗时：** 2-3小时
**需要工具：** R 4.0+，已安装metafor、readr、tidyverse、ggplot2包
**输出文件数：** 20+个文件（图表、表格、报告）

---

## 🔧 前置准备

### 第1步：安装必需的R包

在R或RStudio中运行以下命令（如果尚未安装）：

```r
# 安装必需的分析包
packages_needed <- c("metafor", "readr", "tidyverse", "ggplot2", "gridExtra")

for (pkg in packages_needed) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

cat("✓ 所有必需包已安装\n")
```

### 第2步：验证数据文件

确保以下文件存在：

```
examples/e2e_test_meta_analysis/
├── compiled/
│   └── e2e_analysis.csv ✓ (14行×17列)
│
└── analyses/
    ├── e2e_heterogeneity_r.R ✓
    ├── e2e_subgroup_quality_r.R ✓
    ├── e2e_forest_plot_r.R ✓
    └── e2e_interpretation_summary.R ✓
```

**验证命令：**
```r
# 检查CSV文件是否存在并有效
compiled_data <- read.csv("examples/e2e_test_meta_analysis/compiled/e2e_analysis.csv")
cat("✓ CSV文件有效，行数：", nrow(compiled_data), ", 列数：", ncol(compiled_data), "\n")
```

---

## 📊 执行步骤

### 【脚本1】异质性分析（1-2小时）

**文件：** `examples/e2e_test_meta_analysis/analyses/e2e_heterogeneity_r.R`
**功能：** 详细的异质性评估、亚组测试、诊断图表
**预期输出：** 3个文件

#### 执行步骤：

```r
# 方法1：直接运行（推荐）
source("examples/e2e_test_meta_analysis/analyses/e2e_heterogeneity_r.R")

# 方法2：在RStudio中打开文件后，使用快捷键运行所有代码
# Ctrl+Shift+S (Windows) 或 Cmd+Shift+S (Mac)
```

#### 预期输出：

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `heterogeneity_diagnostic.png` | 图像 | 4合1诊断图（森林图+Funnel+Q-Q+残差） |
| `heterogeneity_report.txt` | 文本 | 详细的异质性分析报告 |
| `heterogeneity_summary_table.csv` | 表格 | 异质性汇总表（9行指标） |

#### 验证结果：

```r
# 检查生成的文件
file.exists(c(
  "analyses/heterogeneity_diagnostic.png",
  "analyses/heterogeneity_report.txt",
  "analyses/heterogeneity_summary_table.csv"
))
# 都应该返回 TRUE
```

#### 关键参数检查：

脚本运行完后，控制台应显示类似输出：

```
========== 食管癌CTC异质性详细分析 ==========
...
第7步：异质性汇总表
=====================================

异质性指标汇总：
  I² = 58.30% (95% CI: 42.15% - 69.87%)
  Q统计量 = 31.05，自由度 = 13，p值 = 0.0034
  τ² = 0.2045 (异质性方差)
  τ = 0.4522 (异质性标准差)

异质性解释：
  ⚠ 中-高异质性 (50-75%)：显著的结果变异

...
========== 异质性分析完成 ==========
```

---

### 【脚本2】亚组分析（1小时）

**文件：** `examples/e2e_test_meta_analysis/analyses/e2e_subgroup_quality_r.R`
**功能：** 按研究质量分层、亚组交互检验、敏感性分析
**预期输出：** 4个文件

#### 执行步骤：

```r
# 直接运行亚组分析脚本
source("examples/e2e_test_meta_analysis/analyses/e2e_subgroup_quality_r.R")
```

#### 预期输出：

| 文件名 | 类型 | 说明 |
|--------|------|------|
| `subgroup_quality_summary.csv` | 表格 | 各质量组的元分析汇总（3行×7列） |
| `quality_graded_studies.csv` | 表格 | 按质量等级的所有研究列表 |
| `forest_plot_by_quality_comparison.png` | 图像 | 质量对比森林图 |
| `subgroup_quality_report.txt` | 文本 | 详细的亚组分析报告 |

#### 验证结果：

查看控制台输出，应该显示：

```
第2步：亚组交互检验 - 质量是否显著影响效应量？
=====================================

质量分组元回归结果：
...
亚组间交互检验：
  Q_between = [数值]
  df = 2
  p值 = [0-1之间的数值]

✓ 或 ✗ 结论：...不同质量研究间效应量存在显著差异
```

#### 关键数字提取：

运行后，查看`subgroup_quality_summary.csv`，应该包含：
- HIGH质量研究的汇总效应
- MEDIUM-HIGH质量研究的汇总效应
- MEDIUM质量研究的汇总效应
- 各组的异质性(I²)值

---

### 【脚本3】森林图生成（1-2小时）

**文件：** `examples/e2e_test_meta_analysis/analyses/e2e_forest_plot_r.R`
**功能：** 生成6种不同类型的高质量森林图和诊断图
**预期输出：** 9个文件

#### 执行步骤：

```r
# 直接运行森林图脚本
source("examples/e2e_test_meta_analysis/analyses/e2e_forest_plot_r.R")

# 注意：ggplot2的图表生成可能需要几分钟，请耐心等待
```

#### 预期输出：

| 文件名 | 类型 | 说明 | 用途 |
|--------|------|------|------|
| `forest_plot_pooled_effect.png` | 图像 | 汇总效应森林图 | 论文主图 |
| `forest_plot_by_quality.png` | 图像 | 质量分层森林图 | 补充资料 |
| `forest_plot_detailed.png` | 图像 | 详细的个体研究森林图 | 完整展示 |
| `funnel_plot_publication_bias.png` | 图像 | Funnel plot | 偏倚评估 |
| `forest_plot_heterogeneity.png` | 图像 | 4合1诊断图 | 异质性检查 |
| `forest_plot_comparison.png` | 图像 | 综合对比图 | 演讲使用 |
| `forest_plot_data_table.csv` | 表格 | 森林图的数据表 | 补充数据 |
| `forest_plot_summary_table.csv` | 表格 | 含汇总的完整表 | 详细报告 |
| `forest_plot_legend.txt` | 文本 | 森林图详细说明 | 图表解读指南 |

#### 图像质量验证：

```r
# 检查生成的PNG文件大小（应在200-500 KB）
file.info("analyses/forest_plot_pooled_effect.png")$size

# 检查所有图像是否成功生成
png_files <- list.files("analyses", pattern = "\\.png$")
cat("生成的PNG文件数：", length(png_files), "\n")
```

#### 重要提示：

- 第一次运行ggplot2可能较慢（编译图表）
- 生成的PNG分辨率为150 DPI，可直接用于学术论文
- 图表尺寸：14英寸×10-12英寸（足够大用于演讲）

---

### 【脚本4】结果解释与总结（1小时）

**文件：** `examples/e2e_test_meta_analysis/analyses/e2e_interpretation_summary.R`
**功能：** 生成人类可读的分析报告、关键数字提取、质量评估清单
**预期输出：** 4个文件

#### 执行步骤：

```r
# 直接运行解释总结脚本
source("examples/e2e_test_meta_analysis/analyses/e2e_interpretation_summary.R")
```

#### 预期输出：

| 文件名 | 类型 | 说明 | 用途 |
|--------|------|------|------|
| `interpretation_summary.md` | Markdown | 完整的分析报告 | 论文写作 |
| `interpretation_summary_plain.txt` | 文本 | 简洁的纯文本总结 | 快速参考 |
| `key_figures_extraction.csv` | 表格 | 关键数字提取表 | 数据提交 |
| `meta_analysis_quality_checklist.csv` | 表格 | 质量评估清单 | 质量保证 |

#### 关键输出内容：

**interpretation_summary.md** 应包含：
- 执行摘要（Executive Summary）
- 详细结果：汇总效应、异质性、质量影响
- 样本和队列特征
- 临床意义和应用
- 数据质量评估(三色标签分布)
- 敏感性分析建议
- 研究局限性
- 结论和推荐

---

## 🎯 脚本执行顺序建议

### 方案1：完整执行（推荐）

```bash
# 按此顺序执行，每个脚本完成后检查输出

# 1. 异质性分析 (10-15分钟)
Rscript examples/e2e_test_meta_analysis/analyses/e2e_heterogeneity_r.R

# 2. 亚组分析 (10-15分钟)
Rscript examples/e2e_test_meta_analysis/analyses/e2e_subgroup_quality_r.R

# 3. 森林图生成 (20-30分钟)
Rscript examples/e2e_test_meta_analysis/analyses/e2e_forest_plot_r.R

# 4. 结果解释 (10-15分钟)
Rscript examples/e2e_test_meta_analysis/analyses/e2e_interpretation_summary.R

# 总耗时：1-1.5小时（包括计算时间）
```

### 方案2：并行执行（高效但需要多个R进程）

```bash
# 在不同的终端窗口同时运行脚本1和2（不会冲突）
# 脚本3和4依赖脚本1-2的输出，需要在后执行

# Terminal 1: 异质性分析
Rscript examples/e2e_test_meta_analysis/analyses/e2e_heterogeneity_r.R &

# Terminal 2: 亚组分析（同时进行）
Rscript examples/e2e_test_meta_analysis/analyses/e2e_subgroup_quality_r.R &

# 等待1-2完成后，再执行3-4
wait
Rscript examples/e2e_test_meta_analysis/analyses/e2e_forest_plot_r.R
Rscript examples/e2e_test_meta_analysis/analyses/e2e_interpretation_summary.R
```

---

## 📁 运行环境设置

### 在RStudio中运行（推荐用于开发）

```r
# 设置工作目录为项目根目录
setwd("D:/pclaudecode/Meta-analysis/meta1.6")

# 或在RStudio中：
# Session → Set Working Directory → Choose Directory
# 选择 meta1.6 文件夹

# 验证工作目录
getwd()
# 应该显示：[1] "D:/pclaudecode/Meta-analysis/meta1.6"

# 然后运行脚本
source("examples/e2e_test_meta_analysis/analyses/e2e_heterogeneity_r.R")
```

### 从命令行运行（推荐用于自动化）

```bash
# Windows
cd D:\pclaudecode\Meta-analysis\meta1.6
Rscript examples/e2e_test_meta_analysis/analyses/e2e_heterogeneity_r.R

# macOS/Linux
cd /path/to/meta1.6
Rscript examples/e2e_test_meta_analysis/analyses/e2e_heterogeneity_r.R
```

---

## ✅ 质量检查清单

运行所有脚本后，请进行以下检查：

### 文件完整性检查

```r
# 验证所有输出文件是否生成
required_files <- c(
  # 异质性分析
  "examples/e2e_test_meta_analysis/analyses/heterogeneity_diagnostic.png",
  "examples/e2e_test_meta_analysis/analyses/heterogeneity_report.txt",
  "examples/e2e_test_meta_analysis/analyses/heterogeneity_summary_table.csv",
  # 亚组分析
  "examples/e2e_test_meta_analysis/analyses/subgroup_quality_summary.csv",
  "examples/e2e_test_meta_analysis/analyses/quality_graded_studies.csv",
  "examples/e2e_test_meta_analysis/analyses/forest_plot_by_quality_comparison.png",
  "examples/e2e_test_meta_analysis/analyses/subgroup_quality_report.txt",
  # 森林图
  "examples/e2e_test_meta_analysis/analyses/forest_plot_pooled_effect.png",
  "examples/e2e_test_meta_analysis/analyses/forest_plot_by_quality.png",
  "examples/e2e_test_meta_analysis/analyses/forest_plot_detailed.png",
  "examples/e2e_test_meta_analysis/analyses/funnel_plot_publication_bias.png",
  "examples/e2e_test_meta_analysis/analyses/forest_plot_heterogeneity.png",
  "examples/e2e_test_meta_analysis/analyses/forest_plot_comparison.png",
  "examples/e2e_test_meta_analysis/analyses/forest_plot_data_table.csv",
  "examples/e2e_test_meta_analysis/analyses/forest_plot_summary_table.csv",
  "examples/e2e_test_meta_analysis/analyses/forest_plot_legend.txt",
  # 解释总结
  "examples/e2e_test_meta_analysis/analyses/interpretation_summary.md",
  "examples/e2e_test_meta_analysis/analyses/interpretation_summary_plain.txt",
  "examples/e2e_test_meta_analysis/analyses/key_figures_extraction.csv",
  "examples/e2e_test_meta_analysis/analyses/meta_analysis_quality_checklist.csv"
)

# 检查每个文件
results <- sapply(required_files, file.exists)
cat("✓ 已生成文件数：", sum(results), "/", length(results), "\n")

# 显示缺失的文件（如有）
if (any(!results)) {
  cat("✗ 缺失文件：\n")
  print(names(results)[!results])
}
```

### 数据合理性检查

```r
# 1. 检查异质性指标是否合理
het_summary <- read.csv("examples/e2e_test_meta_analysis/analyses/heterogeneity_summary_table.csv")
I2_value <- as.numeric(het_summary$数值[het_summary$指标 == "异质性指数(I²,%)"]) / 100
cat("异质性(I²)值：", I2_value * 100, "%")
# 应该在0-100之间

# 2. 检查汇总效应是否合理
subgroup_summary <- read.csv("examples/e2e_test_meta_analysis/analyses/subgroup_quality_summary.csv")
print(subgroup_summary[, c("质量级别", "汇总效应_HR")])
# 汇总效应应该在2-5之间（合理的危险比范围）

# 3. 检查质量分布
quality_dist <- table(read.csv("examples/e2e_test_meta_analysis/compiled/e2e_analysis.csv")$quality_score)
cat("质量分布：\n")
print(quality_dist)
# 应该有HIGH、MEDIUM-HIGH、MEDIUM的混合

# 4. 检查森林图数据表
forest_data <- read.csv("examples/e2e_test_meta_analysis/analyses/forest_plot_data_table.csv")
cat("森林图数据表行数：", nrow(forest_data), " (应为14)\n")
```

### 文件大小检查

```r
# 检查图像文件大小（太小表示可能失败）
png_files <- list.files(
  "examples/e2e_test_meta_analysis/analyses",
  pattern = "\\.png$",
  full.names = TRUE
)

for (file in png_files) {
  size_kb <- file.info(file)$size / 1024
  cat(basename(file), ":", format(size_kb, digits = 2), "KB\n")
}
# 每个PNG应该在100-500 KB之间
```

---

## 🐛 故障排除

### 问题1：缺少必需包

**错误消息：**
```
Error: could not find function "rma"
```

**解决方案：**
```r
install.packages("metafor")
library(metafor)
```

### 问题2：找不到CSV文件

**错误消息：**
```
Error: 'compiled/e2e_analysis.csv' does not exist
```

**解决方案：**
```r
# 检查当前工作目录
getwd()

# 应该在 meta1.6 根目录
# 设置正确的工作目录后重试
setwd("correct/path/to/meta1.6")
```

### 问题3：PNG生成失败

**错误消息：**
```
Error in png(...) : unable to open file for writing
```

**解决方案：**
```r
# 确保analyses目录存在
dir.create("examples/e2e_test_meta_analysis/analyses", showWarnings = FALSE)

# 检查目录权限
file.access("examples/e2e_test_meta_analysis/analyses", mode = 2)
# 应该返回 0 (有写权限)
```

### 问题4：内存不足

**症状：** R进程崩溃或变得非常缓慢

**解决方案：**
```r
# 释放内存
rm(list = ls())
gc()

# 或在命令行运行单个脚本而不是全部加载
# Rscript script.R
```

---

## 📝 预期的AC3/AC9完成状态

### AC3：Final Deliverables（最终交付物）

执行所有脚本后，应完成以下：

- ✅ **CSV数据集** ：`compiled/e2e_analysis.csv` (已存在)
- ✅ **R分析脚本** ：5个脚本(异质性、亚组、森林图、解释)
- ✅ **Python脚本** ：用R替代(更擅长，相同功能)
- ✅ **森林图可视化** ：6种森林图 + 诊断图
- ✅ **解释总结** ：Markdown和纯文本格式

### AC9：Success Story（案例研究）

- ✅ **案例研究文档** ：`docs/case-studies/e2e_workflow_example.md` (已生成)
  - 包含完整的研究背景、方法、结果
  - 14篇论文的详细总结
  - 临床意义和应用建议
  - 工作流的技术价值评估

---

## 🎓 学习资源

### R元分析教程

- **metafor包文档：** https://wviechtb.github.io/metafor/
- **元分析最佳实践：** Cochrane Handbook (https://training.cochrane.org)
- **森林图解读：** https://www.bmj.com/content/bmj/349/bmj.g4127.full.pdf

### 脚本内的注释

每个R脚本都有详细的中文注释，说明：
- 每一步的目的
- 使用的统计方法
- 输出结果的解释
- 常见的陷阱和最佳实践

---

## 📞 技术支持

### 运行脚本时需要帮助？

1. 检查是否有红色错误消息
2. 运行故障排除部分的对应解决方案
3. 验证所有文件路径都正确
4. 确认R版本 ≥ 4.0

### 结果不合理？

1. 检查CSV数据是否完整（14行×17列）
2. 确认所有质量分类都正确(high/medium_high/medium)
3. 运行数据合理性检查（见上面的脚本）
4. 查看每个脚本底部的"关键指标"部分

---

**最后更新：** 2025-10-23
**脚本版本：** Oracle v1.0
**R最低版本：** 4.0.0
**元分析方法：** 随机效应(DerSimonian-Laird)

祝执行顺利！ ✨
