# 调研笔记：AI 时代做数据分析，还要先学写代码吗？

访问日期：2026-08-27

## 1. UC Berkeley Data 8

- 来源：UC Berkeley《Foundations of Data Science》课程官网
- URL：https://data8.org/
- 日期：网站当前列出 2026 年课程
- 证据类型：高校官方课程资料
- 可支持：该入门课程将推断思维、计算思维和真实问题结合，并同时教授编程与统计推断；示例使用 Python 3 和 Jupyter Notebook。
- 不能推出：不能因一门课程的设计，就认定所有数据分析者都必须按相同顺序学习，也不能直接证明 AI 时代的最佳课程应如何设计。

## 2. ACM 数据科学计算能力框架

- 来源：ACM Data Science Task Force，*Computing Competencies for Undergraduate Data Science Curricula*
- URL：https://dstf.acm.org/DSReportInitialFull.pdf
- 日期：2021 年最终报告
- 证据类型：专业学会能力框架
- 可支持：计算与编程被视为本科数据科学的组成能力，包括在数据科学问题中使用统计计算语言。
- 不能推出：报告成稿于生成式 AI 广泛使用前，不能单独回答“现在应该记多少语法”。

## 3. AI 帮助与技能形成的随机试验

- 来源：Anthropic Research，*How AI assistance impacts the formation of coding skills*
- URL：https://www.anthropic.com/research/AI-assistance-coding-skills
- 日期：2026-01-29
- 证据类型：随机对照试验，52 名主要为初级的软件工程师
- 可支持：参与者学习新的 Python Trio 库时，AI 组随后的理解测验平均成绩低 17%；把 AI 用于追问解释、理解概念的参与者，掌握情况较好。
- 不能推出：样本较小，测量的是短期理解，任务是学习异步编程库，不是医学数据分析；研究来自 AI 供应商，需结合设计和局限解读。

## 4. 早期 2025 AI 工具与资深开源开发者效率

- 来源：METR，*Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity*
- URL：https://metr.org/Early_2025_AI_Experienced_OS_Devs_Study-paper.pdf
- 日期：2025-07
- 证据类型：随机对照现场试验，16 名资深开源开发者、246 项真实任务
- 可支持：在该特定场景中，允许使用早期 2025 AI 工具后，完成时间增加 19%；主观感到更快不等于实测更快。
- 不能推出：结果与当时工具、成熟大型代码库、小样本和资深开发者有关，不能外推为“AI 一定使所有人变慢”，也不代表 2026 年所有工具。

## 5. 生成式 AI 的虚构风险

- 来源：NIST AI 600-1，*Artificial Intelligence Risk Management Framework: Generative Artificial Intelligence Profile*
- URL：https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf
- 日期：2024-07
- 证据类型：政府技术风险框架
- 可支持：生成式 AI 可能自信地生成错误、虚假或前后不一致的内容，也可能生成错误逻辑或虚假引用；在需要领域知识和高后果决策的场景中尤需监测。
- 不能推出：该框架描述风险类型，不给出某个代码模型的固定错误率。

## 6. 编程 Agent 使用中的领域知识

- 来源：Anthropic Research，*Agentic coding and persistent returns to expertise*
- URL：https://www.anthropic.com/research/claude-code-expertise
- 日期：2026-06-16
- 证据类型：隐私保护的观察性产品数据分析，约 40 万次会话
- 可支持：在该产品数据中，人更多做“做什么”的规划，Agent 更多做“怎么做”的执行；任务领域知识更高与会话成功率更高相关。
- 不能推出：这是 AI 供应商的观察性分析，专长分级由模型评定，且未测量代码在会话后是否被实际采用或产生真实价值；不能作因果解释。

## 7. 本机可复现运行

- 环境：R 4.5.2（2025-10-31），base R，无额外包
- 输入：R 内置 `mtcars`，32 行；变量 `mpg`、`wt`、`hp`
- 代码：`lm(mpg ~ wt + hp, data = mtcars)`
- 输出：截距 37.227，`wt` 系数 -3.878，`hp` 系数 -0.032，样本数 32，R² 0.827
- 可支持：一段短代码可以被运行、检查输入并保留预期输出。
- 不能推出：`mtcars` 只是教学数据；该回归不是因果分析，也不用于医学决策。
