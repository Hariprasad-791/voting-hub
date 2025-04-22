
# Voting Hub

## Project Overview

The **Online Voting System** is a project designed to streamline the voting process. It simplifies the workflow for users by providing an intuitive and secure platform for voting. The system is developed using Java, JavaScript, JSP, MySQL, the Apache Tomcat server, and follows the MVC design pattern.

---

## Features

1. **Detailed Instructions**: A guide for new voters.
2. **Voter Login and Signup**: Secure login and registration functionality.
3. **Voter Dashboard**: User-specific dashboard for easy navigation.
4. **Voting Page**: User-friendly interface for casting votes.
5. **Admin Login**: Secure access to view and manage results.

---

## Project Setup

### Step 1: Clone the Repository

1. Clone the repository:
   ```bash
   git clone https://github.com/Hariprasad-791/voting-hub.git
   ```
2. Import the project into Eclipse:
   - Open Eclipse and navigate to:
     ```
     File > Import > Web > WAR file
     ```
   - Select the `votinghub.war` file.

---

### Step 2: Set Up the Database and Apache Tomcat Server

1. Open MySQL Workbench or any MySQL client.
2. Run the `init.sql` file to set up the database schema:
3. Configure the Apache Tomcat server in Eclipse:
   - Go to:
     ```
     Window > Preferences > Server > Runtime Environments
     ```
   - Add the Apache Tomcat server (if not already configured).
   - Set the server's runtime environment.

---

### Step 3: Access the Application

1. Start the Apache Tomcat server in Eclipse.
2. Open a browser and navigate to:
   ```
   http://localhost:8080/votinghub/instruct.jsp
   ```

---

## Technologies Used

- **Frontend**: JSP, HTML, CSS
- **Backend**: Java (Servlets, JSP)
- **Design Pattern**: MVC (Model-View-Controller)
- **Database**: MySQL
- **Server**: Apache Tomcat
- **IDE**: Eclipse
