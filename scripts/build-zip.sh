#!/usr/bin/env bash
# 打包铁威马 TOS「compose 项目部署包」zip(发布资产)。
# 内容:deploy/ 下的 compose 编排、.env 模板、安装指引。
# 用法: ./scripts/build-zip.sh <版本>     例: ./scripts/build-zip.sh 0.1.0
set -euo pipefail
cd "$(dirname "$0")/.."

VERSION="${1:?用法: build-zip.sh <版本>(例: 0.1.0)}"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

OUT="dist/filescodebox-terramaster-${VERSION}.zip"
mkdir -p dist
# 文本压 LF(上传 TOS 与 Windows 下载解压场景都不被 CRLF 坑)
for f in deploy/compose.yml deploy/env.example README.md; do
    perl -pi -e 's/\r$//' "$f"
    cp "$f" "$STAGE/$(basename "$f")"
done
mv "$STAGE/README.md" "$STAGE/安装指引.md"
(cd "$STAGE" && zip -q -r "$OLDPWD/$OUT" .)
echo "✓ ${OUT}"
unzip -l "$OUT"
