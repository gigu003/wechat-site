# 研究笔记：大数定律

## 1. MIT OpenCourseWare：Introduction to Probability and Statistics

- 来源：https://ocw.mit.edu/courses/18-05-introduction-to-probability-and-statistics-spring-2022/mit18_05_s22_probability.pdf
- 检索日期：2026-08-27
- 类型：大学公开课程教材
- 支持：对独立同分布、有限均值随机变量，样本均值随样本量增大以高概率靠近期望；区分随机误差与系统误差；公平硬币示例。
- 不能推出：大样本可以消除抽样偏倚、测量偏差或其他系统误差。

## 2. Encyclopedia of Mathematics：Law of large numbers

- 来源：https://encyclopediaofmath.org/wiki/Law_of_large_numbers
- 检索日期：2026-08-27
- 类型：数学百科条目
- 支持：伯努利频率收敛、经典独立同分布情形以及弱/强大数定律的不同收敛表述。
- 不能推出：所有随机过程、所有统计量、所有依赖结构都自动满足同一个大数定律。

## 3. Wikipedia：Law of large numbers

- 来源：https://en.wikipedia.org/wiki/Law_of_large_numbers
- 检索日期：2026-08-27
- 类型：百科综述及示意图来源
- 支持：掷骰子平均值、赌徒谬误、Cauchy 分布反例、选择偏倚边界，以及由微观随机运动到宏观稳定图景的扩散示意。
- 不能推出：随机波动在有限样本中“消失”，或仅凭大数定律即可推导完整的扩散动力学。

## 4. Statistics Globe：Law of Large Numbers

- 来源：https://statisticsglobe.com/law-of-large-numbers
- 检索日期：2026-08-27
- 类型：统计科普教程；用户提供材料的原始扩展阅读
- 支持：大数定律的直观解释、扩散例子，以及用 R/Python 演示的思路。
- 不能推出：“数据越大，结论必然越准确”；原文中“randomness is essentially gone”仅能理解为宏观相对波动变得很小，不能按字面表述为随机性消失。

## 5. R Core Team：`sample()`、累计和与随机数生成

- 来源：https://search.r-project.org/R/refmans/base/html/sample.html
- 来源：https://search.r-project.org/R/refmans/base/html/cumsum.html
- 来源：https://search.r-project.org/R/refmans/base/html/Random.html
- 检索日期：2026-08-27
- 类型：R 官方文档
- 支持：文章所用 `rbinom()`、`cumsum()`、`set.seed()` 的行为及可复现模拟方法。
- 不能推出：一次固定种子的模拟结果就是定理的证明。

## 本机实测

- 环境：R version 4.5.2 (2025-10-31)
- 日期：2026-08-27
- 种子：20260827
- 公平硬币单一路径：n=10、100、1000、10000 时，正面数分别为 4、38、465、4987；比例为 0.4000、0.3800、0.4650、0.4987。
- 10000 次重复实验：样本均值标准差在 n=10、100、1000 时分别为 0.1580、0.0502、0.0160；落在 [0.4, 0.6] 内的比例分别为 0.6519、0.9654、1.0000（最后一项按四位小数显示）。
- Cauchy 单一路径：运行均值在 n=10、100、1000、10000 时分别为 0.9095、0.7867、0.0216、-1.5702。该轨迹只作演示；关键理论原因是标准 Cauchy 分布的期望不存在。

