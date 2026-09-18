# 调研笔记：R Best Practice Cheat Sheet

检索日期：2026-08-24

## 1. 原始资料

### Jacob Scott / wurli：R Best Practice

- 仓库：https://github.com/wurli/r-best-practice
- PDF：https://rstudio.github.io/cheatsheets/R-best-practice.pdf
- 作者：Jacob Scott（GitHub: `wurli`）。
- PDF 页脚更新时间：2023-11。
- 仓库 README 对资料的定位：面向 R 新开发者的快速入门，内容具有明显主观性，不是唯一正确做法。
- 证据类型：原始仓库与原始速查表。

### 原表的主要内容

1. 软件：RStudio、Quarto、Git、GitHub。
2. 项目：RStudio Project、项目目录、`.gitignore`、`.Rprofile`、`R/`、`SQL/`、`run-all.R`、`renv.lock`、`README.md`。
3. 包：在固定位置加载依赖，长期项目用 renv 记录包版本。
4. 求助：用 `reprex::reprex()` 生成最小可复现示例，用 `dput()` 或 `tibble::tribble()` 提供小数据。
5. 函数：将重复、复杂逻辑抽成小函数，函数名优先使用动词。
6. 风格：`lower_snake_case`、运算符空格、2 空格缩进、长调用换行。
7. 数据库：用 DBI 和 odbc，以辅助函数集中创建连接。
8. 延伸阅读：R for Data Science 2e、R Packages 2e、Advanced R 2e、Mastering Shiny。

## 2. 交叉核对的官方资料

### renv

- 来源：https://rstudio.github.io/renv/articles/renv
- `renv::snapshot()` 将当前项目库的包元数据写入 `renv.lock`；`renv::restore()` 根据锁文件恢复相同包版本。
- 可支持的结论：renv 能管理 R 包依赖的可重建性。
- 不能推出：单有 `renv.lock` 不能冻结 R 本身、操作系统、系统库、外部数据库和原始数据。

### reprex

- 来源：https://reprex.tidyverse.org/ 与 https://reprex.tidyverse.org/articles/reprex-dos-and-donts.html
- reprex 在独立 R 会话中运行小段代码，生成可粘贴到 GitHub、Stack Overflow 等场所的代码和输出。
- 好的示例应只保留必需命令，优先使用内置、模拟或小型数据，随机过程设置种子，必要时附会话信息。
- 医学科研边界：不得把真实患者记录直接放入 reprex；应改用模拟或彻底去标识的最小数据。

### Tidyverse style guide

- 来源：https://style.tidyverse.org/ 与 https://style.tidyverse.org/syntax.html
- 风格指南本身是主观的，主要价值是一致性。
- 变量和函数名建议使用小写字母、数字和下划线；函数名建议用动词。
- 建议用 styler 自动格式化、用 lintr 检查风格。
- 建议代码行尽量不超过 80 个字符；这是可读性约定，不是运行正确性要求。

### R Packages 2e：包代码不同于分析脚本

- 来源：https://r-pkgs.org/dependencies-in-practice.html
- 对 R 包 `R/` 下的源码，推荐默认用 `package::function()` 引用外部函数，并在 `DESCRIPTION` 中声明依赖；不应把分析脚本中“开头统一 `library()`”的建议直接搬到包源码。
- 可支持的结论：依赖管理必须区分分析项目、包源码、测试、示例和 vignette。

### DBI

- 来源：https://dbi.r-dbi.org/reference/dbConnect.html
- DBI 提供 `dbConnect()`、`dbCanConnect()` 和 `dbDisconnect()` 等通用接口，具体认证机制由驱动实现决定。
- 补充判断：应用环境变量、系统凭据库或组织批准的密钥管理方式，不把口令写进 R 脚本、`.Rprofile` 或 Git 仓库。

### GitHub 仓库管理

- 来源：https://docs.github.com/en/repositories/creating-and-managing-repositories/best-practices-for-repositories
- GitHub 建议每个仓库配置 README，并启用密钥扫描、push protection 等安全能力。
- 医学科研边界：Git 适合管理代码、小型配置和无敏感信息的文档，不意味着可以将患者级数据、密钥或未授权结果推送到 GitHub。

## 3. 需要修正或限定的原表建议

1. **GitHub stars 不是质量证据**：原表用“超过 200 颗星大概不错”作为经验法。文章中应明确这不能代替查看维护活跃度、许可证、依赖、测试、问题响应、CRAN/Bioconductor 状态和组织审核。
2. **IDE 不是方法本身**：原表推荐 RStudio，但项目边界、相对路径、依赖锁定和 Git 不应依赖单一 IDE。
3. **`library()` 的建议需要分场景**：分析脚本可在开头集中加载；R 包源码应用 `DESCRIPTION` / `NAMESPACE` 和 `pkg::fun()` 管理依赖。
4. **云同步目录是风险提示，不是绝对禁令**：原表警告 OneDrive/iCloud 与 Git 可能冲突。实践中应根据组织同步政策、文件锁和恢复机制决定，避免同时编辑和重复版本管理。
5. **原表不是完整软件工程清单**：对长期、多人或高风险项目，还应增加自动测试、持续集成、数据字典、备份、访问控制和复现性验证。

## 4. 本地可复现验证

- 环境：R 4.5.2（2025-10-31）。
- 验证范围：使用 base R 的最小函数与顶层执行脚本，计算每 10 万人率。
- 输入：`cases = c(10, 25)`，`population = c(50000, 100000)`。
- 预期输出：`rate_per_100k = c(20, 25)`。
- 本地未安装 renv、reprex、styler、lintr、DBI 和 odbc；这些命令仅根据官方当前 API 写作，文章不声称本地执行验证。
