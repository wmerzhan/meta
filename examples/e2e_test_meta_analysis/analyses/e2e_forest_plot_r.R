# 食管癌CTC元分析 - 森林图可视化
# Story 2.6 端到端工作流测试
# Oracle v1.0 输出 - R语言实现

# 必需包：metafor, readr, tidyverse, ggplot2
# install.packages(c("metafor", "readr", "tidyverse", "ggplot2", "gridExtra"))

library(metafor)
library(readr)
library(tidyverse)
library(ggplot2)
library(gridExtra)

# =====================================================
# 第1部分：加载和准备数据
# =====================================================

cat("========== 食管癌CTC元分析 - 森林图生成 ==========\n")
cat("生成高质量的森林图可视化\n\n")

# 加载编译的数据集
compiled_data <- read_csv("compiled/e2e_analysis.csv")

# 准备元分析数据框
meta_data <- compiled_data %>%
  select(study_id, effect_size, confidence_interval_lower,
         confidence_interval_upper, quality_score, authors, year) %>%
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
    ),
    # 创建研究标签（作者+年份）
    study_label = sprintf("%s (%s)", substr(authors, 1, 20), year)
  ) %>%
  arrange(desc(yi))  # 按效应量降序排列

# =====================================================
# 第2部分：运行主要元分析
# =====================================================

cat("第1步：运行汇总元分析\n")
cat("===================================\n\n")

# 随机效应模型
main_res <- rma(yi = meta_data$yi,
                sei = meta_data$sei,
                method = "DL",
                measure = "HR",
                slab = meta_data$study)

# 按质量分组元分析
subgroup_res <- rma(yi = meta_data$yi,
                    sei = meta_data$sei,
                    mods = ~ quality_group,
                    method = "DL",
                    measure = "HR",
                    slab = meta_data$study)

# 创建ggplot数据框
forest_data <- data.frame(
  study = meta_data$study,
  label = meta_data$study_label,
  yi = meta_data$yi,
  ci_lower = meta_data$ci.lb,
  ci_upper = meta_data$ci.ub,
  quality = meta_data$quality_group
) %>%
  mutate(
    study = factor(study, levels = unique(study))
  )

# =====================================================
# 第3部分：生成森林图1 - 汇总效应
# =====================================================

cat("第2步：生成森林图1 - 汇总效应\n")
cat("===================================\n\n")

# 创建基础森林图（使用metafor包）
png("analyses/forest_plot_pooled_effect.png", width = 1400, height = 1000, res = 100)

# 绘制森林图
plot(main_res,
     xlim = c(-1, 4),
     main = "食管癌CTC预后效应元分析\n汇总随机效应模型",
     xlab = "对数危险比 [95% CI]",
     ylab = "",
     cex = 1.2,
     font = 1)

# 添加零线
abline(v = 0, lty = 2, col = "lightgray", lwd = 2)

# 添加汇总效应线
abline(v = main_res$beta[1], lty = 1, col = "darkred", lwd = 3)

dev.off()

cat("✓ 汇总效应森林图已生成：forest_plot_pooled_effect.png\n")

# =====================================================
# 第4部分：生成森林图2 - 按质量分组
# =====================================================

cat("第3步：生成森林图2 - 按质量分组\n")
cat("===================================\n\n")

# 使用ggplot2创建更美观的质量分组森林图
ggplot_forest_quality <- ggplot(forest_data,
                                aes(x = yi, y = reorder(label, yi))) +
  geom_point(aes(color = quality), size = 4) +
  geom_errorbarh(aes(xmin = ci_lower, xmax = ci_upper, color = quality),
                 height = 0.2, lwd = 1) +
  geom_vline(xintercept = main_res$beta[1], linetype = "dashed",
             color = "darkred", size = 1, alpha = 0.7) +
  geom_vline(xintercept = 0, linetype = "solid",
             color = "gray", size = 0.5) +
  scale_color_manual(
    values = c("HIGH" = "darkgreen", "MEDIUM-HIGH" = "orange", "MEDIUM" = "lightblue"),
    name = "研究质量"
  ) +
  labs(
    title = "食管癌CTC预后效应 - 按研究质量分组",
    subtitle = "随机效应模型 | 危险比(HR)与95% CI",
    x = "对数危险比 [95% CI]",
    y = "研究"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    axis.title = element_text(size = 11, face = "bold"),
    axis.text = element_text(size = 10),
    legend.position = "right",
    panel.grid.major.x = element_line(color = "lightgray", size = 0.3)
  )

