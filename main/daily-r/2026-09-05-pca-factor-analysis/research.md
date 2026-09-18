# 研究记录

## 1. PCA是以方差最大化为目标的线性变换

- **claim：** PCA将原始变量线性变换为一组彼此不相关的主成分，并按方差大小排序。R的`prcomp()`使用中心化后数据矩阵的奇异值分解；是否标准化由`scale.`参数控制。
- **source：** R Core Team. *Principal Components Analysis: prcomp*；Jolliffe & Cadima. *Principal component analysis: a review and recent developments*.
- **url：** https://stat.ethz.ch/R-manual/R-devel/library/stats/html/prcomp.html ; https://doi.org/10.1098/rsta.2015.0202
- **date：** R文档检索于2026-09-05；论文发表于2016年。
- **evidence_type：** 官方软件文档；方法综述论文。
- **supports：** PCA的目标、输出、中心化/标准化和降维用途。
- **limitations：** PCA保留的是样本中的方差结构，不自动保证得到的主成分具有理论构念含义；结果会受变量尺度、异常值和缺失值处理影响。

## 2. 因子分析是包含潜在因子的统计模型

- **claim：** R的`factanal()`实现最大似然因子分析，模型可写为`x = Λf + e`：观测变量由未观测因子和独特误差共同解释。因子分析将共同方差与独特方差区分开，并可通过旋转帮助解释因子载荷。
- **source：** R Core Team. *Factor Analysis: factanal*；Bartholomew. *The foundations of factor analysis*.
- **url：** https://stat.ethz.ch/R-manual/R-devel/library/stats/html/factanal.html ; https://doi.org/10.1093/biomet/71.2.221
- **date：** R文档检索于2026-09-05；论文发表于1984年。
- **evidence_type：** 官方软件文档；方法论文。
- **supports：** 因子模型、潜变量、共同方差、独特方差、旋转和因子得分。
- **limitations：** 潜在因子不是数据直接观测到的事实；因子数、旋转方式和变量选择会影响解释，模型拟合也需要检查。

## 3. 两种方法的选择取决于问题，不取决于“谁更高级”

- **claim：** 如果目标是压缩变量、可视化或为后续模型减少共线性，PCA通常更直接；如果目标是解释一组指标背后的共同构念，因子分析更符合问题设定。二者输出的成分和因子不能仅因维度较少就当作同一种对象。
- **source：** PCA与因子分析的R官方文档及上述方法论文的综合解释。
- **url：** https://stat.ethz.ch/R-manual/R-devel/library/stats/html/prcomp.html ; https://stat.ethz.ch/R-manual/R-devel/library/stats/html/factanal.html
- **date：** 检索于2026-09-05。
- **evidence_type：** 方法定义与可复现软件文档的综合判断。
- **supports：** 文章中的方法选择表和边界说明。
- **limitations：** 这不是针对具体数据集的分析建议；实际选择仍需结合变量类型、样本量、相关结构、研究目的和模型诊断。
