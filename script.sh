#ARCH="$(uname -m)"
#release_url="https://github.com/firecracker-microvm/firecracker/releases"
#latest=$(basename $(curl -fsSLI -o /dev/null -w  %{url_effective} ${release_url}/latest))
#curl -L ${release_url}/download/${latest}/firecracker-${latest}-${ARCH}.tgz | tar -xz
#mv release-v1.10.1-x86_64/firecracker-v1.10.1-x86_64 firecracker
#curl -fsSL -o hello-rootfs.ext4 https://s3.amazonaws.com/spec.ccfc.min/img/hello/fsfiles/hello-rootfs.ext4
#curl -fsSL -o hello-vmlinux.bin https://s3.amazonaws.com/spec.ccfc.min/img/hello/kernel/hello-vmlinux.bin
#sudo ./firecracker --api-sock $(pwd)/firecracker.socket --config-file vmconfig.json
sudo curl --unix-socket $(pwd)/firecracker.socket -i \
    -X PATCH 'http://localhost/vm' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
            "state": "Paused"
    }'
sudo curl --unix-socket $(pwd)/firecracker.socket -i \
    -X PUT 'http://localhost/snapshot/create' \
    -H  'Accept: application/json' \
    -H  'Content-Type: application/json' \
    -d '{
            "snapshot_type": "Full",
            "snapshot_path": "./snapshot_file",
            "mem_file_path": "./mem_file"
    }'
# kill that instance and start a new one fresh, with nothing no kernel etc.
# sudo ./firecracker $(pwd)/firecracker.socket
# then resume it from the snapshots... I did not manage to create a json config that does
# this for some reason
sudo curl --unix-socket $(pwd)/firecracker.socket -i -X PUT http://localhost/snapshot/load -H Accept: application/json -H Content-Type: application/json -d {
            "snapshot_path": "./snapshot_file",
            "mem_backend": {
                "backend_path": "./mem_file",
                "backend_type": "File"
            },
            "enable_diff_snapshots": true,
            "resume_vm": true
    }