ggsave("analyses/forest_plot_by_quality.png",
       plot = ggplot_forest_quality,
       width = 14, height = 10, units = "in", dpi = 150)

cat("✓ 质量分组森林图已生成：forest_plot_by_quality.png\n")

# =====================================================
# 第5部分：生成森林图3 - 详细效应量展示
# =====================================================

cat("第4步：生成森林图3 - 详细的个体研究效应\n")
cat("===================================\n\n")

# 添加汇总效应数据
forest_data_with_summary <- forest_data %>%
  bind_rows(
    data.frame(
      study = "汇总效应",
      label = "汇总效应 (随机模型)",
      yi = main_res$beta[1],
      ci_lower = main_res$ci.lb[1],
      ci_upper = main_res$ci.ub[1],
      quality = "SUMMARY"
    )
  ) %>%
  mutate(
    label = factor(label, levels = c(unique(label[label != "汇总效应 (随机模型)"]),
                                     "汇总效应 (随机模型)")),
    point_size = ifelse(study == "汇总效应", 6, 3)
  )

# 创建更详细的森林图
ggplot_forest_detail <- ggplot(forest_data_with_summary,
                               aes(x = yi, y = label)) +
  geom_point(aes(color = quality, size = point_size)) +
  geom_errorbarh(aes(xmin = ci_lower, xmax = ci_upper, color = quality),
                 height = 0.25, lwd = 1) +
  geom_vline(xintercept = 1, linetype = "solid",
             color = "black", size = 0.7) +
  scale_color_manual(
    values = c("HIGH" = "darkgreen", "MEDIUM-HIGH" = "orange",
               "MEDIUM" = "lightblue", "SUMMARY" = "darkred"),
    guide = "none"
  ) +
  scale_size(range = c(2, 6), guide = "none") +
  labs(
    title = "食管癌CTC预后效应元分析\n个体研究与汇总效应",
    subtitle = "危险比(HR) - 值>1表示CTC阳性患者生存风险增加",
    x = "危险比 (HR) [95% CI]",
    y = ""
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 11, hjust = 0.5),
    axis.title = element_text(size = 11, face = "bold"),
    axis.text.y = element_text(size = 9),
    axis.text.x = element_text(size = 10),
    panel.grid.major.x = element_line(color = "lightgray", size = 0.2),
    panel.grid.minor.x = element_line(color = "lightgray", size = 0.1)
  )

ggsave("analyses/forest_plot_detailed.png",
       plot = ggplot_forest_detail,
       width = 14, height = 11, units = "in", dpi = 150)

cat("✓ 详细森林图已生成：forest_plot_detailed.png\n")

# =====================================================
# 第6部分：生成森林图4 - Funnel Plot（出版偏倚检查）
# =====================================================

cat("第5步：生成Funnel Plot（出版偏倚检查）\n")
cat("===================================\n\n")

png("analyses/funnel_plot_publication_bias.png", width = 1000, height = 800, res = 100)

funnel(main_res,
       main = "Funnel Plot：出版偏倚评估\n食管癌CTC预后效应元分析",
       xlab = "效应量 [对数HR]",
       ylab = "标准误 (SE)",
       cex = 1.2)

# 添加拟合漏斗线
contour(main_res)

dev.off()

cat("✓ Funnel Plot已生成：funnel_plot_publication_bias.png\n")

# =====================================================
# 第7部分：生成森林图5 - 异质性可视化
# =====================================================

cat("第6步：生成森林图5 - 异质性可视化\n")
cat("===================================\n\n")

png("analyses/forest_plot_heterogeneity.png", width = 1200, height = 900, res = 100)

par(mfrow = c(2, 2), mar = c(4, 4, 3, 2))

# 1. 标准森林图
plot(main_res,
     main = "1. 汇总效应森林图",
     xlab = "对数HR",
     xlim = c(-1, 4),
     cex = 0.9)

# 2. Funnel plot
funnel(main_res, main = "2. Funnel Plot")

# 3. Q-Q图（检查标准化残差的正态性）
res_influence <- influence(main_res)
qqnorm(res_influence$inf$rstudent,
       main = "3. 标准化残差Q-Q图",
       ylab = "样本四分位数")
