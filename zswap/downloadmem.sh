# Check current parameters
grep -r . /sys/module/zswap/parameters/
# enbale the service
systemctl daemon-reload
systemctl enable zswap-config.service
# Check stats
sudo grep -r . /sys/kernel/debug/zswap/
