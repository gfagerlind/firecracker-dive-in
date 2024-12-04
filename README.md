# What is firecracker 
An alternative vmm - very bare bones and featureless,
for example any sharing of filesystems between host and vm is out of the picture
(eg. virtiofs).

You can start snapshots quickly, which i guess is cool.

Uses KVM, is an alternative to QEMU

[Neato internal write up](https://www.talhoffman.com/2021/07/18/firecracker-internals/)

>__*NOTE:*__ snapshot.json does not work - unclear how to get it to work