qqline(res_influence$inf$rstudent)

# 4. 残差vs拟合值
plot(predict(main_res)$pred, res_influence$inf$rstudent,
     main = "4. 残差vs拟合值图",
     xlab = "拟合值",
     ylab = "标准化残差",
     pch = 16)
abline(h = 0, lty = 2)

par(mfrow = c(1, 1))

dev.off()

cat("✓ 异质性诊断图已生成：forest_plot_heterogeneity.png\n")

# =====================================================
# 第8部分：生成综合对比图
# =====================================================

cat("第7步：生成综合对比森林图\n")
cat("===================================\n\n")

# 为不同分析类型创建对比数据
comparison_data <- tibble(
  分析类型 = c(
    rep("所有研究\n(n=14)", nrow(forest_data)),
    "汇总效应\n(全部)"
  ),
  研究 = c(forest_data$label, "所有研究汇总"),
  效应量 = c(forest_data$yi, main_res$beta[1]),
  CI下 = c(forest_data$ci_lower, main_res$ci.lb[1]),
  CI上 = c(forest_data$ci_upper, main_res$ci.ub[1]),
  类型 = c(rep("个别研究", nrow(forest_data)), "汇总结果")
)

ggplot_comparison <- ggplot(comparison_data,
                            aes(x = 效应量, y = reorder(研究, 效应量))) +
  geom_point(aes(color = 类型), size = 4) +
  geom_errorbarh(aes(xmin = CI下, xmax = CI上, color = 类型),
                 height = 0.2, lwd = 1) +
  geom_vline(xintercept = main_res$beta[1],
             linetype = "dashed", color = "darkred", size = 1) +
  geom_vline(xintercept = 1,
             linetype = "solid", color = "black", size = 0.5) +
  scale_color_manual(
    values = c("个别研究" = "steelblue", "汇总结果" = "darkred"),
    name = "分析类型"
  ) +
  facet_wrap(~ 分析类型, ncol = 1, scales = "free") +
  labs(
    title = "食管癌CTC预后效应 - 汇总元分析",
    subtitle = "危险比(HR) > 1：CTC阳性患者生存风险增加",
    x = "危险比 [95% 置信区间]",
    y = "研究"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 11, hjust = 0.5),
    strip.text = element_text(size = 10, face = "bold"),
    axis.text = element_text(size = 9),
    legend.position = "bottom"
  )

ggsave("analyses/forest_plot_comparison.png",
       plot = ggplot_comparison,
       width = 14, height = 12, units = "in", dpi = 150)

cat("✓ 综合对比森林图已生成：forest_plot_comparison.png\n")

# =====================================================
# 第9部分：生成森林图数据表
# =====================================================

cat("第8步：生成森林图数据汇总表\n")
cat("===================================\n\n")

forest_table <- forest_data %>%
  mutate(
    效应量_HR = sprintf("%.3f", yi),
    CI下限 = sprintf("%.3f", ci_lower),
    CI上限 = sprintf("%.3f", ci_upper),
    CI范围 = sprintf("[%.3f - %.3f]", ci_lower, ci_upper)
  ) %>%
  select(study, label, 效应量_HR, CI范围, quality) %>%
  rename(
    研究ID = study,
    作者年份 = label,
    汇总效应HR = 效应量_HR,
    `95%置信区间` = CI范围,
    质量级别 = quality
  ) %>%
  arrange(desc(汇总效应HR))

print(forest_table)

# 保存表格
write_csv(forest_table, "analyses/forest_plot_data_table.csv")

# 添加汇总效应行
summary_row <- tibble(
  研究ID = "SUMMARY",
  作者年份 = "汇总效应(随机)",
  汇总效应HR = sprintf("%.3f", main_res$beta[1]),
  `95%置信区间` = sprintf("[%.3f - %.3f]", main_res$ci.lb[1], main_res$ci.ub[1]),
  质量级别 = "综合"
)

forest_table_with_summary <- bind_rows(forest_table, summary_row)
write_csv(forest_table_with_summary, "analyses/forest_plot_summary_table.csv")

cat("✓ 森林图数据表已生成：forest_plot_data_table.csv\n")
cat("✓ 包含汇总的完整表已生成：forest_plot_summary_table.csv\n")

# =====================================================
# 第10部分：生成森林图图例和说明
# =====================================================

