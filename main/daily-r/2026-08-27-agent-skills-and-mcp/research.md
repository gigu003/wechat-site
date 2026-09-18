# 资料核查记录

检索日期：2026-08-27

## 1. Agent Skills 开放规范

来源：Agent Skills specification  
https://github.com/agentskills/agentskills/blob/main/docs/specification.mdx

证据类型：开放规范与官方仓库。

可支持：

- 一个 Skill 至少是包含 `SKILL.md` 的目录。
- `SKILL.md` 由 YAML frontmatter 和 Markdown 正文组成；`name` 与 `description` 为必填字段。
- Skill 可以附带 `scripts/`、`references/`、`assets/`。
- 规范建议渐进披露：启动时加载元数据，触发后读取完整 `SKILL.md`，其他资源按需读取。
- `allowed-tools` 仍标为实验字段，不同客户端支持可能不同。

不能推出：

- 任意客户端都完整实现所有可选字段。
- 来自社区的 Skill 已经过安全审计。
- Skill 会自动获得系统、网络或外部服务权限。

## 2. OpenAI 对 Skills 的当前说明

来源：OpenAI Help Center, Skills in ChatGPT  
https://help.openai.com/en/articles/20001066

证据类型：产品官方帮助文档。

可支持：

- Skills 是可复用、可共享的工作流，可以包含指令、示例和代码。
- OpenAI Skills 遵循 Agent Skills 开放标准；Skills 也用于 Codex 和 API。
- 外部来源 Skill 需要审查；平台扫描不能替代使用者自己的安全判断。

不能推出：

- 所有产品表面的安装、同步、权限和调用方式完全一致。
- Skill 本身就是外部数据连接或身份认证机制。

## 3. MCP 官方规范

来源：Model Context Protocol server overview  
https://modelcontextprotocol.io/specification/2025-06-18/server/index

来源：MCP tools specification（2026-07-28）  
https://github.com/modelcontextprotocol/modelcontextprotocol/blob/main/docs/specification/2026-07-28/server/tools.mdx

证据类型：协议官方规范。

可支持：

- MCP server 可以暴露 prompts、resources 和 tools。
- Tools 是模型可发现和调用的函数，可以查询数据库、调用 API 或执行计算。
- Tool 定义包含名称、描述和输入 schema；客户端使用 `tools/list` 发现工具。
- 官方规范建议保留人在回路，界面应说明暴露给模型的工具、显示调用并对操作提供确认。

不能推出：

- MCP server 返回的内容天然可信。
- 安装 server 等于授权所有工具自动运行。
- MCP 会替 Agent 设计业务流程或判断标准。

## 4. OpenAI 对 Skills 与外部连接能力的产品说明

来源：OpenAI Help Center, Plugins in ChatGPT and Codex  
https://help.openai.com/en/articles/20001256-plugins-in-codex/

证据类型：产品官方帮助文档。

可支持：

- Skills 提供可复用指令、提示和工作流模式。
- Apps 连接外部系统、数据和动作；插件可以把 Skills 与连接能力组合成一个工作流包。
- 外部连接仍继承源系统和工作区权限，安装工作流包不会绕过源系统权限。

不能推出：

- OpenAI 产品中的 Apps 与所有客户端里的 MCP 是完全相同的产品层概念。
- 连接能力会自动生成正确的医学或科研判断。

## 5. 文章采用的概念边界

- Agent Skill：把稳定的流程、判断规则、输出模板、脚本和参考资料打包，让 Agent 知道“怎样完成某类任务”。
- MCP：标准化客户端与外部 server 的通信，让 Agent 能发现并调用“有哪些数据和工具”。
- 两者有局部重叠：MCP 有 prompts，Skill 也可以引用脚本和工具；文章用“主要职责”区分，避免把边界写成绝对隔离。
- Skill 不等于模型训练或微调；MCP 不等于 Agent 的推理能力。
- 对专业工作，稳定步骤写进 Skill，动态数据和外部动作通过 MCP，敏感操作保留人工确认。

## 6. 示例场景与不可外推范围

### 医学文献检索

- Skill：规定研究问题、查询式记录、纳排条件、PMID/DOI 核验、摘要与全文边界、输出模板。
- MCP：连接 PubMed、Zotero 或其他文献服务并返回实时记录。
- 不能推出：检索到文献等于完成系统综述或完成证据质量评价。

### 肿瘤登记数据质控

- Skill：规定字段口径、质控顺序、错误分级、报告模板和不可自动修正的情形。
- MCP：连接数据库、文件服务、问题跟踪系统或报告系统。
- 不能推出：MCP 连接数据库后可以在无审核情况下直接改写登记数据。

## 7. 安全检查要点

- 审查 Skill 来源、指令、脚本、依赖和写入范围。
- 审查 MCP server 来源、工具清单、输入输出 schema、身份认证与日志。
- 只开放完成任务所需的最小权限。
- 将读取、创建草稿、正式写入、删除或发送区分为不同授权等级。
- 工具输出仍需核验；网页、文档和工具返回值可能包含提示注入或不可信内容。
