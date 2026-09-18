# 调研笔记：肿瘤登记数据质量控制

检索日期：2026-08-24

## 权威层

### 1. IARC：四维数据质量框架

- IARC 《Quality control at the population-based cancer registry》将数据质量分为四个维度：可比性（comparability）、有效性（validity）、及时性（timeliness）和完整性（completeness）。
- 可比性依赖诊断、分类编码、发病日期和多原发癌规则的标准化。
- 有效性常看缺失值、MV%、DCO%及内部一致性，但各指标必须结合当地诊断可及性、死亡证明质量和回溯能力解读。
- 及时性和完整性存在取舍，不宜只追求“快”。
- 完整性的评价方法包括历史趋势、M/I、相似人群比较、独立病例发现、捕获—再捕获和死亡证明法。
- 来源：https://publications.iarc.who.int/_publications/media/download/3827/77466e390723d27d694a765d89ff095173fca104.pdf

### 2. IARC/IACR：经典质控指南

- 1994 年 IARC 技术报告强调三件事：统一诊断、分类与编码规则；评估病例发现完整性；用缺失、重抽象/重编码和内部一致性检查验证数据。
- 来源：https://publications.iarc.who.int/Book-And-Report-Series/Iarc-Technical-Publications/Comparability-And-Quality-Control-In-Cancer-Registration-1994

### 3. 国家《肿瘤登记管理办法》

- 登记处工作包括建档、编码、补漏、剔重、核对、分析和随访。
- 责任报告单位需要报告辖区内肿瘤病例，疾控机构提供死因监测数据，各层级承担质控和评价。
- 来源：https://www.nhc.gov.cn/jkj/c100063/201502/365ceb5ebd1346e69626ffcc787d7b4a.shtml

### 4. 国内历史考核阈值的使用边界

- 2011 年《全国慢性病预防控制工作规范（试行）》的示范区考核条目曾采用：M/I 0.6–0.8、MV% >66%、DCO% <15%、发病率年波动 <10%。
- 这些是特定时期、特定考核场景下的阈值，不应脱离癌种、性别、年龄、诊断资源和当地现行规范机械套用。
- 来源：https://www.nhc.gov.cn/cmsresources/mohbgt/cmsrsdocument/doc12214.pdf

### 5. 2026 年上海实践：从人工填报走向系统对接

- 2026 年 3 月 1 日起施行的《上海市肿瘤登记管理办法》鼓励通过后台数据交换、医学智能提醒插件或页面填报进行登记，并从医院诊疗系统自动抓取信息。
- 同时保留了审核退回、补充更正、社区核实、死亡信息比对等人工和跨机构环节。
- 来源：https://www.shanghai.gov.cn/gwk/search/content/a9e440078362493e951c3bf6a180c401

### 6. 当前工具与国际资源

- IARC 目前仍将 CanReg5 列为肿瘤登记工具，其功能包括录入、质控、一致性检查和基本分析。
- IARC/GICR 已提供 16 个自定进度学习模块，覆盖登记运行、数据分析和传播等。
- 来源：https://www.iarc.who.int/branches-csu/

## 执行层（“真人层”场景）

本话题的公开社区讨论较少，不引用无法核实的匿名抱怨。以公开办事指南和实际操作材料提取一线工作语料：

- 一张报告卡常经历“检查漏项→退回补充→ICD-O-3 编码→录入→随访反馈”，并非一次录入就结束。
- 病人可在多家医院就诊，重复报告很常见；去重不能只靠姓名。
- 死亡资料与发病库比对，能发现未报的肿瘤死亡病例，但仍需要回溯诊断信息。
- 来源：https://www.cnjx.gov.cn/Jczwgk/show/3553667.html
- 补充案例：https://www.chenq.site/slides/2023-5-16-canreg-report/example.html

## 写作取舍

- 不把任何单一指标写成“越高越好”或“越低越好”。
- 不将 2011 年考核阈值写成 2026 年通用的全国硬标准。
- 区分“项目完整”和“病例发现完整”。
- 提倡自动化，但明确自动化不能代替来源回查、编码判断和跨库核对。
