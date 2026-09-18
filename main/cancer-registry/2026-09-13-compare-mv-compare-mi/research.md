# Research claim ledger

检索与核查日期：2026-09-13

## 1. 质量框架与MV%

- **claim：** 肿瘤登记资料质量可从可比性、有效性、及时性和完整性评价。MV%常用于评价诊断信息的有效性；异常偏高也可能提示登记过度依赖病理来源。
- **source：** Bray F, Parkin DM. *Evaluation of data quality in the cancer registry: Part I.* European Journal of Cancer. 2009;45(5):747–755.
- **url：** https://pubmed.ncbi.nlm.nih.gov/19117750/
- **evidence_type：** 同行评议方法综述；本地全文核查。
- **supports：** 质量维度、MV%的双向解释及附录统计检验。
- **limitations：** MV%是间接指标，不能单凭高低判定个案诊断或登记完整性。

## 2. M:I的定位与条件

- **claim：** M:I是同一时期、同一癌种死亡数与新发病例数之比，是完整性的半定量指标。偏高可提示漏报，但死亡资料、死因编码、发病趋势和生存差异也会改变它。
- **source：** Parkin DM, Bray F. *Evaluation of data quality in the cancer registry: Part II.* European Journal of Cancer. 2009;45(5):756–764.
- **url：** https://pubmed.ncbi.nlm.nih.gov/19128954/
- **evidence_type：** 同行评议方法综述；本地全文核查。
- **supports：** M:I定义、解释条件、可比地区选择及附录检验。
- **limitations：** 该检验不能直接估计登记完整率。

## 3. ASR的时期比较

- **claim：** 两个独立时期的ASR可结合各自标准误比较；ASR比值可用Miettinen近似构造置信区间。若年龄别率比不稳定，应回到年龄别发病率分析。
- **source：** IARC. *Cancer Incidence in Five Continents, Volume VIII*, Chapter 5.
- **url：** https://publications.iarc.who.int/download/ci5v8-chap5.pdf
- **evidence_type：** IARC官方专著章节；全文与公式页核查。
- **supports：** `x=(R1-R2)/sqrt(S1²+S2²)`及ASR比值的近似置信区间。
- **limitations：** ASR汇总比较不能替代年龄别曲线，时期口径变化仍需调查。

## 4. ASR的区域参照检验

- **claim：** 可用同一区域多个历史登记处的ASR及标准误估计区域均值与额外离散，目标平方标准化偏差近似服从自由度1的卡方分布；若离散估计小于1则设为1。IARC还提出3倍和0.3倍的明显偏离筛查规则。
- **source：** IARC. *Cancer Incidence in Five Continents, Volume VIII*, Chapter 5.
- **url：** https://publications.iarc.who.int/download/ci5v8-chap5.pdf
- **evidence_type：** IARC官方专著章节；全文与公式页核查。
- **supports：** 区域均值、过度离散、目标 `Z²`、临界值与粗筛规则。
- **limitations：** 倍数规则只是调查触发器；参照登记处必须可比。

## 5. MV%的统计检验

- **claim：** 用参照登记处的MV病例数和总病例数估计共同MV比例，以Pearson型离散参数调整登记处间额外变异；目标平方标准化偏差近似服从自由度1的卡方分布。
- **source：** Bray F, Parkin DM. Part I，附录。
- **url：** https://pubmed.ncbi.nlm.nih.gov/19117750/
- **evidence_type：** 原始方法论文附录。
- **limitations：** 正式评价应使用精确MV病例数，不宜由四舍五入百分比反推分子。

## 6. M:I的统计检验

- **claim：** 以参照登记处总死亡数除以总发病数估计共同M:I，利用死亡数与发病数估计额外离散，再检验目标登记处的平方标准化偏差。
- **source：** Parkin DM, Bray F. Part II，附录。
- **url：** https://pubmed.ncbi.nlm.nih.gov/19128954/
- **evidence_type：** 原始方法论文附录。
- **limitations：** 共同漏报、死亡登记问题、真实生存差异或快速发病趋势都可能误导结果。

## 7. 解释边界

- **claim：** ASR、MV%和M:I的异常比较均是质量筛查，不能替代个案逻辑校验、重复病例识别、死亡证书追溯、病例来源核对或完整率估计；大量比较还会增加偶然阳性。
- **source：** 两篇方法论文与IARC专著章节综合。
- **evidence_type：** 方法学综合判断。
- **limitations：** 复核优先级应结合当地资料流程与预先制定的质控方案。

## Stop condition

两篇原始方法论文与IARC官方专著章节已经覆盖ASR、MV%和M:I的定义、公式、参照选择及解释边界；新增检索不再增加正文所需核心结论，停止搜索。微信联想词、微信指数和后台搜索词证据不可得，SEO相关数据保持 `unknown`。
