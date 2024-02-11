## Instructions to Set Up the VM to Test PayPal Integration

Sysadmin

1. Log in into your individual/team server via SSH to the sysadmin account
    1. ssh sysadmin@csc415-team12.hpc.tcnj.edu
2. Install Ruby on Rails by typing the following command:
    1. ./installruby.sh
3. Obtain individual/team server IP address by entering the following command:
    1. ip addr show eth0
4. Use the IP address to start the rails server by entering the following command in the terminal:
    1. rails server --binding=your_server_IP
    2. Replace your_server_IP with the individual/team server IP address 
5. To navigate to the application, enter the following command:
    1. http://csc415-team12.hpc.tcnj.edu:3000/

Note: Use sysadmin to install software needed for the server

Team Server
1. Activate the team account by typing the following command in the terminal:
    1. Sudo passwd team
    2. Use the command provided above to unlock the team account by creating a password
    3. Note: Create password from the sysadmin account


## Generate SSH Key
1. Connect to VM and then open the terminal
2. Enter the following command in the command line:
    1. ssh-keygen -t ed25519 -C "your_email@example.com"
    2. Replace ‘your_email@example.com’ with a valid email
3. Next you will be prompted to enter a passphrase
4. Finally, ssh key gets generated


## Add SSH key to the ssh agent
1. Type the following command to start the ssh agent:
    1. eval "$(ssh-agent -s)"
2. Enter the following command to add SSH key to the agent
    1. ssh-add ~/.ssh/id_ed25519


## Add the new SSH key to GitHub account

1. Enter the following command in the terminal to get the SSH key
    1. cat ~/.ssh/id_ed25519.pub
2. Navigate to GitHub and click on account settings 
3. Navigate to ‘SSH and GPG keys’ and paste SSH key 

## SSH and VS Code
1. Download Visual Studio Code
2. Install Remote - SSH VS Code extension available at:
3. Click >< icon and select “Connect to Host”
    1. Then, enter the team VM information: ssh team@csc415-team12.hpc.tcnj.edu
4. Then select a configuration file from the dropdown to add team host to the file
5. Enter the password for the team account to connect to SSH

