## CentOS 7.X
yum install -y xinetd tftp-server httpd nfs-utils samba
systemctl enable xinetd.service
systemctl enable tftp.service
sed -i '/disable/s/yes/no/' /etc/xinetd.d/tftp
# update line in /etc/xinetd.d/tftp to below:
# server_args		= -m /tftpboot/erpxe.remap -vvvvv -s /tftpboot
systemctl enable httpd.service
sudo cp /tftpboot/bin/setup/erpxe-httpd.conf /etc/httpd/conf.d/
systemctl enable nfs.service
cat /tftpboot/bin/setup/erpxe-exports |sudo tee -a /etc/exports
systemctl enable smb.service
