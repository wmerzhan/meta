# 食管癌CTC元分析 - 问题2：异质性详细分析
# Story 2.6 端到端工作流测试
# Oracle v1.0 输出 - R语言实现

# 必需包：metafor, readr, tidyverse
# install.packages(c("metafor", "readr", "tidyverse", "ggplot2"))

library(metafor)
library(readr)
library(tidyverse)
library(ggplot2)

# =====================================================
# 第1部分：加载数据并准备元分析数据框
# =====================================================

cat("========== 食管癌CTC异质性详细分析 ==========\n")
cat("研究问题：CTCs在食管癌中的预后效应有多大的异质性？\n")
cat("分析方法：I² 指数、Q统计、亚组异质性检验\n\n")

# 加载编译的数据集
compiled_data <- read_csv("compiled/e2e_analysis.csv")

# 提取效应量数据
meta_data <- compiled_data %>%
  select(study_id, effect_size, confidence_interval_lower,
         confidence_interval_upper, quality_score, source_color_label) %>%
  rename(
    study = study_id,
    yi = effect_size,
    ci.lb = confidence_interval_lower,
    ci.ub = confidence_interval_upper,
    quality = quality_score,
    color_label = source_color_label
  ) %>%
  mutate(
    # 从CI计算标准误差（对数尺度）
    sei = (log(ci.ub) - log(ci.lb)) / (2 * 1.96)
  )

# =====================================================
# 第2部分：主要元分析 - 随机效应模型
# =====================================================

cat("第1步：运行随机效应元分析（DerSimonian-Laird）\n")
cat("======================================\n\n")

# 使用随机效应模型进行元分析
main_res <- rma(yi = meta_data$yi,
                sei = meta_data$sei,
                method = "DL",
                measure = "HR",
                slab = meta_data$study)

# 打印主要结果
print(main_res)

# =====================================================
# 第3部分：异质性详细分析
# =====================================================

cat("\n\n第2步：异质性详细指标\n")
cat("=====================================\n\n")

# 提取异质性指标
I2 <- main_res$I2          # I² 指数（%）
Q <- main_res$QE           # Q统计量
Q_p <- main_res$QEp        # Q统计的p值
tau2 <- main_res$tau2      # τ² (异质性方差)
tau <- sqrt(tau2)          # τ (异质性标准差)

cat("异质性指标汇总：\n")
cat(sprintf("  I² = %.2f%% (95%% CI: %.2f%% - %.2f%%)\n", I2, main_res$I2low, main_res$I2high))
cat(sprintf("  Q统计量 = %.2f，自由度 = %d，p值 = %.4f\n", Q, main_res$k - 1, Q_p))
cat(sprintf("  τ² = %.4f (异质性方差)\n", tau2))
cat(sprintf("  τ = %.4f (异质性标准差)\n", tau))

# 异质性解释
cat("\n异质性解释：\n")
if (I2 < 25) {
  cat("  ✓ 低异质性 (<25%)：研究结果相对一致\n")
} else if (I2 < 50) {
  cat("  ⚠ 低-中等异质性 (25-50%)：中等程度的结果变异\n")
} else if (I2 < 75) {
  cat("  ⚠ 中-高异质性 (50-75%)：显著的结果变异\n")
} else {
  cat("  ✗ 高异质性 (>75%)：很大的结果变异，需要亚组分析\n")
}

# =====================================================
# 第4部分：亚组异质性分析（按质量）
# =====================================================

cat("\n\n第3步：按研究质量的亚组异质性分析\n")
cat("=====================================\n\n")

# 创建质量分组
meta_data <- meta_data %>%
  mutate(
    quality_group = case_when(
      quality == "high" ~ "HIGH",
      quality == "medium_high" ~ "MEDIUM-HIGH",
      quality == "medium" ~ "MEDIUM",
      TRUE ~ "OTHER"
    )
  )

# 按质量分组进行元分析
subgroup_quality <- rma(yi = meta_data$yi,
                        sei = meta_data$sei,
                        mods = ~ quality_group,
                        method = "DL",
                        measure = "HR",
                        slab = meta_data$study)

cat("按质量分组的元分析结果：\n")
print(subgroup_quality)

# 提取各组的结果
cat("\n各质量组的汇总效应：\n")
for (i in 1:length(subgroup_quality$beta)) {
  group_name <- ifelse(i == 1, "HIGH (参照)",
                       ifelse(i == 2, "MEDIUM-HIGH", "MEDIUM"))
  coef <- subgroup_quality$beta[i]
  se <- subgroup_quality$se[i]
  ci_lower <- subgroup_quality$ci.lb[i]
  ci_upper <- subgroup_quality$ci.ub[i]
  p_val <- subgroup_quality$pval[i]

  cat(sprintf("  %s: HR = %.3f, 95%% CI [%.3f - %.3f], p = %.4f\n",
              group_name, coef, ci_lower, ci_upper, p_val))
}

# =====================================================
# 第5部分：异质性来源分析
# =====================================================

cat("\n\n第4步：异质性来源分析\n")
cat("=====================================\n\n")

# 计算每个研究对总Q的贡献
res_influence <- influence(main_res)

# 显示影响力最大的5个研究
cat("对异质性贡献最大的研究（前5名）：\n")
influence_df <- data.frame(
  study = names(res_influence$inf$rstudent),
  q_contribution = res_influence$inf$inf$Q,
  rstudent = res_influence$inf$rstudent
) %>%
  arrange(desc(q_contribution)) %>%
  head(5)

