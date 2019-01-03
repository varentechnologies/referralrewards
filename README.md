# Varen Technologies: Project Lead the Way

This web application is to be used for recruiters and employees to promote referring leads and potential candidates to 
be recruited for Varen Technologies.

## Development

Before you can build this project, you must install and configure the following dependencies on your machine:

1. [Java 10](http://www.oracle.com/technetwork/java/javase/downloads/jdk10-downloads-4416644.html) We use Java to run a development web server and build the project. Depending on your system, you can
    install Java either from source, or as a pre-packaged bundle. 
2. [MySQL](https://www.mysql.com/downloads/) We use MySQL to manage our database.
3. [Maven](https://maven.apache.org/download.cgi) We use Maven alongside Spring Boot to manage our project
4. [Gitlab](https://www.linux.com/blog/lets-git-it-installing-git-centos) Make an SSH key to use our Gitlab project

With MySQL running on the localhost with the default port, MySQL should have
* username: root
* password: varenpassword

if this is not the case for your MYSQL server, please change your connection in the `application.properties` file.

#Installing in Linux
From CentOS 7 Terminal:
1. Install and configure Git with your user and password. git config
2. change directories to where you want your git project to go. Ex. cd /home/username/Workspace
3. Clone into your directory. git clone -b 'branchname' ssh://git@www.varentech-gitlab.com/internship2018/referralrewards.git
4. Open the project directory. cd /home/username/Workspace/referralrewards
5. Create your repository. git init
6. Install application. mvn clean install

Building Project:
1. Install project 
2. Run Application. ./mvnw spring-boot:run
* for port errors: make sure port 8080 does not have anything running in it & check that git is not running in the master branch


**Authentication Updates**

The project is now configured with **Active Directory** support to authenticate with Varen credentials. The authentication process can be toggled between using
Varen's Active Directory database and the application's local database.

In the "application.properties" file under /src/main/resources use the following properties to specify the authentication method

`authentication.mode = active_directory` 

`authentication.mode = default` 

**IMPORTANT**: Active Directory does not have a public IP address and can only be accessed by machines on Varen's local network. 
Active Directory authentication will not work if the application is running on a machine outside of Varen.

## Contributing
If you are interested in fixing issues and contributing directly to the code base, 
please see the document [How to Contribute](54.156.214.150/internship2018/referralrewards/wiki/How-to-Contribute), which
covers the following:

* [How to build and run from source](54.156.214.150/internship2018/referralrewards/wiki/How-to-Contribute#build-and-run-from-source)
* [The development workflow, including debugging and running tests](54.156.214.150/internship2018/referralrewards/wiki/How-to-Contribute#development-workflow)
* [Coding Guidelines](54.156.214.150/internship2018/referralrewards/wiki/Coding-Guidelines)
* [Submitting pull requests](54.156.214.150/internship2018/referralrewards/wiki/How-to-Contribute#pull-requests)