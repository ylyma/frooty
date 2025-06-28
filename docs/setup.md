## packages
incus

incus is a fork of lxd
for ansible to find the command lxc:
`ln -s /usr/bin/incus /usr/local/bin/lxc`


## moose

my music server

`lxc launch images:alpine/edge/arm64 moose`
`lxc exec moose -- apk add python3`
