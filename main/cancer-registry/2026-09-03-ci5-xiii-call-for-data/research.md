# 研究问题

CI5-XIII 数据召唤面向哪些登记处？正式评估的目标时期、最低数据年限、所需文件、关键字段、提交方式和截止日期是什么？哪些资料属于可选项？

# 证据台账

## 1. 召唤对象与出版范围

- claim: CI5-XIII 是 Cancer Incidence in Five Continents 的第 13 卷，正式出版数据覆盖 2018—2022 年；目标是汇集可比、完整且准确的人群癌症登记发病资料。
- source: IARC/IACR, *Call for Data: Cancer Incidence in Five Continents Volume XIII — Data Specification Protocol*, 1 September 2026；Introduction / General Information。
- url: https://gco.iarc.who.int/media/iacr/docs/CI5-XIII_Call_for_Data_FINAL_EN.pdf
- date: 2026-09-03（访问；文件日期 2026-09-01）
- evidence_type: 官方数据召唤协议
- supports: 正文中的 CI5-XIII 名称、目标时期、评估目的和发布形式。
- limitations: 官方文本中个别位置出现 “CI5-XIIII” 的排版/OCR 痕迹；本文统一按标题和邀请信使用 CI5-XIII。

## 2. 资格与最低年限

- claim: 可提交的登记处需为人群癌症登记处、IACR voting 或 associate member，并收集所有癌症部位和类型、所有年龄组的信息；2018—2022 年内连续 3 年数据是进入出版评估的最低要求。
- source: IARC/IACR, *Invitation Letter* / *Call for Data*。
- url: https://gco.iarc.who.int/media/iacr/docs/CI5-XIII_Invitation_Letter_FINAL_EN.pdf
- date: 2026-09-03（访问；信件日期 2026-09-01）
- evidence_type: 官方邀请信与数据协议
- supports: 正文中的资格条件、三年最低要求和完整性提醒。
- limitations: “至少三年”是最低考虑条件，不等于一定会被纳入出版；数据仍需经过 Editorial Board 质量评估。

## 3. 必备材料与文件格式

- claim: 清单要求提交病例个案列表、人口资料、可用的死亡资料、可用的生命表资料、编码规则有差异时的 coding file，以及在线 questionnaire。病例、人口和死亡数据应分别提交；可用逗号、分号、制表符或竖线分隔，单个大文件可以单独压缩，但不应把多个数据文件打包成一个压缩包。
- source: IARC/IACR, *Call for Data*, Summary / File Format / Questionnaire。
- url: https://gco.iarc.who.int/media/iacr/docs/CI5-XIII_Call_for_Data_FINAL_EN.pdf
- date: 2026-09-03（访问）
- evidence_type: 官方数据规范
- supports: 正文中的材料清单、分文件提交和问卷要求。
- limitations: 具体字段编码应以完整协议和登记处实际编码情况为准；本文是工作准备清单，不替代原始协议。

## 4. 病例资料与可选字段

- claim: 2018—2022 年所有年龄的原发肿瘤应提交；如登记处收集，还包括皮肤基底细胞癌、鳞状细胞癌，以及中枢神经系统和膀胱的非恶性肿瘤。病例文件每行一个病例。Patient ID 不得允许现实身份识别，病例文件不得包含姓名。Vital status、Date of Last Contact、TNM Stage 和 TNM edition 在邀请信中明确为 incidence data submission 的可选变量。
- source: IARC/IACR, *Call for Data* / *Invitation Letter*。
- url: https://gco.iarc.who.int/media/iacr/docs/CI5-XIII_Call_for_Data_FINAL_EN.pdf ; https://gco.iarc.who.int/media/iacr/docs/CI5-XIII_Invitation_Letter_FINAL_EN.pdf
- date: 2026-09-03（访问）
- evidence_type: 官方数据规范与邀请信
- supports: 正文中的病例范围、隐私提醒和可选字段说明。
- limitations: 保护患者隐私的具体法律义务还取决于登记处所在司法辖区；遇到个案级数据传输限制，应尽早联系编辑部。

## 5. 质量核查、疫情年份与提交入口

- claim: 官方建议提交前用 IARCcrgTools 等工具核查和纠正发病资料，并可使用 IARC flag 标记已经验证的记录。2020 和 2021 年若出现病例发现不足的证据，审查时会以星号标记。新 Registries Portal 使用 REDCap；登记处会收到自动邮件，其中包含用户名和设置密码的链接，并应首次登录时更新 registry contacts。完整提交必须同时包含数据集和 questionnaire。
- source: IARC/IACR, *Call for Data* / *Invitation Letter*。
- url: https://gco.iarc.who.int/media/iacr/docs/CI5-XIII_Invitation_Letter_FINAL_EN.pdf ; https://csu.datacollect.iarc.who.int/redcap/
- date: 2026-09-03（访问）
- evidence_type: 官方邀请信与数据规范
- supports: 正文中的质控、Portal、COVID-19 年份标记和完整提交条件。
- limitations: 本文未实际登录 Registry Portal，也未验证某一登记处的账号状态或数据是否符合出版标准。

## 6. 截止日期与扩展数据

- claim: 数据提交截止日期为 2026 年 11 月 30 日，官方鼓励尽早提交。2018 年以前的资料可用于更新既有数据集和质量评估；如果 2022 年以后的资料完整，也可用于 IARC/IACR 网站数据可视化，但 CI5-XIII 正式出版评估只针对 2018—2022 年资料。CI5-XIII 提交数据还可能间接用于未来 GLOBOCAN 国家估计。
- source: IARC/IACR, *Invitation Letter* / *Call for Data*；IACR CI5 2.0 页面。
- url: https://gco.iarc.who.int/media/iacr/docs/CI5-XIII_Invitation_Letter_FINAL_EN.pdf ; https://www.the-iacr.net/en/ci5-2.0/about
- date: 2026-09-03（访问）
- evidence_type: 官方邀请信、官方数据规范和 IACR 官方页面
- supports: 正文中的截止日期、正式评估时段、补充年份用途和 CI5 2.0 入口。
- limitations: 是否最终收录、公开哪些字段和后续可视化呈现，仍取决于编辑部评估、数据完整性和登记处授权。

# SEO 研究备注

- 目标读者：人群肿瘤登记处负责人、登记数据管理人员、肿瘤流行病学和医学科研人员。
- 核心搜索问题：CI5-XIII 数据召唤截止时间是什么？需要提交哪些资料？2018—2022 年数据需要几年？CI5-XIII Registries Portal 如何进入？
- 关键词候选及来源：CI5-XIII、Cancer Incidence in Five Continents、数据召唤、Call for Data、Registries Portal、2018—2022、2026 年 11 月 30 日；均来自用户提供的官方页面和 PDF 文件。
- 微信联想词、微信指数、后台搜索词和竞品结果：unknown。未用网页搜索量替代。
