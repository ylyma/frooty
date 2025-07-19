## packages
ansible
wireguard
vim
incus

incus is a fork of lxd
for ansible to find the command lxc:
`ln -s /usr/bin/incus /usr/local/bin/lxc`

- [ ] TODO: automate setting this up too?

## music server
- currently mounts `~/music` to `/music`
    - [ ] TODO: use usb stick for storage instead
- requires creation of local directories: `/srv/navidrome` with ownership to 999:999 and permissions to 755
    - [ ] TODO: automate this

## monitoring


