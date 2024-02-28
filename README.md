<h2 align="center">
    <a href="#" target="blank_">
        <img height="100" alt="Stack Logo" src=https://github.com/Parrisu/FinalProject/blob/main/Resources/Images/stackicon.png/>
    </a>
    <br>
    The Stack: Push. Pop. Progress.
</h2>

<div align="center">
    
![Static Badge](https://img.shields.io/badge/Max-DBA-blue?link=https%3A%2F%2Fgithub.com%2Fmaxwelltremaine)
![Static Badge](https://img.shields.io/badge/Jake-SCRUM-orange?link=https%3A%2F%2Fgithub.com%2FJakersnell)
![Static Badge](https://img.shields.io/badge/Parris-Repo_Owner-green?link=https%3A%2F%2Fgithub.com%2FParrisu)

</div>


[View The Website Live Here!](http://13.56.117.221:8080/Stack/#/home)

#### Final Team Project undertaken as members of Skill Distillery

### Overview
The Stack is a social platform designed for programmers to find local meet up events anywhere in the US. 

### Description
As a user on The Stack you can search for and view groups in your area, and view events that are within public groups. By logging in or signing up you can view private events for groups you are in, and create groups or events.

### Implementation

#### Our Database Design
![Our Database schema](https://github.com/Jakersnell/TheStack/blob/main/Resources/Images/stackdiagram.png?raw=true)


### Technologies and Methodologies Used
Our stack is a SQL, Java, JPA, Spring BOOT, Angular stack due to its practical scalability and real world use. These technologies enabled us to achieve a product we are proud of.<br><br>
During planning our team used essential tools like [eraser.io](https://app.eraser.io), [figma](https://www.figma.com), and [trello](https://trello.com) to create a comprehensive design before implementation. Measure twice, and cut once.<br><br>
Our team focused heavily on integrating a agile workflow into our process. We wanted to mimic a production environment as much as we could. We started each day with a scrum meeting, we then went through our trello task board and assigned tasks to. To work on tasks we used a 50/50 combination of side-by-side work, and pair programming. <br><br>
We embraced git branching and used a branch model inspired by git flow. We used our main branch as our development branch along with github rules to restrict updates to require approvals. Our workflow enabled us to work efficiently and effectively. <br>[Check out the network graph here!](https://github.com/Parrisu/TheStack/network)<br><br>

Languages: Java <br>
Web: HTML, CSS, Bootstrap 5.3, Angular, NgBootstrap, JavaScript <br>
Database: SQL, Spring Data, JPA, JDBC, JPQL, Hibernate <br>
Methodologies: TDD, Agile, Scrum  <br>
Backend: Spring, Spring Boot <br>
Configuration Management: Git <br>
IDE: STS4, Eclipse, VSCode <br>

### Lessons Learned
* Branching requires all members to be aware of other's current workload. Conflicts can happen fast and suddenly.
* Designing can make or break your entire application/idea. Concepts need to be fully drawn out before starting production.
* Using external APIs like google require API keys. This made us branch out and find that multiple websites like Linkedin and Meta have developer sections where you can gain access to API keys.


### Stretch Goals
1. User messaging 
2. User friendships
3. Notifications

### How to Download and Run

To set up this project to run on your own computer follow the steps below.

 1. Download the ZIP at the top of this page under the code dropdown menu.
 2. Import the project.
        * Open your preferred IDE, and open an existing or new workspace.
        * Right click inside of your project explorer, click import, then `existing project into workspace`.
 3. Install the DB.
        * Open terminal.
        * Navigate to your workspace that contains the db folder. 
            ex.
            
            ```
            cd ~/SD41/Java/FinalProject/DB
            ```
    
    * Once here, run the command

            ```
            mysql -u root -p < stackdb.sql

            root
            ```
       
5. Make sure MAMP is running on port 3306, and launch from the Spring `Boot Dashboard`.
6. Serve Angular
   * Open a new terminal tab.
   * Nagivate to ngStack
            ex.
            
            ```
            cd ~/SD41/Java/FinalProject/ngStack
            ```
   * Once here, run the command
  
            ```
            ng serve

            ```
7. Open your browser to localhost:4200


Otherwise just head to the deployed website [here](http://13.56.117.221:8080/Stack/#/home).

Thanks for visiting!
    - The Stack Team

