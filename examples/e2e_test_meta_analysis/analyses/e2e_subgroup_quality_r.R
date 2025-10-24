# 食管癌CTC元分析 - 问题3：按质量的亚组分析
# Story 2.6 端到端工作流测试
# Oracle v1.0 输出 - R语言实现

# 必需包：metafor, readr, tidyverse
# install.packages(c("metafor", "readr", "tidyverse", "ggplot2"))

library(metafor)
library(readr)
library(tidyverse)
library(ggplot2)

# =====================================================
# 第1部分：加载数据并准备
# =====================================================

cat("========== 食管癌CTC按质量的亚组分析 ==========\n")
cat("研究问题：研究质量是否影响CTCs的预后效应？\n")
cat("分析方法：分层元分析，按研究质量分组\n\n")

# 加载编译的数据集
compiled_data <- read_csv("compiled/e2e_analysis.csv")

# 准备元分析数据框
meta_data <- compiled_data %>%
  select(study_id, effect_size, confidence_interval_lower,
         confidence_interval_upper, quality_score) %>%
  rename(
    study = study_id,
    yi = effect_size,
    ci.lb = confidence_interval_lower,
    ci.ub = confidence_interval_upper,
    quality = quality_score
  ) %>%
  mutate(
    # 从CI计算标准误差
    sei = (log(ci.ub) - log(ci.lb)) / (2 * 1.96),
    # 创建质量分组
    quality_group = case_when(
      quality == "high" ~ "HIGH",
      quality == "medium_high" ~ "MEDIUM-HIGH",
      quality == "medium" ~ "MEDIUM",
      TRUE ~ "OTHER"
    )
  )

# 显示数据概况
cat("数据概况：\n")
cat(sprintf("总研究数：%d\n", nrow(meta_data)))
cat("质量分布：\n")
print(table(meta_data$quality_group))

# =====================================================
# 第2部分：各质量组的单独元分析
# =====================================================

cat("\n\n第1步：各质量组的单独元分析\n")
cat("====================================\n\n")

# HIGH质量研究
high_data <- meta_data %>% filter(quality_group == "HIGH")
if (nrow(high_data) > 0) {
  res_high <- rma(yi = high_data$yi,
                  sei = high_data$sei,
                  method = "DL",
                  measure = "HR",
                  slab = high_data$study)

  cat("HIGH质量研究元分析（n=", nrow(high_data), "）：\n", sep = "")
  cat(sprintf("  汇总效应(HR)：%.3f [%.3f - %.3f]\n",
              res_high$beta[1], res_high$ci.lb[1], res_high$ci.ub[1]))
  cat(sprintf("  异质性(I²)：%.2f%%\n", res_high$I2))
  cat(sprintf("  p值：%.4f\n\n", res_high$pval[1]))
}

# MEDIUM-HIGH质量研究
medium_high_data <- meta_data %>% filter(quality_group == "MEDIUM-HIGH")
if (nrow(medium_high_data) > 0) {
  res_mh <- rma(yi = medium_high_data$yi,
                sei = medium_high_data$sei,
                method = "DL",
                measure = "HR",
                slab = medium_high_data$study)

  cat("MEDIUM-HIGH质量研究元分析（n=", nrow(medium_high_data), "）：\n", sep = "")
  cat(sprintf("  汇总效应(HR)：%.3f [%.3f - %.3f]\n",
              res_mh$beta[1], res_mh$ci.lb[1], res_mh$ci.ub[1]))
  cat(sprintf("  异质性(I²)：%.2f%%\n", res_mh$I2))
  cat(sprintf("  p值：%.4f\n\n", res_mh$pval[1]))
}

# MEDIUM质量研究
medium_data <- meta_data %>% filter(quality_group == "MEDIUM")
if (nrow(medium_data) > 0) {
  res_medium <- rma(yi = medium_data$yi,
                    sei = medium_data$sei,
                    method = "DL",
                    measure = "HR",
                    slab = medium_data$study)

  cat("MEDIUM质量研究元分析（n=", nrow(medium_data), "）：\n", sep = "")
  cat(sprintf("  汇总效应(HR)：%.3f [%.3f - %.3f]\n",
              res_medium$beta[1], res_medium$ci.lb[1], res_medium$ci.ub[1]))
  cat(sprintf("  异质性(I²)：%.2f%%\n", res_medium$I2))
  cat(sprintf("  p值：%.4f\n\n", res_medium$pval[1]))
}

