# Check whether or not Samba Server & Client packages are installed on your system

# systemctl enable smmbd.service
# systemctl start smbd.service
# systemctl enable nmbd.service
# 
# systemctl start nmbd.service 
# If above cmds give error message then the required packages are not installed
# 
# Install those packages with
# dnf install smbd*
# dnf install nmbd*
# 
# Now try to start both the services with above 4 cmds of systemctl
# Once the services are running, start creating users, groups, shared directories with,
# 
# mkdir /Accounts
# mkdir /Finance
# mkdir /HRD
# mkdir /Public
# mkdir /Dropbox
#
# adduser john
# passwd john
# adduser anjali
# passwd anjali
# adduser rahul
# passwd rahul
# adduser richa
# passwd richa
#
# groupadd accounts
# groupadd finance
# groupadd hrd
#
# usermod -aG accounts john
# usermod -aG accounts richa
#
# usermod -aG finance rahul
# usermod -aG finance anjali
#
# usermod -aG hrd richa
# usermod -aG hrd anjali
#
# Now check whether or not all this is created with,
#
# getent group finance
# getent group accounts
# getent group hrd
#
# Create a couple of files in each of the made dirs,
#
# cd /Accounts
# touch a1 a2
#
# cd /Finance
# touch fin1 fin2
#
# cd /HRD
# touch h1 h2
# 
# Now change dir permission & group of all 3 created dirs with,
#
# chmod 775 /Accounts
# chmod 775 /Finance
# chmod 775 /HRD
#
# chown root:accounts /Accounts
# chown root:finance /Finance
# chown root:hrd /HRD
#
# Now make all the newly created Valid Linux Users(VLUs) to samba users with passwords 
#
# smbpasswd -a john
# smbpasswd -a richa
# smbpasswd -a rahul
# smbpasswd -a anjali
#
# (Try to keep all of their passwords same as their names just add 's' at each of the end)
#
# Add the samba service to firewall with,
#
# firewall-cmd --permanent --add-service=samba
#
# Now add these shared dirs to SELinux for smoooth file handling between Samba Server (Linux) & Samba Client(Windows)
#
# chcon -R -t samba_share_t /Accounts
# chcon -R -t samba_share_t /Finance
# chcon -R -t samba_share_t /HRD
# chcon -R -t samba_share_t /Public
# chcon -R -t samba_share_t /Dropbox
# 
# Now reload all the services with,
#
# firewall-cmd --reload
# systemctl restart smbd.service
# systemctl restart nmbd.service
# systemctl restart NetworkManager.service
#
# Check on Windows client in File Explorer Under the Networks you'll be able to see your own computer as well as Samba Server machine name, 
# just click on the server machine name you'll be aked for username & password enter the samba created username & password. Finally, you're inside the samba server.
# 
