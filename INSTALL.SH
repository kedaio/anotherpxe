## CentOS 7.X
yum install -y xinetd tftp-server httpd nfs-utils samba dhcp
systemctl enable xinetd.service
systemctl enable tftp.socket
systemctl enable tftp.service
sed -i '/disable/s/yes/no/' /etc/xinetd.d/tftp
# update line in /etc/xinetd.d/tftp to below:
# server_args		= -m /tftpboot/erpxe.remap -vvvvv -s /tftpboot
systemctl enable httpd.service
sudo cp /tftpboot/bin/setup/erpxe-httpd.conf /etc/httpd/conf.d/
systemctl enable nfs.service
cat /tftpboot/bin/setup/erpxe-exports |sudo tee -a /etc/exports
systemctl enable smb.service

## this will overwrite existing smb.conf
cat /tftpboot/bin/setup/erpxe-smb.conf |sudo tee /etc/samba/smb.conf
sudo useradd --no-create-home -s /dev/null erpxe

## add samba user 
(echo erpxe;echo erpxe) | sudo smbpasswd -s -a erpxe
(echo root;echo root) | sudo smbpasswd -s -a root

## set security context for SELinux
sudo restorecon -r /tftpboot

sudo systemctl enable dhcpd.service