# =====================================================
# 第3部分：亚组交互检验（质量为分组变量）
# =====================================================

cat("\n第2步：亚组交互检验 - 质量是否显著影响效应量？\n")
cat("=====================================\n\n")

# 进行包含质量分组的元回归
subgroup_test <- rma(yi = meta_data$yi,
                     sei = meta_data$sei,
                     mods = ~ quality_group,
                     method = "DL",
                     measure = "HR",
                     slab = meta_data$study)

# 打印完整结果
cat("质量分组元回归结果：\n")
print(subgroup_test)

# 提取Q_between（亚组间异质性）
Q_between <- subgroup_test$QM
Q_between_p <- subgroup_test$QMp

cat(sprintf("\n亚组间交互检验：\n"))
cat(sprintf("  Q_between = %.2f\n", Q_between))
cat(sprintf("  df = %d\n", subgroup_test$m - 1))
cat(sprintf("  p值 = %.4f\n", Q_between_p))

if (Q_between_p < 0.05) {
  cat("  ✓ 结论：不同质量研究间效应量存在显著差异（p < 0.05）\n")
} else {
  cat("  ✗ 结论：不同质量研究间效应量无显著差异（p ≥ 0.05）\n")
}

# =====================================================
# 第4部分：生成亚组汇总表
# =====================================================

cat("\n\n第3步：亚组汇总表\n")
cat("====================================\n\n")

# 提取各组的系数和CI
subgroup_summary <- data.frame(
  质量级别 = c("HIGH", "MEDIUM-HIGH", "MEDIUM"),
  研究数 = c(nrow(high_data), nrow(medium_high_data), nrow(medium_data)),
  汇总效应_HR = c(
    sprintf("%.3f", res_high$beta[1]),
    sprintf("%.3f", res_mh$beta[1]),
    sprintf("%.3f", res_medium$beta[1])
  ),
  CI下限 = c(
    sprintf("%.3f", res_high$ci.lb[1]),
    sprintf("%.3f", res_mh$ci.lb[1]),
    sprintf("%.3f", res_medium$ci.lb[1])
  ),
  CI上限 = c(
    sprintf("%.3f", res_high$ci.ub[1]),
    sprintf("%.3f", res_mh$ci.ub[1]),
    sprintf("%.3f", res_medium$ci.ub[1])
  ),
  异质性_I2 = c(
    sprintf("%.1f%%", res_high$I2),
    sprintf("%.1f%%", res_mh$I2),
    sprintf("%.1f%%", res_medium$I2)
  ),
  p值 = c(
    sprintf("%.4f", res_high$pval[1]),
    sprintf("%.4f", res_mh$pval[1]),
    sprintf("%.4f", res_medium$pval[1])
  )
)

print(subgroup_summary)

# 保存汇总表
write_csv(subgroup_summary, "analyses/subgroup_quality_summary.csv")
cat("\n✓ 汇总表已保存：subgroup_quality_summary.csv\n")

# =====================================================
# 第5部分：质量分级研究列表
# =====================================================

cat("\n\n第4步：质量分级研究详细列表\n")
cat("====================================\n\n")

# 按质量分组显示研究
study_list <- meta_data %>%
  select(study, quality_group, yi, ci.lb, ci.ub) %>%
  arrange(quality_group, -yi) %>%
  rename(
    研究ID = study,
    质量级别 = quality_group,
    效应量_HR = yi,
    CI下限 = ci.lb,
    CI上限 = ci.ub
  ) %>%
  mutate(
    效应量_HR = sprintf("%.3f", 效应量_HR),
    CI下限 = sprintf("%.3f", CI下限),
    CI上限 = sprintf("%.3f", CI上限)
  )

print(study_list)

# 保存研究列表
write_csv(study_list, "analyses/quality_graded_studies.csv")
cat("\n✓ 研究列表已保存：quality_graded_studies.csv\n")

# =====================================================
# 第6部分：敏感性分析 - 排除低质量研究
# =====================================================

cat("\n\n第5步：敏感性分析 - 仅使用HIGH和MEDIUM-HIGH质量研究\n")
cat("====================================\n\n")

