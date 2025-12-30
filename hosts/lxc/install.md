1. Upload Proxmot CT template https://hydra.nixos.org/job/nixos/release-25.11/nixos.proxmoxLXC.x86_64-linux

2. Create LXC

```sh
CTID=103
SSH_KEY="$(curl https://github.com/mechanicalbot.keys)"

pct create $CTID local:vztmpl/nixos-image-lxc-proxmox-25.11pre-git-x86_64-linux.tar.xz \
  --hostname nix-lxc \
  --rootfs local-lvm:8 \
  --cores 2 --memory 4096 --swap 0 \
  --ostype nixos --arch amd64 \
  --net0 name=eth0,bridge=vmbr0,ip=dhcp \
  --unprivileged 0 \
  --features nesting=1 \
  --start

sleep 5

pct exec $CTID -- /run/current-system/sw/bin/sh -c "echo $SSH_KEY >> /root/.ssh/authorized_keys"
```

3. Add host to `flake.nix`

4. Run `deploy`