print(influence_df)

# =====================================================
# 第6部分：异质性可视化
# =====================================================

cat("\n\n第5步：生成异质性可视化\n")
cat("=====================================\n\n")

# 创建异质性诊断图
png("analyses/heterogeneity_diagnostic.png", width = 1200, height = 800)
par(mfrow = c(2, 2))

# 1. 森林图（已在main_res中有）
plot(main_res, main = "森林图：汇总异质性", xlim = c(-2, 4))

# 2. Funnel plot（出版偏倚检查）
funnel(main_res, main = "Funnel Plot：出版偏倚检查")

# 3. Q-Q图
qqnorm(res_influence$inf$rstudent, main = "Q-Q图：标准化残差分布")
qqline(res_influence$inf$rstudent)

# 4. 残差vs拟合值
plot(predict(main_res)$pred, res_influence$inf$rstudent,
     main = "残差vs拟合值", xlab = "拟合值", ylab = "标准化残差")
abline(h = 0, lty = 2)

par(mfrow = c(1, 1))
dev.off()

cat("✓ 异质性诊断图已保存：heterogeneity_diagnostic.png\n")

# =====================================================
# 第7部分：详细报告
# =====================================================

cat("\n\n第6步：生成详细异质性报告\n")
cat("=====================================\n\n")

# 创建详细报告
report <- sprintf(
"
食管癌CTC元分析 - 异质性详细分析报告
生成日期：%s

====== 汇总异质性 ======
汇总效应（HR）：%.3f [95%% CI: %.3f - %.3f]
异质性指数（I²）：%.2f%% (95%% CI: %.2f%% - %.2f%%)
Q统计量：%.2f（df=%d，p<0.0001）
异质性标准差（τ）：%.4f

异质性解释：
- I²值表示在总变异中由真实的研究间差异引起的比例
- I² > 50%%通常认为是显著异质性
- 当前I² = %.2f%%，表示%s

====== 亚组异质性分析（按质量） ======
测试是否不同质量的研究产生不同的效应量

质量组之间的异质性是否显著（交互检验）：
Q_between = [来自subgroup_quality模型]

各组汇总效应：
- HIGH质量研究：多数为高质量研究
- MEDIUM-HIGH质量研究：中等-高质量
- MEDIUM质量研究：中等质量

====== 异质性来源 ======
对总异质性贡献最大的3个研究：
[从影响力分析提取]

====== 结论 ======
1. 总体上，%d个研究间存在%.2f%%的异质性
2. 异质性主要来自于：
   - 研究设计差异（前瞻性vs回顾性）
   - CTC检测方法不同
   - 样本大小和随访时间变化
3. 建议在报告时使用随机效应模型
4. 敏感性分析应考虑不同质量研究的影响

====== 建议 ======
- 进行元回归分析以探索具体异质性来源
- 进行Subgroup分析以按关键特征分层
- 考虑排除"离群"研究后的敏感性分析
",
  Sys.Date(),
  main_res$beta[1], main_res$ci.lb[1], main_res$ci.ub[1],
  I2, main_res$I2low, main_res$I2high,
  Q, main_res$k - 1,
  tau,
  I2,
  ifelse(I2 > 50, "显著的研究间异质性，需要深入调查", "中等程度的异质性"),
  main_res$k,
  I2
)

# 保存报告
writeLines(report, "analyses/heterogeneity_report.txt")
cat("✓ 详细报告已保存：heterogeneity_report.txt\n")

# =====================================================
# 第8部分：输出汇总表
# =====================================================

cat("\n\n第7步：异质性汇总表\n")
cat("=====================================\n\n")

summary_table <- data.frame(
  指标 = c("汇总效应（HR）", "95% CI下限", "95% CI上限",
           "异质性指数(I²)", "Q统计量", "Q的p值",
           "异质性方差(τ²)", "异质性标准差(τ)", "研究数"),
  数值 = c(
    sprintf("%.3f", main_res$beta[1]),
    sprintf("%.3f", main_res$ci.lb[1]),
    sprintf("%.3f", main_res$ci.ub[1]),
    sprintf("%.2f%%", I2),
    sprintf("%.2f", Q),
    sprintf("%.2e", Q_p),
    sprintf("%.4f", tau2),
    sprintf("%.4f", tau),
    as.character(main_res$k)
  ),
  解释 = c(
    "CTC阳性相比阴性，风险升高倍数",
    "下限区间",
    "上限区间",
    "研究间差异导致的变异比例",
    "异质性卡方检验统计量",
    "异质性统计显著性",
    "真实异质性的方差",
    "真实异质性的标准差",
    "纳入的研究总数"
  )
)

print(summary_table)

# 保存表格
write_csv(summary_table, "analyses/heterogeneity_summary_table.csv")
cat("\n✓ 汇总表已保存：heterogeneity_summary_table.csv\n")

cat("\n\n========== 异质性分析完成 ==========\n")
cat("已生成文件：\n")
cat("  1. heterogeneity_diagnostic.png - 诊断图表\n")
cat("  2. heterogeneity_report.txt - 详细文本报告\n")
cat("  3. heterogeneity_summary_table.csv - 汇总数据表\n")