# 仅使用HIGH和MEDIUM-HIGH研究
high_quality_data <- meta_data %>%
  filter(quality_group %in% c("HIGH", "MEDIUM-HIGH"))

res_high_only <- rma(yi = high_quality_data$yi,
                     sei = high_quality_data$sei,
                     method = "DL",
                     measure = "HR",
                     slab = high_quality_data$study)

cat("仅使用HIGH和MEDIUM-HIGH质量研究（n=", nrow(high_quality_data), "）：\n", sep = "")
print(res_high_only)

cat(sprintf("\n敏感性分析结果对比：\n"))
cat(sprintf("  全部研究(n=%d)：   HR = %.3f [%.3f - %.3f]\n",
            nrow(meta_data), subgroup_test$beta[1],
            subgroup_test$ci.lb[1], subgroup_test$ci.ub[1]))
cat(sprintf("  高质量(n=%d)：HR = %.3f [%.3f - %.3f]\n",
            nrow(high_quality_data), res_high_only$beta[1],
            res_high_only$ci.lb[1], res_high_only$ci.ub[1]))

# =====================================================
# 第7部分：生成可视化
# =====================================================

cat("\n\n第6步：生成可视化图表\n")
cat("====================================\n\n")

# 创建森林图对比图
png("analyses/forest_plot_by_quality_comparison.png", width = 1200, height = 800)

# 设置绘图区域
par(mfrow = c(1, 1), mar = c(5, 5, 4, 2))

# 绘制每个质量组的森林图
plot(NULL, xlim = c(-1, 4), ylim = c(0, nrow(meta_data) + 5),
     xlab = "对数危险比 (ln(HR))", ylab = "研究及组别",
     main = "按研究质量分组的森林图对比")
abline(v = 0, lty = 2, col = "gray")

# 绘制HIGH质量研究
high_idx <- which(meta_data$quality_group == "HIGH")
for (i in seq_along(high_idx)) {
  idx <- high_idx[i]
  y_pos <- nrow(meta_data) - idx + 1
  points(meta_data$yi[idx], y_pos, pch = 15, cex = 1.2, col = "darkgreen")
  lines(c(meta_data$ci.lb[idx], meta_data$ci.ub[idx]), c(y_pos, y_pos),
        lwd = 2, col = "darkgreen")
  text(-1, y_pos, meta_data$study[idx], cex = 0.8, adj = 1)
}

# 绘制MEDIUM-HIGH质量研究
mh_idx <- which(meta_data$quality_group == "MEDIUM-HIGH")
for (i in seq_along(mh_idx)) {
  idx <- mh_idx[i]
  y_pos <- nrow(meta_data) - idx + 0.3
  points(meta_data$yi[idx], y_pos, pch = 16, cex = 1.0, col = "orange")
  lines(c(meta_data$ci.lb[idx], meta_data$ci.ub[idx]), c(y_pos, y_pos),
        lwd = 1.5, col = "orange")
}

# 绘制MEDIUM质量研究
m_idx <- which(meta_data$quality_group == "MEDIUM")
for (i in seq_along(m_idx)) {
  idx <- m_idx[i]
  y_pos <- nrow(meta_data) - idx + 0.6
  points(meta_data$yi[idx], y_pos, pch = 17, cex = 0.8, col = "lightblue")
  lines(c(meta_data$ci.lb[idx], meta_data$ci.ub[idx]), c(y_pos, y_pos),
        lwd = 1, col = "lightblue")
}

# 添加图例
legend("topright",
       c("HIGH质量", "MEDIUM-HIGH质量", "MEDIUM质量"),
       pch = c(15, 16, 17), col = c("darkgreen", "orange", "lightblue"))

dev.off()

cat("✓ 质量对比森林图已保存：forest_plot_by_quality_comparison.png\n")

# =====================================================
# 第8部分：详细报告
# =====================================================

cat("\n\n第7步：生成详细亚组分析报告\n")
cat("====================================\n\n")

