#!/bin/bash
set -e

echo "=== SSR Debian 11 安装脚本（systemd 版） ==="

# 1. root 检查
if [ "$(id -u)" != "0" ]; then
  echo "请使用 root 运行该脚本"
  exit 1
fi

# 2. 系统检查
. /etc/os-release
if [ "$ID" != "debian" ] || [ "$VERSION_ID" != "11" ]; then
  echo "本脚本仅支持 Debian 11"
  exit 1
fi

# 3. 安装依赖
echo "[*] 安装基础依赖..."
apt update
apt install -y python2 git ufw

# 4. 确保 python -> python2
if ! command -v python >/dev/null 2>&1; then
  ln -s /usr/bin/python2 /usr/bin/python
fi

python --version

# 5. 安装目录
SSR_DIR="/opt/shadowsocksr"

if [ -d "$SSR_DIR" ]; then
  echo "[!] $SSR_DIR 已存在，跳过 clone"
else
  echo "[*] 从你的备份仓库拉取 SSR 代码..."
  git clone https://github.com/GarrodRan-vdao/ssr-archive.git /opt/ssr-archive
  mv /opt/ssr-archive/shadowsocksr "$SSR_DIR"
fi

# 6. 创建 systemd 服务
echo "[*] 安装 systemd 服务..."

cat > /etc/systemd/system/ssr.service <<'EOF'
[Unit]
Description=ShadowsocksR Server (archive)
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python2 /opt/shadowsocksr/shadowsocks/server.py -c /opt/shadowsocksr/user-config.json
WorkingDirectory=/opt/shadowsocksr
Restart=always
RestartSec=3
LimitNOFILE=51200

[Install]
WantedBy=multi-user.target
EOF

# 7. 启用但不启动
systemctl daemon-reload
systemctl enable ssr

echo ""
echo "=== 安装完成 ==="
echo ""
echo "下一步你需要做："
echo "1. 编辑配置文件："
echo "   /opt/shadowsocksr/user-config.json"
echo ""
echo "2. 启动服务："
echo "   systemctl start ssr"
echo ""
echo "3. 查看状态："
echo "   systemctl status ssr"
echo ""
echo "注意："
echo "- 不要使用 logrun.sh"
echo "- 不要使用 rc.local"
echo "- systemd 将负责进程守护"
echo ""