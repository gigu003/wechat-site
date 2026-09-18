# canregtools 文章调研记录

调研日期：2026-08-25

## 1. 已发布版本与安装源

- 来源：R-universe API 实时元数据。
- 网址：https://gigu003.r-universe.dev/api/packages/canregtools
- 证据类型：官方包仓库元数据。
- 已核对事实：当前发布版本为 0.2.11；发布时间为 2026-07-31；源码提交为 `0838ce74e157eb6a818ed0ebd59092fe4cc754e0`；R 依赖为 4.1.0 或更高；Linux、macOS、Windows 等构建检查为 OK。
- 可支持：版本、安装来源、公开提交和构建状态。
- 不能支持：任何本地未提交功能已经进入公开包。

## 2. 包定位与公开用法

- 来源：canregtools pkgdown 首页。
- 网址：https://gigu003.github.io/canregtools/
- 证据类型：官方软件文档。
- 已核对事实：包面向人群肿瘤登记数据；推荐从 R-universe 安装；公开示例使用 `count_canreg()`、`create_asr()`、`create_quality()` 和 `create_age_rate()`。
- 可支持：文章的安装代码、主对象流和最小示例。
- 不能支持：包能替代登记数据审核、统计方案或专业解释。

## 3. 源码与函数文档

- 来源：用户提供的本地源码；公开提交快照 `0838ce7`。
- 网址：https://github.com/gigu003/canregtools
- 证据类型：源代码、roxygen/Rd 文档、测试。
- 已核对事实：
  - `canreg` 对象包含 `areacode`、`FBcases`、`SWcases`、`POP`。
  - `read_canreg()` 读取带 FB、SW、POP 工作表的 Excel 文件；需要可选包 `readxl`。
  - `as_canreg()` 可从已经进入 R 的发病、死亡和人口数据框构造对象。
  - `count_canreg()` 支持 `big`、`small`、`system`、`gco` 四类癌种分组，并返回 `fbswicd` 或 `fbswicds`。
  - `create_asr()` 支持发病或死亡、多个标准人口、方差和置信区间。
  - `create_quality()` 输出病例数、发病率、死亡数、死亡率、M:I、MV% 等质量指标。
  - `create_age_rate()` 输出年龄别病例数和率。
  - `create_report()` 提供 annual、quality、quality-list-city 模板，但模板还需要 `showtext`、`flextable`、`glue` 等渲染依赖。
- 可支持：输入字段、函数参数、输出解释和报告依赖提示。
- 不能支持：未经检查的数据一定能直接计算，或输出指标自动等于最终可发布结果。

## 4. 可复现运行验证

- 来源：从公开提交 `0838ce7` 导出的隔离快照，本机 R 会话运行。
- 证据类型：可复现运行结果。
- 验证结果：
  - `packageVersion("canregtools")` 为 0.2.11。
  - 示例数据 `canregs` 是含 3 个登记处的 `canregs` 对象；首个登记处代码为 410103。
  - 首个登记处 2021 年示例中，口腔和咽（除外鼻咽）病例数 38，粗率 5.53/10万，中标率 3.74/10万，1985 年世界人口标化率 3.79/10万。
  - 同一层级质量输出中，发病数 38、死亡数 20、M:I 0.53、MV% 73.7。
  - `create_age_rate()` 返回 19 个年龄组的病例数和率。
  - 公开提交的完整 testthat 测试通过。
- 边界：这些数字来自包内示例数据，只用于说明输出结构，不代表任何真实地区的最新疾病负担。

## 5. 本地开发树与公开版边界

- 来源：本地 `git status`、`git diff` 与 R-universe `_exports`。
- 证据类型：版本差异审计。
- 已核对事实：本地树存在未提交的 `validate_canreg()`、`cr_combine()` 等开发内容；R-universe 0.2.11 的公开导出列表不含这些函数。
- 写作决定：正文不把这些函数列入已发布教程；待正式发布后再单独介绍。

## 6. 报告渲染验证

- 来源：公开提交快照上的 `create_report()` 实测与模板源码。
- 证据类型：可复现运行结果和源码。
- 结果：核心分析示例运行通过；`create_report(..., template = "annual")` 在未安装 `showtext` 的干净环境中停止，并提示缺少该包。
- 写作决定：把报告渲染放在“可选步骤”，明确需要安装模板依赖，先验证分析表再渲染报告。