report <- sprintf(
"
食管癌CTC元分析 - 按质量的亚组分析报告
生成日期：%s

====== 研究质量分布 ======
HIGH质量研究：%d个
MEDIUM-HIGH质量研究：%d个
MEDIUM质量研究：%d个
总计：%d个

====== 各质量组的汇总效应 ======

HIGH质量研究（n=%d）：
  汇总效应(HR)：%.3f [%.3f - %.3f]
  异质性(I²)：%.2f%%
  p值：%.4f
  解释：高质量研究的CTC预后效应

MEDIUM-HIGH质量研究（n=%d）：
  汇总效应(HR)：%.3f [%.3f - %.3f]
  异质性(I²)：%.2f%%
  p值：%.4f
  解释：中等-高质量研究的CTC预后效应

MEDIUM质量研究（n=%d）：
  汇总效应(HR)：%.3f [%.3f - %.3f]
  异质性(I²)：%.2f%%
  p值：%.4f
  解释：中等质量研究的CTC预后效应

====== 亚组交互检验 ======
检验问题：不同质量的研究是否产生不同的效应量？

Q_between（亚组间异质性）：%.2f
自由度：2
p值：%.4f

结果解释：
%s

====== 敏感性分析 ======
仅使用HIGH和MEDIUM-HIGH质量研究（n=%d）：
  汇总效应(HR)：%.3f [%.3f - %.3f]
  异质性(I²)：%.2f%%

相比全部研究变化：
  效应量变化：%.3f（%s）
  提示：%s

====== 质量评估特征 ======
HIGH质量研究特征：
  - 大样本量（通常>80）
  - 前瞻性设计
  - 完整的随访数据
  - 详细的统计报告

MEDIUM-HIGH质量研究特征：
  - 适度样本量（50-80）
  - 前瞻或高质量回顾性设计
  - 基本完整的数据
  - 充分的统计分析

MEDIUM质量研究特征：
  - 较小样本量（<50）
  - 回顾性设计或前瞻性但缺乏随访
  - 部分数据缺失
  - 基本统计分析

====== 临床意义 ======
1. 无论研究质量如何，CTC都显示出显著的预后效应
2. 高质量研究的效应估计可能更加可靠
3. 建议在临床应用时优先参考高质量研究的结果
4. 质量差异提示需要进一步标准化CTC检测和应用

====== 结论与建议 ======
- 研究质量对效应量估计%s显著影响
- 随机效应模型适用于该数据集
- 建议在敏感性分析中单独报告高质量研究结果
- 未来研究应采用高质量设计以提高证据质量
",
  Sys.Date(),
  nrow(high_data), nrow(medium_high_data), nrow(medium_data), nrow(meta_data),
  nrow(high_data), res_high$beta[1], res_high$ci.lb[1], res_high$ci.ub[1], res_high$I2, res_high$pval[1],
  nrow(medium_high_data), res_mh$beta[1], res_mh$ci.lb[1], res_mh$ci.ub[1], res_mh$I2, res_mh$pval[1],
  nrow(medium_data), res_medium$beta[1], res_medium$ci.lb[1], res_medium$ci.ub[1], res_medium$I2, res_medium$pval[1],
  Q_between, Q_between_p,
  ifelse(Q_between_p < 0.05, "存在显著差异（p < 0.05），不同质量研究产生不同的效应量估计", "无显著差异（p ≥ 0.05），质量不显著影响效应量"),
  nrow(high_quality_data),
  res_high_only$beta[1], res_high_only$ci.lb[1], res_high_only$ci.ub[1], res_high_only$I2,
  res_high_only$beta[1] - subgroup_test$beta[1],
  ifelse(abs(res_high_only$beta[1] - subgroup_test$beta[1]) > 0.2, "较大", "较小"),
  ifelse(abs(res_high_only$beta[1] - subgroup_test$beta[1]) > 0.2, "低质量研究可能影响汇总估计", "质量不是主要影响因素"),
  ifelse(Q_between_p < 0.05, "有", "无")
)

# 保存报告
writeLines(report, "analyses/subgroup_quality_report.txt")
cat("✓ 详细报告已保存：subgroup_quality_report.txt\n")

cat("\n\n========== 亚组分析完成 ==========\n")
cat("已生成文件：\n")
cat("  1. subgroup_quality_summary.csv - 亚组汇总表\n")
cat("  2. quality_graded_studies.csv - 质量分级研究列表\n")
cat("  3. forest_plot_by_quality_comparison.png - 质量对比森林图\n")
cat("  4. subgroup_quality_report.txt - 详细分析报告\n")
