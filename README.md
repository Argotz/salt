Following the directions at https://www.timothygruber.com/linux/saltstack-installation-configuration/ to get the saltstack infrastructure set to look at github.  

Change directory to:
cd /etc/salt/master.d
Generate an SSH key:
sudo ssh-keygen -t rsa -b 4096 -C "SaltStack Git"
Enter the path and file name:
/etc/salt/master.d/ssh-git-ro
Hit enter twice to skip passphrase.
Change the name of the private key to make both keys easily identifyable:
sudo mv /etc/salt/master.d/ssh-git-ro /etc/salt/master.d/ssh-git-ro.priv
Now if you type ls -lash you should see both of the following SSH keys:
ssh-git-ro.priv
ssh-git-ro.pub
Copy the public key so you can paste it into Github:
cat ssh-git-ro.pub
In Github, click Settings > SSH Keys
Paste the public key into the text area.
Give it a title, then click Add key.  Write access is not needed if the option is available.
Configure the Salt-Master to use this new SSH Key to connect to the GitLab repo:
Create an SSH config file in roots home:
vi /root/.ssh/config
Type and save the following into /root/.ssh/config 

Host github.com
    Hostname github.com
    User git
    StrictHostKeyChecking no
    IdentityFile /etc/salt/master.d/ssh-git-ro.priv
    IdentitiesOnly yes
Connect to Github.com via SSH:
ssh github.com
Enter yes when prompted to save Github’s key to known hosts.  If you get an error connecting, which you most likely will, it doesn’t matter.
For the GitFS backend to work, the fileserver config file needs to be configured appropriately, done in the next step.

Create Config File
Create and save the following text exactly (paying careful attention to spacing), as it follows yaml formatting.
vi /etc/salt/master.d/custom.conf

Save the below text in the custom.conf configuration file above:
YAML19 lines

/etc/salt/master.d/custom.conf
Note that in the above custom.conf, under gitfs_remotes, you get that git@github.com:username/salt.git from your GitLab repository SSH link.
Restart Salt-Master Service
Because we changed the configuration, the salt-master service needs to be restarted:
sudo salt-master restart

Testing Github Integration
Run the following command to verify what you have in your Github repository shows up:
sudo salt-run fileserver.file_list

yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm  
yum install -y salt-master  
yum install -y salt-minion  
yum install -y salt-ssh  
yum install -y salt-api  
yum install -y salt-cloud
