# 研究记录

## 1. ChatGPT 的公开发布时间

- claim: ChatGPT 于 2022 年 11 月 30 日以 research preview 形式公开发布，产品定位是对话式交互。
- source: OpenAI, Introducing ChatGPT
- url: https://openai.com/index/chatgpt/
- date: 2022-11-30
- evidence_type: 官方产品发布说明
- supports: 支持文章对 ChatGPT 早期形态和时间的概括。
- limitations: 不能据此证明 ChatGPT 在所有搜索、整理或理解任务上都优于搜索引擎。

## 2. MCP 的作用

- claim: MCP 通过 prompts、resources、tools 等原语，把上下文和可调用工具以标准化方式暴露给 AI 应用；其中 tools 可用于查询数据库、调用 API 或执行计算。
- source: Model Context Protocol, Specification
- url: https://modelcontextprotocol.io/specification/2025-06-18/server/index
- date: 2025-06-18
- evidence_type: 官方协议规范
- supports: 支持文章对 MCP“让模型连接外部工具和数据”的解释。
- limitations: MCP 只定义连接与暴露能力，不保证模型调用正确，也不代表工具可以超越其接口权限。

## 3. Agent 能够执行任务，但仍有边界

- claim: OpenAI 对 Operator 的官方介绍将其描述为能够使用浏览器执行任务的 agent，并明确说明早期系统存在局限，遇到登录、支付或 CAPTCHA 等情况需要用户接管。
- source: OpenAI, Introducing Operator
- url: https://openai.com/index/introducing-operator/
- date: 2025-01-23
- evidence_type: 官方产品发布说明
- supports: 支持文章把 Agent 描述为“能够执行连续任务的系统”，并保留其需要监督和接管的边界。
- limitations: Operator 的能力和适用范围不能直接外推到所有 Agent、MCP 客户端或编程工具。

## 写作边界

- “AI 能完成我 90% 的工作”保留为作者在原稿中的主观感受，不写成劳动力市场事实。
- 关于 canregtools、ltRISK、Cline 和个人工作流的内容来自用户原稿，不额外扩展未经核验的版本、性能或使用效果。
- 本文讨论工作方式与职业感受，不提供个体职业判断，也不把自动化程度直接等同于失业结果。
