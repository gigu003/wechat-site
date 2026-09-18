# 调研笔记：设置种子，保证数据分析的可重复性

检索与本机验证日期：2026-08-26

## 问题与边界

本文面向肿瘤登记从业者和医学科研人员，解释随机种子如何控制抽样、数据划分、重抽样、初始值等随机过程。正文以 R 为主，不把“相同种子”夸大为“任何环境下必然得到完全相同结果”。

## R 官方文档：`set.seed()` 与 RNG 状态

- 来源：R Core Team, *Random Number Generation*  
  https://stat.ethz.ch/R-manual/R-devel/library/base/help/Random.html
- 证据类型：R 官方手册。
- 可支持：`.Random.seed` 保存当前 RNG 状态；`set.seed()` 是指定种子的推荐方式；`RNGkind()` 查询或设置随机数生成器类型；`RNGversion()` 可切换到旧 R 版本的默认 RNG 配置，用于复现旧结果。
- 重要版本边界：R 3.6.0 更改了 `sample()` 使用的默认 `sample.kind`；需要复现更早输出时，不能只记一个种子值。
- 不能推出：相同整数种子能抵消包版本、底层数值库、线程调度或数据差异。

## 作用域化的种子

- 来源：withr 官方文档, *Random seed*  
  https://withr.r-lib.org/reference/with_seed.html
- 证据类型：R 包官方文档与源码入口。
- 可支持：`with_seed(seed, code)` 在指定种子下运行一段代码，结束后恢复之前的随机状态。适合把局部随机过程封装在函数或测试中。
- 本机版本：withr 3.0.3。

## 并行计算中的随机流

- 来源：R Core Team, `parallel` 包文档  
  https://stat.ethz.ch/R-manual/R-devel/library/parallel/html/00Index.html  
  https://stat.ethz.ch/R-manual/R-devel/library/parallel/html/clusterApply.html
- 证据类型：R 官方包文档。
- 可支持：`parallel` 支持基于 `L'Ecuyer-CMRG` 的多个 RNG 流；PSOCK 集群可用 `clusterSetRNGStream(cl, iseed)` 为 worker 分配可复现的随机流。
- 边界：动态负载均衡时，任务与 worker 的对应可能不确定；把随机流绑定到 worker 的模拟不一定能复现。

## Python / NumPy 与跨工具边界

- Python `random` 官方文档：https://docs.python.org/3/library/random.html
- NumPy `Generator` 官方文档：https://numpy.org/doc/stable/reference/random/generator.html
- scikit-learn `random_state` 官方术语表：https://scikit-learn.org/stable/glossary.html#term-random_state
- 可支持：Python 标准库可用相同种子复现伪随机序列；NumPy 新代码推荐专用 `Generator`，如 `np.random.default_rng(20260826)`；scikit-learn 中许多随机步骤通过 `random_state` 控制。
- 边界：NumPy 文档明确说明 `Generator` 不承诺版本间比特流一直不变。不同语言或不同 RNG 算法下，种子数值相同也不意味着随机序列相同。

## 本机可复现运行

- 环境：R 4.5.2 (2025-10-31), base R；withr 3.0.3。
- 种子：`20260826`。
- 命令在干净 `--vanilla` 会话中执行。

```r
set.seed(20260826)
sample(1:100, 5)
# [1] 27 67  9  8 66

set.seed(20260826)
sample(1:100, 5)
# [1] 27 67  9  8 66
```

调用顺序实验：

```r
set.seed(20260826)
sample(1:100, 5)
round(rnorm(3), 4)
# [1]  1.3279 -1.2577  0.7592

set.seed(20260826)
sample(1:100, 5)
runif(1)                 # 额外消耗一次随机状态
round(rnorm(3), 4)
# [1] 1.1737 0.3936 0.6716
```

可支持：相同初始状态与相同调用顺序得到相同输出；中途多一次随机调用，后续序列随之改变。

## 正文核心判断

1. 种子是伪随机序列的起点，不是“取消随机”。
2. 种子应在随机流开始前设置，并与代码一起记录；多阶段分析可预先定义阶段级种子，用 `withr::with_seed()` 降低阶段之间的 RNG 状态耦合。
3. 要复现结果，还需要保存数据、代码、随机调用顺序、R/RNG 类型、包版本和并行配置。`RNGkind()`、`R.version.string` 和 `installed.packages()` 可组成最小运行记录；正文示例用 `saveRDS()` 保存记录。
4. 并行分析需要独立的可复现随机流；正文示例改为在函数内用 `on.exit()` 清理 PSOCK 集群，避免中途报错时遗留 worker。
5. 对于稳健性评估，不应只报告一个“运气好”的种子；应事先设定多个种子或重复次数，汇报结果的分布。

## 本轮正文代码复核

- R 4.5.2、干净 `--vanilla` 会话中，`set.seed(20260826); sample(1:100, 5)` 得到 `[1] 27 67 9 8 66`。
- 在同一次抽样后直接调用 `round(rnorm(3), 4)` 得到 `[1] 1.3279 -1.2577 0.7592`；插入 `runif(1)` 后得到 `[1] 1.1737 0.3936 0.6716`，说明调用顺序是复现条件之一。
- `RNGkind("L'Ecuyer-CMRG", "Inversion", "Rejection")` 在本机 R 4.5.2 可用；并行代码使用 `clusterSetRNGStream()`，并通过 `on.exit()` 确保集群清理。
