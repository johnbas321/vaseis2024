Semester project for the 2024 DB course.
School of Electrical and Computer Engineering, NTUA

## Build Instructions

### MariaDB Service
1. Download and install [MariaDB Server](https://mariadb.org/download/?t=mariadb&p=mariadb&r=11.1.0)
2. Start the server:
	```shell
	$ sudo service mysqld start
	```
3. Create a schema in MariaDB:
	```shell
	$ mysql -u root -p
    > create database cook
	```
4. Run all the scripts in the scripts file on your shell:
	```shell
	$ mariadb -u root -p cook < script.sql

 5. Run the python script on the python folder
