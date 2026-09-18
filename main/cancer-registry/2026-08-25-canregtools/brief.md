---
topic: canregtools：从肿瘤登记数据到率、质控与报告的完整使用方法
title: canregtools：从肿瘤登记数据到率、质控与报告的完整使用方法
account: main
type: news
content_type: tool-guide
audience:
- 肿瘤登记从业者
- 医学科研人员
evidence_level: 可追溯来源
real_experience_sources:
- 用户明确说明 canregtools 是我们自己编写的包，并提供本地源码路径
- 本地 DESCRIPTION 的作者与 main 账号作者一致
primary_topic: research-tools
topic_tags:
- research-tools
- registry-practice
- data-quality
topic_tags_confirmed: true
article_structure: playbook
opening_hook: artifact-first
---

# 研究问题

肿瘤登记数据从 Excel 或数据框进入 R 后，怎样用一套明确的数据对象和函数，完成癌种分类、病例计数、年龄标化率、质量指标、年龄别率、绘图与报告准备？

# 版本与真实经历来源

- 用户明确说明 canregtools 是“我们自己编写”的包，并提供本地源码路径 `/Users/qc0824/Documents/2_Areas/R_Packages/canregtools`。
- 本地 `DESCRIPTION` 将 Qiong Chen 列为作者、维护者和版权所有者，与 main 账号作者陈琼博士一致。
- 教程以 R-universe 已发布的 canregtools 0.2.11、公开提交 `0838ce7` 为准；不把本地未提交功能写成已发布能力。

# 写作要求

从对象流切入，按“安装与输入—最小示例—三类核心输出—多登记处与报告—常见错误和边界”推进。必须给出可执行代码与经 0.2.11 快照验证的输出；参考资料显示完整网址。
