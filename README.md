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


[View The Website Live Here!](http://52.91.240.2:8080/Stack/#/home)

#### Final Team Project undertaken as members of Skill Distillery

### Overview
The Stack is a social platform designed for programmers to find local meet up events anywhere in the US. 

### Description
As a user on The Stack you can search for and view groups in your area, and view events that are within public groups. By logging in or signing up you can view private events for groups you are in, and create groups or events.

### Implementation

#### Our Database Design
![Our Database schema](https://github.com/Jakersnell/TheStack/blob/main/Resources/Images/stackdiagram.png?raw=true)


### Technologies and Methodologies Used
Our stack is a SQL, Java, JPA, Spring BOOT, Angular stack, we believe this stack is effective due to its practical scalability and real world use. These technologies enabled us to achieve a product we are proud of.
<br>
During planning our team used great tools like [eraser.io](https://app.eraser.io), [figma](https://www.figma.com), and [trello](https://trello.com) to create a comprehensive design that we could have thoroughly flushed out before implementation, so that our implementation would hold minimal suprises. 
<br>
Our team focused heavily on integrating a agile workflow into our process. We wanted to mimic a production environment as much as we could. We started each day with a scrum meeting, we then went through our trello task board and assigned tasks to. To work on tasks we used a 50/50 combination of side-by-side work, and pair programming. 
<br>
We embraced git branching and used a branch model inspired by git flow. We used our main branch as our development branch, and we used github rules to implement rules that required approvals from other collaborators before a pull request could be merged. Our workflow enabled us to work efficiently and effectively. 
<br>

Languages: Java <br>
Web: HTML, CSS, Bootstrap 5.3, Angular, NgBootstrap, JavaScript <br>
Database: SQL, Spring Data, JPA, JDBC, JPQL, Hibernate <br>
Methodologies: TDD, Agile, Scrum  <br>
Backend: Spring, Spring Boot <br>
Configuration Management: Git <br>
IDE: STS4, Eclipse, VSCode <br>

### Lessons Learned
We learned a lot about effective team management, leveraging your teams strengths and weaknesses as an asset. We also learned much about the design process in software development, we found a lot of benefit in a cycle that consisted of planning, working, and integrating what we had learned. We also learned a lot of very cool new methods to achieve certain technical aspects, such as how to use the google api systems. 


### Stretch Goals
1. User messaging 
2. User friendships
3. Notifications

### How to Download and Run

To set up this project to run on your own computer follow the steps below.

 1. Download the project at the top of this project.
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
        * Click on the globe after it's up and check out the site!

Otherwise just head to the deployed website above.

Thanks for visiting!
    - The Stack Team

