# Research claim ledger

## 1. Joinpoint置换检验的原始方法

- **claim:** Kim等提出连续分段回归的Joinpoint方法，以网格搜索估计未知拐点，以Monte Carlo残差置换检验比较不同拐点数量，并用Bonferroni校正控制连续模型比较的总体显著性水平；方法扩展到Poisson异方差和可能存在自相关的误差。
- **source:** Kim HJ, Fay MP, Feuer EJ, Midthune DN. *Permutation tests for joinpoint regression with applications to cancer rates.* Statistics in Medicine. 2000;19(3):335-351.
- **url:** https://pubmed.ncbi.nlm.nih.gov/10649300/
- **date:** 2000-02-15
- **evidence_type:** 原始方法论文；已通过Zotero附件阅读全文并形成paper-review证据卡
- **supports:** 模型定义、算法、模拟设置与结果、前列腺癌实例、作者报告的局限。
- **limitations:** 论文发表于2000年，描述的是当时的算法与软件；不能用来断言当前版本所有默认设置。实例为聚合趋势分析，不能证明PSA筛查造成趋势变化。

## 2. NCI当前Joinpoint软件说明

- **claim:** NCI官方说明将Joinpoint用于趋势分析；用户指定最小和最大拐点数，软件从较简单模型开始检验是否需要增加拐点。官方页面仍将Monte Carlo permutation列为显著性检验方法，并允许估计方差、Poisson变异及对数线性模型。
- **source:** U.S. National Cancer Institute, Surveillance Research Program. Joinpoint Trend Analysis Software.
- **url:** https://surveillance.cancer.gov/joinpoint/
- **date:** 访问于2026-08-28；页面显示Version 6.1.0，2026-07-20
- **evidence_type:** 官方软件文档
- **supports:** Joinpoint当前仍是NCI趋势分析软件；基本模型选择逻辑；Monte Carlo置换、方差和对数率模型仍受支持。
- **limitations:** 官方概览不是完整方法手册；文章只用版本信息作现状说明，不据此推断所有高级选项。

## 3. 原论文Table I(a)勘误

- **claim:** NCI发布的勘误指出，原论文p.342的Table I(a)中，部分情景下(apc1, apc2)=(3,2.4)与(3,1.5)对应的Mean estimated joinpoint ± SE需要互换。
- **source:** U.S. National Cancer Institute. *(Corrected) Table 1: Size and power for independent log-normal observations.*
- **url:** https://surveillance.cancer.gov/documents/joinpoint/table1.pdf
- **date:** 访问于2026-08-28
- **evidence_type:** 官方勘误
- **supports:** 提醒读者使用原文Table I(a)的拐点均值和标准误时应查看勘误。
- **limitations:** 勘误针对均值拐点和标准误对应关系；本文引用的零假设size范围及Poisson、自相关结果不受该互换影响。

## 4. 后续模型选择方法

- **claim:** Kim等后续研究提出基于BIC与BIC3加权的模型选择方法，目标之一是降低置换检验的计算成本；该方法使用partial R²在两种准则间加权，并通过模拟比较正确模型选择概率。
- **source:** Kim HJ, Chen HS, Midthune D, et al. *Data-driven choice of a model selection method in joinpoint regression.* Journal of Applied Statistics. 2023;50(9):1992-2013.
- **url:** https://pubmed.ncbi.nlm.nih.gov/37378270/
- **date:** 2022-04-18 online; 2023 collection
- **evidence_type:** 原始方法论文
- **supports:** 说明2000年的置换检验不是Joinpoint模型选择的唯一后续方案，计算效率后来得到专门改进。
- **limitations:** 本文不展开WBIC/BIC/BIC3公式，也不比较当前软件各选项的优劣。

## 5. 更复杂的相关结构

- **claim:** NCI官方资料指出，复杂抽样的时间点估计可能具有超出常规异方差或简单自相关假设的协方差结构；较新方法可以在聚合层面纳入完整方差-协方差矩阵。
- **source:** U.S. National Cancer Institute, Surveillance Research Program. Joinpoint Methods for Complex Survey Data.
- **url:** https://surveillance.cancer.gov/joinpoint/survey.html
- **date:** 访问于2026-08-28
- **evidence_type:** 官方方法说明
- **supports:** 强调误差结构不是技术细节，复杂数据需使用匹配的协方差处理。
- **limitations:** 复杂抽样方法不是2000年论文的组成部分；本文只用于说明适用边界与方法发展。

## Stop condition

原始论文、官方软件文档、官方勘误及后续原始方法论文已覆盖模型定义、关键数字、当前实现背景和适用边界。新增检索不再增加正文所需的核心结论，停止搜索。
