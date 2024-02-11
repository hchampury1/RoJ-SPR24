## Installation and Usage Instruction for Pro-Bono Module

### Installation Instructions

In the VM (assuming that you have been given the TEAM account already for CSC 415), you need to run the following shell script:

```
./installruby.sh
```

After running the script, ensure that the ruby version number is at least 2.0.0, and that the rails command is recoginized:

```
ruby -v
rails  -v
```

Cloning the project’s repository requires SSH installation through GitHub. Once the SSH key has been setup cloning the repo is as follows:
* On the GitHub website, on your repository page, select the "Code" dropdown at the top of the page. Make sure to select "SSH" and not "HTTPS". Click the little clipboard to the right of the provided url to copy it.

* Now, return to your terminal and enter the following command: git clone <copied url> (exclude the '<' and '>')

* If you are told that the authenticity of the host 'github.com' can't be established, and asked if you want to continue connecting, enter "yes".

* You'll be prompted to enter the passphrase you made earlier for your SSH key. After you enter that, the repository will be cloned to your VM.

After cloning the repository into your local VM, navigate to the <repo_name>/src/ folder. Run the following commands:

```
bundle  install
yarn install
```

If there are any errors, it is likely that there is something wrong with the PSQL installation tied to PostgresSQL. Attempt to run the following command:

```
sudo yum install postgresql-libs postgresql-devel
```

Once the bundle and yarn installation is complete, you will need to create and migrate the Database into your Rails application:

```
rake db:create
rake db:migrate:reset
rake db:migrate
rake db:seed
```
Before running the application through the VM localhost, you need to add your host (the TEAM account provided by you in the CSC 415 class) in the development.rb file:

* Navigate to src/config/environments/development.rb
* It is likely that you already have VSCode installed, so you can edit this file directly in its text editor.

Add the following line of code, replacing XX with your team’s number provided:

```
config.hosts << "csc415-team12.hpc.tcnj.edu"
```

Save the following file and type “logout” in the terminal session. In order to see the changes made to the newly added host, you need to log back in via SSH or re-open the remote session.

For running the application, you need to find your VM’s ip address by running the following command:

```
ip  addr show eth0
```

Navigate to the src folder and run the server by running:

```
rails s (or rails server) --binding xxx.xxx.xxx.xxx
```

where the X’s are your IP address.

Alternatively, after you follow the document on how to enable multiple port numbers for your team, you can run the following command

```
rails server --binding=xxx.xxx.xxx.xxx -p <port number>
```

### Usage Instructions
* In the Rails of Justice website, navigate to the login page and give the correct credentials. 
* After logging in, navigate to the “View/Search Hours” page under “Pro-Bono Work”

* For Filtering:
    * Click on the desired dropdown range(s) and click on the apply filter button 
    * To clear the filters, click on the clear sort and filters button

* For Sorting:
    * Click on the column name to sort the row in ascending or descending order
    * Clicking on the column name for the first time will sort the data in ascending order and clicking on the column name the next time will sort the data in descending order
    * To clear sorting, click on the clear sort and filters button

* To View the Statistics Page:
    * Navigate to “View Statistics” under “Pro-Bono Work"


 
