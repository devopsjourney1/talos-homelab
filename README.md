# Talos Setup

https://www.talos.dev/v1.10/introduction/getting-started/


Replace IP's with the ones in your homelab.
```
# Generate configs
talosctl gen config devopslab https://192.168.1.87:6443/

# Config control plane nodes
talosctl apply-config --insecure -n 192.168.1.87 --file controlplane.yaml

# First control  plane node bootstrap
talosctl bootstrap --nodes 192.168.1.87 --endpoints 192.168.1.87 \
  --talosconfig=./talosconfig


# Generate kubectl config
talosctl kubeconfig --nodes 192.168.1.87 --endpoints 192.168.1.87 \
  --talosconfig=./talosconfig


# Check health
talosctl --nodes 192.168.1.87 --endpoints 192.168.1.87 health \
   --talosconfig=./talosconfig
   
talosctl --nodes 192.168.1.87 --endpoints 192.168.1.87 dashboard \
   --talosconfig=./talosconfig


# Add worker node

talosctl gen config devopslab https://192.168.1.88:6443/

```

# List running processes on a node
talosctl ps -n 192.168.1.88 --endpoints 192.168.1.88
talosctl netstat -n 192.168.1.88 --endpoints 192.168.1.88


