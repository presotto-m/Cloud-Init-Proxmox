!#/bin/bash

# Download da imagem (Sua escolha) 
wget https://cdimage.debian.org/cdimage/cloud/bullseye/20221219-1234/debian-11-genericcloud-amd64-20221219-1234.qcow2

# Crie uma nova VM com o controlador VirtIO SCSI
qm create 200 --name debian11-cloudinit --net0 virtio,bridge=vmbr2

# Importe o disco baixado para o armazenamento local-lvm, anexando-o como uma unidade SCSI
qm importdisk 200 ebian-11-genericcloud-amd64-20221219-1234.qcow2 local-lvm
qm set 200 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-900-disk-0
qm set 200 --ide2 local-lvm:cloudinit
qm set 200 --boot c --bootdisk scsi0
qm set 200 --serial0 socket --vga serial0
qm template 200