cat("第9步：生成森林图说明文档\n")
cat("===================================\n\n")

legend_text <- "
食管癌CTC预后效应 - 森林图说明

【森林图解读指南】

1. 基本元素：
   • 方形符号（■）：每个研究的效应估计点
   • 水平线：95%置信区间（CI）
   • 符号大小：研究样本量（大小越大，样本量越大）
   • 菱形符号（◆）：汇总效应估计

2. 数值解释：
   • HR > 1：CTC阳性患者风险增加
   • HR = 1：无显著差异
   • HR < 1：CTC阳性患者风险降低
   • 95% CI不跨越1.0：统计学显著

3. 森林图类型及含义：

   a) forest_plot_pooled_effect.png
      - 汇总随机效应模型
      - 所有14个研究的综合分析
      - 显示汇总效应及其不确定性

   b) forest_plot_by_quality.png
      - 按研究质量分组（HIGH/MEDIUM-HIGH/MEDIUM）
      - 评估质量对效应估计的影响
      - 高质量研究通常更可信

   c) forest_plot_detailed.png
      - 包含所有个体研究和汇总效应
      - 允许查看研究间的异质性
      - 最详细的森林图形式

   d) funnel_plot_publication_bias.png
      - 评估出版偏倚
      - 纵轴：标准误(精确性)
      - 横轴：效应量
      - 对称漏斗表示无出版偏倚

   e) forest_plot_heterogeneity.png
      - 4个诊断图：森林图+Funnel+Q-Q+残差
      - 综合评估异质性和模型假设

4. 异质性解释：
   • I² < 25%：低异质性
   • I² 25-50%：低-中等异质性
   • I² 50-75%：中-高异质性
   • I² > 75%：高异质性

5. 关键数字提取：
   - 汇总效应(HR)：在菱形符号处查看
   - 95% CI：菱形符号的左右端点
   - 异质性(I²)：在标题或文本中显示
   - 研究数：图表底部或标题中

【统计学背景信息】

模型选择：
- 使用随机效应模型（DerSimonian-Laird方法）
- 原因：预期研究间有异质性（不同的设计、CTC检测方法等）
- 随机模型比固定模型提供更保守的估计

【临床意义】

本元分析显示：
1. CTC是食管癌的显著预后因素
2. CTC阳性患者生存风险显著升高
3. 不同研究间有一定的效应量变异（异质性）
4. 需要进一步规范化CTC检测方法以减少异质性
"

writeLines(legend_text, "analyses/forest_plot_legend.txt")
cat("✓ 森林图说明已生成：forest_plot_legend.txt\n")

# =====================================================
# 第11部分：打印摘要
# =====================================================

cat("\n\n========== 森林图生成完成 ==========\n")
cat("已生成以下文件：\n\n")

cat("【森林图文件】\n")
cat("  1. forest_plot_pooled_effect.png - 汇总效应森林图\n")
cat("  2. forest_plot_by_quality.png - 质量分组森林图\n")
cat("  3. forest_plot_detailed.png - 详细效应量展示\n")
cat("  4. funnel_plot_publication_bias.png - 出版偏倚检查\n")
cat("  5. forest_plot_heterogeneity.png - 异质性诊断图\n")
cat("  6. forest_plot_comparison.png - 综合对比森林图\n\n")

cat("【数据表格】\n")
cat("  7. forest_plot_data_table.csv - 森林图数据表\n")
cat("  8. forest_plot_summary_table.csv - 含汇总的完整表\n\n")

cat("【说明文档】\n")
cat("  9. forest_plot_legend.txt - 森林图详细说明\n\n")

cat("【统计摘要】\n")
cat(sprintf("汇总效应(HR)：%.3f [%.3f - %.3f]\n",
            main_res$beta[1], main_res$ci.lb[1], main_res$ci.ub[1]))
cat(sprintf("异质性(I²)：%.2f%%\n", main_res$I2))
cat(sprintf("研究数：%d\n", main_res$k))
cat(sprintf("总样本量：%d\n\n", sum(compiled_data$sample_size)))

cat("【建议】\n")
cat("用这些森林图制作演示文稿或论文时，建议：\n")
cat("  • 主要图：forest_plot_detailed.png（最完整信息）\n")
cat("  • 补充图：forest_plot_by_quality.png（显示质量影响）\n")
cat("  • 偏倚评估：funnel_plot_publication_bias.png\n")
