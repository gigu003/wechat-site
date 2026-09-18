# 研究记录

## 1. 插值是在已知数据范围内估计新位置的值

- **claim：** R的`approx()`和`approxfun()`根据给定坐标进行线性或常数插值；`xout`指定需要估计的位置。默认情况下，已知范围之外返回`NA`，从接口上明确区分了区间内插值与区间外处理。
- **source：** R Core Team. *Interpolation Functions*.
- **url：** https://stat.ethz.ch/R-manual/R-devel/library/stats/html/approxfun.html
- **date：** 检索于2026-09-05；R开发版文档页面显示`stats` 4.6.0。
- **evidence_type：** 官方软件文档。
- **supports：** 插值定义、线性插值、`approx()`参数和外推边界。
- **limitations：** 文档说明函数行为，不证明插值适合任何缺失机制或任何医学数据。

## 2. 样条插值用分段多项式连接已知点

- **claim：** R的`spline()`和`splinefun()`可对给定数据点进行三次样条或Hermite样条插值，并提供`natural`、`periodic`、`hyman`等方法。
- **source：** R Core Team. *Interpolating Splines*.
- **url：** https://stat.ethz.ch/R-manual/R-devel/library/stats/html/splinefun.html
- **date：** 检索于2026-09-05。
- **evidence_type：** 官方软件文档。
- **supports：** 样条是分段低次多项式方法；R中样条插值的实现和方法选择。
- **limitations：** 曲线平滑不等于结果更接近未知真值；边界行为和保单调需求仍需单独检查。

## 3. 高次多项式插值可能在区间边缘振荡

- **claim：** 对等距节点进行高次多项式插值时，某些函数会出现明显的边缘振荡，即Runge现象；增加节点和多项式次数不一定改善区间内的最大误差。
- **source：** Corless RM, Rafiee Sevyeri L. *The Runge Example for Interpolation and Wilkinson's Examples for Rootfinding*. SIAM Review.
- **url：** https://doi.org/10.1137/18M1181985
- **date：** 论文发表于2019年；检索于2026-09-05。
- **evidence_type：** 同行评议方法论文。
- **supports：** 高次多项式插值的振荡风险及正文中的可复现Runge示例。
- **limitations：** Runge现象不是所有多项式插值都会发生；节点位置、函数性质和数值算法都会影响结果。

## 4. 径向基函数适合多维散点插值，但需要选择核与参数

- **claim：** 径向基函数插值把以观测位置为中心的径向函数线性组合起来，可用于一维及更高维散点数据；核函数、形状参数、平滑参数和邻域设置会影响拟合、稳定性与计算成本。
- **source：** SciPy Developers. *RBFInterpolator*；Hardy RL. *Multiquadric equations of topography and other irregular surfaces*.
- **url：** https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.RBFInterpolator.html ; https://doi.org/10.1029/JB076i008p01905
- **date：** SciPy文档检索于2026-09-05；Hardy论文发表于1971年。
- **evidence_type：** 官方软件文档；原始方法论文。
- **supports：** RBF的多维用途、核与参数依赖、计算限制和方法起源。
- **limitations：** SciPy文档描述Python实现；正文仅用其说明方法性质，不把具体API写成R代码。

## 5. 可复现计算与配图

- **claim：** 本文线性插值、自然三次样条、Runge函数多项式插值和插值/外推边界图均由文章目录内的R脚本生成。
- **source：** `scripts/generate_figures.R`及其本地输出。
- **url：** https://stat.ethz.ch/R-manual/R-devel/library/stats/html/approxfun.html
- **date：** 2026-09-05。
- **evidence_type：** 本地可复现计算。
- **supports：** 正文R代码、五张方法图与封面图。
- **limitations：** 图中数据为教学示例，不代表真实医学研究数据，也不用于比较所有算法的准确率。

## 6. 肿瘤登记率依赖按年龄、性别划分的人口分母

- **claim：** IARC要求人群基础肿瘤登记能够获得登记覆盖人口按性别和5岁年龄组划分的规模；普查之间需要使用普查间人口估计，并建议在可获得时优先采用国家或地方统计部门提供的官方估计。人口分母的误差会直接影响发病率。SEER使用按年龄、性别等分层的年度年中人口作为癌症发病率和死亡率的分母。
- **source：** Bray F, Znaor A, Cueva P, et al. *Planning and Developing Population-Based Cancer Registration in Low- or Middle-Income Settings*；NCI SEER. *U.S. Population Data*.
- **url：** https://www.ncbi.nlm.nih.gov/books/NBK566951/ ; https://seer.cancer.gov/data-software/uspopulations.html
- **date：** IARC技术报告发表于2014年；网页检索于2026-09-05。
- **evidence_type：** IARC技术报告；NCI官方方法说明。
- **supports：** 肿瘤登记人口分母的用途、年龄与性别分层、普查间估计、官方估计优先和年度年中人口概念。
- **limitations：** 两个来源没有把“按组线性插值”规定为统一标准；正文将其作为缺少官方年度人口序列时的透明教学基线，而非官方人口估计的替代方案。
