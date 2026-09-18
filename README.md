# 微信公众号与文章网站

每篇文章只有一份 `main/<series>/<article>/index.qmd`。网站使用
`_extensions/wechat/themes/` 中的 16 套 JSON 主题定义。

文章 YAML 配置示例：

```yaml
title: "文章标题"
article-theme: refined-blue
show-title-block: true
submit: false
# 发布到公众号后填写对应的原文 URL；留空或省略时不显示回链卡片
wechat-link: "https://mp.weixin.qq.com/s/..."
```

`wechat-link` 只接受 `http://` 或 `https://` 地址。填写后，网站文章正文末尾会显示“微信公众号原文”入口，并在新标签页打开对应文章。

## 网站

```bash
quarto preview
quarto render
```

网站统一以 `_quarto.yml` 的 `format: wechat-html` 生成标准 HTML 到 _site/，导航、搜索、目录、页脚继续使用 Quarto。`project.brand` 指向 extension 内的 `brand.yml`，以便 Quarto 编译品牌色板并加载中文字体。
`_extensions/wechat/` 是本站的正式本地 Quarto format extension：`brand.yml`、`styles.css`、过滤器、16 套主题、列表组件和品牌资源都随扩展分发。正文只有声明 `article-theme` 时才应用文章主题，首页和栏目页保留原生网站结构。
网站 HTML 支持 Quarto 原生 light/dark 模式切换，默认尊重系统偏好并保留读者的选择；深色配色定义在 `_extensions/wechat/themes/dark.scss`，站点壳层适配集中在 `styles.css`。
网站通过 GitHub Actions 使用 Quarto 1.10.18 渲染，并将 `_site/` 部署到 GitHub Pages；每次推送 `main` 分支都会触发部署，Pull Request 只执行渲染检查。
三个栏目页的标题区分别使用 extension 内 `assets/brand/category-*-watercolor.png` 的水彩背景主视觉，保持标题、简介与 RSS 订阅在左侧清晰可读。
正文保留原生结构和锚点；列表使用浏览器原生编号，微信使用主题装饰标记。
文章列表卡片在新标签页打开。

RSS 订阅由 Quarto listing 原生生成：

- 全部文章：`/index.xml`
- 肿瘤登记：`/categories/cancer-registry.xml`
- R语言与数据科学：`/categories/daily-r.xml`
- 肿瘤防治与健康科普：`/categories/medical-popular-science.xml`

每个 feed 为摘要模式，最多保留 100 篇。`website.site-url` 决定 feed 内的绝对链接；站点迁移时必须同步更新该值。

主题可选：academic-paper、business-navy、elegant-ink、girly-pink、ink-wash、
literary-prose、magazine-grid、minimal-bw、minimal-mono、mint-fresh、news-bold、
refined-blue、sage-premium、sunset-coral、warm-editorial、warm-orange。

## 文章与公众号草稿

文章撰写、隔离微信预览、人工批准和草稿创建均由显式调用的 `pub-wechat2` skill 托管。
它读取本站的文章和主题 JSON，但自身持有微信模板、公式处理器、发布逻辑和私有账号配置。
网站目录不包含公众号凭证或发布脚本。

## 检查

```bash
python3 -m unittest discover -s tests
```
