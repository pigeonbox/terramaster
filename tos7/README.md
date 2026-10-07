# TOS 7 Docker 应用 4 文件包二期路线(铁威马)

v0.1 交付形态是「Docker Manager → 项目 → 上传/粘贴 compose」(见仓库根 README)。
本目录是升级到 **TOS 7 官方 Docker 应用包**(应用中心形态)的预留骨架。

## 前置事实(2026-10 调研,来源见仓库根 README「参考」)

- TOS 7 新应用只收 **Deb 与 Docker 应用**两种格式,tpk 提交通道已关闭;
  Docker 应用 = `config.ini` + `<appid>.lang` + `<appid>.svg` + `docker-compose.yml` 四文件 tar.gz
- **应用商店拒收 ghcr.io / quay.io 镜像**(只允许 Docker Hub)——送审硬前置:
  需先把 `ghcr.io/pigeonbox/server|frontend` 同步发布到 Docker Hub
  (生态层决策,需在 server 仓 release 流水线加 Docker Hub 推送,待拍板)
- compose 强校验规则(模板 README 原文):禁 latest / 禁 privileged / 禁 host 网络 /
  数据必须挂 `/Volume*/DockerAppData/<appid>/` / 每服务必须有 healthcheck /
  必须显式 TZ / 有 Web UI 须加 `x-app-meta.web` 段 / container_name 须等于应用 id
  (双容器应用的命名细则以官方模板实测为准,骨架按 server/frontend 双名写,待校验)
- 手动安装通道(App Center → 设置 → 手动安装)只收 `.tpk`/`.deb`,
  **4 文件 Docker 包不走手动安装**,只能送审上架
- 打包送审:developer.terra-master.com 平台自动校验+人工审核;社区有 CI action
  (htynkn/terra-master-packing-action)可复用

## 目录现状(二期启动时)

- `config.ini` / `pigeonbox.svg` 已按模板字段预置(未经官方模板 diff 校验)
- 缺:`pigeonbox.lang`(14 语言文件,可先只填 zh-cn/en-us)、适配 `DockerAppData`
  路径与 `x-app-meta` 的专用 compose(现有 `deploy/compose.yml` 不可直接复用)

## 参考实现

- [terramaster-tos/tos-app-pkg-tools](https://github.com/terramaster-tos/tos-app-pkg-tools) — 官方 TOS 7 模板(`TOS 7-template-docker/`)
- [terramaster-tos/tos-app-pkg-tools-legacy](https://github.com/terramaster-tos/tos-app-pkg-tools-legacy) — TOS 5/6 打包工具与 tpk 逆向参考
- [tmnascommunity.eu](https://tmnascommunity.eu/2022/09/26/how-to-manually-install-the-apps/) — 社区应用站与手动安装教程
