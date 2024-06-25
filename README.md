# MySQL Database Backup Application
This repository contains a batch script (DBbackup.bat) for taking backups of MySQL databases. This script allows you to automate the backup process and receive notifications upon successful completion.

# How to Use
Follow these steps to set up and run the backup script:

# Step 1: Clone the Repository
Clone this repository to your local machine using the following command:
git clone https://github.com/yourusername/mysql-backup-script.git

# Step 2: Set the System Environment Variable
Set the system environment variable for the MySQL bin folder with the variable name as PATH. This allows the script to access MySQL commands from any directory.

# Step 3: Run the DBbackup.bat File
Run the DBbackup.bat file as an administrator. This is necessary to ensure the script has the required permissions to execute.

# Step 4: Input the Desired Time for the Backup
When prompted, input the desired time for the database backup. The script will schedule the backup to run at the specified time.

# Step 5: Minimize the Command Terminal
Minimize the command terminal. You will receive a notification after the database backup is successful.
