-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema stackdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `stackdb` ;

-- -----------------------------------------------------
-- Schema stackdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `stackdb` DEFAULT CHARACTER SET utf8 ;
USE `stackdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(300) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `state_abbreviation` VARCHAR(45) NULL,
  `city` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NULL,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `created_on` DATETIME NULL,
  `updated_on` DATETIME NULL,
  `role` VARCHAR(45) NOT NULL,
  `about_me` TEXT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `profile_image_url` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_profile_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_user_profile_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `technology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `technology` ;

CREATE TABLE IF NOT EXISTS `technology` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `badge_url` VARCHAR(2000) NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_technology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_technology` ;

CREATE TABLE IF NOT EXISTS `user_technology` (
  `user_id` INT NOT NULL,
  `technology_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `technology_id`),
  INDEX `fk_user_profile_has_technology_technology1_idx` (`technology_id` ASC),
  INDEX `fk_user_profile_has_technology_user_profile1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_profile_has_technology_user_profile1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_profile_has_technology_technology1`
    FOREIGN KEY (`technology_id`)
    REFERENCES `technology` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `profile_link`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profile_link` ;

CREATE TABLE IF NOT EXISTS `profile_link` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(2000) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_profile_link_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_profile_link_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `node`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `node` ;

CREATE TABLE IF NOT EXISTS `node` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `user_id` INT NOT NULL,
  `open_to_public` TINYINT NOT NULL,
  `created_on` DATETIME NOT NULL,
  `updated_on` DATETIME NOT NULL,
  `state_abbreviation` VARCHAR(50) NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `enabled` TINYINT NOT NULL,
  `city` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sub_stack_user_profile1_idx` (`user_id` ASC),
  CONSTRAINT `fk_sub_stack_user_profile1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `function`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `function` ;

CREATE TABLE IF NOT EXISTS `function` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  `address_id` INT NOT NULL,
  `node_id` INT NOT NULL,
  `cancelled` TINYINT NOT NULL,
  `enabled` TINYINT NOT NULL,
  `function_date` DATE NOT NULL,
  `description` TEXT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `created_on` DATETIME NULL,
  `updated_on` DATETIME NULL,
  `created_by` INT NOT NULL,
  `max_attendees` INT NOT NULL,
  `image_url` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_function_address1_idx` (`address_id` ASC),
  INDEX `fk_function_node1_idx` (`node_id` ASC),
  INDEX `fk_function_user1_idx` (`created_by` ASC),
  CONSTRAINT `fk_function_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_function_node1`
    FOREIGN KEY (`node_id`)
    REFERENCES `node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_function_user1`
    FOREIGN KEY (`created_by`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `node_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `node_role` ;

CREATE TABLE IF NOT EXISTS `node_role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `node_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `node_member` ;

CREATE TABLE IF NOT EXISTS `node_member` (
  `node_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `approved` TINYINT NOT NULL,
  `date_joined` DATETIME NULL,
  `node_role_id` INT NOT NULL,
  PRIMARY KEY (`node_id`, `user_id`),
  INDEX `fk_sub_stack_has_user_profile_user_profile1_idx` (`user_id` ASC),
  INDEX `fk_sub_stack_has_user_profile_sub_stack1_idx` (`node_id` ASC),
  INDEX `fk_node_member_node_role1_idx` (`node_role_id` ASC),
  CONSTRAINT `fk_sub_stack_has_user_profile_sub_stack1`
    FOREIGN KEY (`node_id`)
    REFERENCES `node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sub_stack_has_user_profile_user_profile1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_node_member_node_role1`
    FOREIGN KEY (`node_role_id`)
    REFERENCES `node_role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `node_technology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `node_technology` ;

CREATE TABLE IF NOT EXISTS `node_technology` (
  `node_id` INT NOT NULL,
  `technology_id` INT NOT NULL,
  PRIMARY KEY (`node_id`, `technology_id`),
  INDEX `fk_node_has_tech_tech1_idx` (`technology_id` ASC),
  INDEX `fk_node_has_tech_node1_idx` (`node_id` ASC),
  CONSTRAINT `fk_node_has_tech_node1`
    FOREIGN KEY (`node_id`)
    REFERENCES `node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_node_has_tech_tech1`
    FOREIGN KEY (`technology_id`)
    REFERENCES `technology` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  `body` TEXT NOT NULL,
  `created_on` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user1_idx` (`sender_id` ASC),
  INDEX `fk_message_user2_idx` (`receiver_id` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `notification` ;

CREATE TABLE IF NOT EXISTS `notification` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(255) NULL,
  `enabled` TINYINT NOT NULL,
  `type` VARCHAR(55) NULL,
  `created_on` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_notification` ;

CREATE TABLE IF NOT EXISTS `user_notification` (
  `user_id` INT NOT NULL,
  `notification_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `notification_id`),
  INDEX `fk_user_has_notification_notification1_idx` (`notification_id` ASC),
  INDEX `fk_user_has_notification_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_notification_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_notification_notification1`
    FOREIGN KEY (`notification_id`)
    REFERENCES `notification` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `function_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `function_comment` ;

CREATE TABLE IF NOT EXISTS `function_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `function_id` INT NOT NULL,
  `content` TEXT NULL,
  `created_on` DATETIME NULL,
  `user_id` INT NOT NULL,
  `reply_to_comment_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_function_comments_function1_idx` (`function_id` ASC),
  INDEX `fk_function_comments_user1_idx` (`user_id` ASC),
  INDEX `fk_function_comment_function_comment1_idx` (`reply_to_comment_id` ASC),
  CONSTRAINT `fk_function_comments_function1`
    FOREIGN KEY (`function_id`)
    REFERENCES `function` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_function_comments_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_function_comment_function_comment1`
    FOREIGN KEY (`reply_to_comment_id`)
    REFERENCES `function_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attendee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attendee` ;

CREATE TABLE IF NOT EXISTS `attendee` (
  `function_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`function_id`, `user_id`),
  INDEX `fk_function_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_function_has_user_function1_idx` (`function_id` ASC),
  CONSTRAINT `fk_function_has_user_function1`
    FOREIGN KEY (`function_id`)
    REFERENCES `function` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_function_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `node_resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `node_resource` ;

CREATE TABLE IF NOT EXISTS `node_resource` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(2000) NULL,
  `title` VARCHAR(200) NULL,
  `created_on` DATETIME NULL,
  `updated_on` DATETIME NULL,
  `node_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_node_resource_node1_idx` (`node_id` ASC),
  CONSTRAINT `fk_node_resource_node1`
    FOREIGN KEY (`node_id`)
    REFERENCES `node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `function_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `function_image` ;

CREATE TABLE IF NOT EXISTS `function_image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(2000) NULL,
  `function_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_function_image_function1_idx` (`function_id` ASC),
  CONSTRAINT `fk_function_image_function1`
    FOREIGN KEY (`function_id`)
    REFERENCES `function` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `article` ;

CREATE TABLE IF NOT EXISTS `article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  `created_on` DATETIME NULL,
  `updated_on` DATETIME NULL,
  `node_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_node1_idx` (`node_id` ASC),
  INDEX `fk_article_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_article_node1`
    FOREIGN KEY (`node_id`)
    REFERENCES `node` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `article_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `article_comment` ;

CREATE TABLE IF NOT EXISTS `article_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  `created_on` DATETIME NULL,
  `updated_on` DATETIME NULL,
  `article_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `reply_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_comment_article1_idx` (`article_id` ASC),
  INDEX `fk_article_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_article_comment_article_comment1_idx` (`reply_id` ASC),
  CONSTRAINT `fk_article_comment_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_comment_article_comment1`
    FOREIGN KEY (`reply_id`)
    REFERENCES `article_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS Stacker@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'Stacker'@'localhost' IDENTIFIED BY 'Stacker';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'Stacker'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (1, '1922 13th St', '80302', 'CO', 'Boulder');
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (2, '1600 W. 12th Ave', '80204', 'CO', 'Denver');
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (3, '1730 Blake Street', '80202', 'CO', 'Denver');
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (4, '6885 S Santa Fe Dr', '80120', 'CO', 'Littleton');
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (5, '7101 S Clinton St', '80112', 'CO', 'Centennial');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (1, 3, 'admin', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'admin@admin.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'admin', 'I\'m admin, and I\'m an admin', 'admin', 'admin', '');
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (2, 2, 'SteveB', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'steveBuschemi@g.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'I\'m in a class case of emotion', 'Steve', 'Buschemi ', '');
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (3, 1, 'Franky', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'Franky@Gm.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'I love C++', 'Frank', 'Instien', 'https://imgc.artprintimages.com/img/print/young-frankenstein-gene-wilder-1974_u-l-ptag910.jpg?artHeight=350&artPerspective=n&artWidth=550&background=fbfbfb');
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (4, 4, 'DaveJ', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'DaveJohnson@Gm.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'I\'m here to learn and have fun', 'Dave', 'Johnson', 'https://st.depositphotos.com/1005682/1404/i/950/depositphotos_14042984-stock-photo-happy-asian-male-on-a.jpg');
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (5, 5, 'HenryJH', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'HenryJekyll@gm.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'Programming is my passion', 'Henry', 'Jekyll', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (1, 'Java', 'https://github.com/tandpfun/skill-icons/raw/main/icons/Angular-Dark.svg', 'a multi-platform, object-oriented, and network-centric language that can be used as a platform in itself');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (2, 'Python', 'https://github.com/tandpfun/skill-icons/raw/main/icons/Python-Dark.svg', 'an interpreted, object-oriented, high-level programming language with dynamic semantics');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (3, 'JavaScript', 'https://github.com/tandpfun/skill-icons/raw/main/icons/JavaScript.svg', 'a multi-paradigm, dynamic language with types and operators, standard built-in objects, and methods. ');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (4, 'C++', 'https://github.com/tandpfun/skill-icons/raw/main/icons/CPP.svg', 'a cross-platform language that can be used to create high-performance applications');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (5, 'C#', 'https://github.com/tandpfun/skill-icons/raw/main/icons/CS.svg', 'a modern, object-oriented, and type-safe programming language');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (6, 'C', 'https://github.com/tandpfun/skill-icons/raw/main/icons/CS.svg', 'an imperative procedural language, supporting structured programming, lexical variable scope, and recursion, with a static type system');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (7, 'CSS', 'https://github.com/tandpfun/skill-icons/raw/main/icons/CSS.svg', 'a style sheet language used for specifying the presentation and styling of a document written in a markup language such as HTML or XML.');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (8, 'HTML', 'https://github.com/tandpfun/skill-icons/raw/main/icons/HTML.svg', 'the standard markup language for documents designed to be displayed in a web browser.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `user_technology` (`user_id`, `technology_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `profile_link`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `profile_link` (`id`, `url`, `name`, `user_id`) VALUES (1, 'linkedin.com', 'linkedin', 1);
INSERT INTO `profile_link` (`id`, `url`, `name`, `user_id`) VALUES (2, 'facebook.com', 'facebook', 2);
INSERT INTO `profile_link` (`id`, `url`, `name`, `user_id`) VALUES (3, 'github.com', 'github', 5);
INSERT INTO `profile_link` (`id`, `url`, `name`, `user_id`) VALUES (4, 'clearanceJobs.com', 'clearanceJobs', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `node`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (1, 'Super Java bros', 1, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'We love java', '123.image', 1, 'Denver', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (2, 'C++ pupils', 2, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'C++ is the future', NULL, 1, 'Denver', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (3, 'Tunnel Pythons', 3, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'Python coders rule, we\'re the python coders, and that\'s right we rule rule rule', NULL, 1, 'Boulder', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (4, 'No rest for the CSS', 4, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'We make it look good', NULL, 1, 'Littleton', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (5, 'JavaScript off script', 5, 0, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'JavaScript is our passion', NULL, 1, 'Centennial', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `function`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (1, 'Java meet up', 1, 1, 0, 1, '2024-01-22', 'discussing the philosphy of java', '1:00', '3:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 10, 'data:image/jpeg;base64,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');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (2, 'C++ pupils get together', 2, 2, 0, 1, '2025-01-01', 'Getting together to C if we can have a + time!', '10:00', '12:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 2, 12, 'https://bairesdev.mo.cloudinary.net/blog/2023/10/Best-C-IDEs-Text-Editors.jpg?tx=w_3840,q_auto');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (3, 'Python AI buildathon', 3, 3, 0, 1, '2024-02-04', 'Lets see who can build the best ai!', '6:00', '12:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 3, 5, 'https://miro.medium.com/v2/resize:fit:1358/0*pU8l4-u0s1flFQiU.png');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (4, 'CSS for beginners', 4, 4, 0, 1, '2024-03-05', 'Come and join us and learn how to program in CSS', '12:00', '5:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 4, 30, 'data:image/jpeg;base64,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');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (5, 'Strange ways to use JavaScript ', 5, 5, 0, 1, '2024-06-07', 'Come along and join us on our journey to use JavaScript in weird new ways', '1:00', '10:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 5, 6, 'https://res.cloudinary.com/practicaldev/image/fetch/s--X9Y_p5lV--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/ums3t6d9mjrwdau8zr2i.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `node_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node_role` (`id`, `role`, `description`) VALUES (1, 'Owner', 'The owner of the project');
INSERT INTO `node_role` (`id`, `role`, `description`) VALUES (2, 'User', 'Normal user');

COMMIT;


-- -----------------------------------------------------
-- Data for table `node_member`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (1, 1, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (1, 2, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (1, 5, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (1, 4, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (3, 1, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (3, 3, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (4, 4, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (5, 5, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (4, 2, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (2, 4, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (2, 3, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (5, 1, 1, '2001-01-01 01:01:01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `node_technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (1, 1);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (2, 4);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (3, 2);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (4, 7);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (5, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `message`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `message` (`id`, `sender_id`, `receiver_id`, `body`, `created_on`) VALUES (1, 2, 1, 'You\'re a wizard admin', '2001-01-01 01:01:01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `notification`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `notification` (`id`, `content`, `enabled`, `type`, `created_on`) VALUES (1, 'Event cancelled', 1, 'Cancellation', '2001-01-01 01:01:01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_notification`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `user_notification` (`user_id`, `notification_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `function_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `function_comment` (`id`, `function_id`, `content`, `created_on`, `user_id`, `reply_to_comment_id`) VALUES (1, 1, 'Java is for the birds', NULL, 2, NULL);
INSERT INTO `function_comment` (`id`, `function_id`, `content`, `created_on`, `user_id`, `reply_to_comment_id`) VALUES (2, 1, 'You\'re for the birds ', NULL, 1, 1);
INSERT INTO `function_comment` (`id`, `function_id`, `content`, `created_on`, `user_id`, `reply_to_comment_id`) VALUES (3, 3, 'Man this group rocks', NULL, 2, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `attendee`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `attendee` (`function_id`, `user_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `node_resource`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node_resource` (`id`, `url`, `title`, `created_on`, `updated_on`, `node_id`) VALUES (1, 'discord.com', 'Our discord', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `function_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `function_image` (`id`, `image_url`, `function_id`) VALUES (1, 'https://res.cloudinary.com/practicaldev/image/fetch/s--X9Y_p5lV--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/ums3t6d9mjrwdau8zr2i.png', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `article`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `article` (`id`, `content`, `created_on`, `updated_on`, `node_id`, `user_id`) VALUES (1, 'What is life', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `article_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `article_comment` (`id`, `content`, `created_on`, `updated_on`, `article_id`, `user_id`, `reply_id`) VALUES (1, 'Wrong node to ask that bro', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 2, NULL);
INSERT INTO `article_comment` (`id`, `content`, `created_on`, `updated_on`, `article_id`, `user_id`, `reply_id`) VALUES (2, 'My bad', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 1, 1);

COMMIT;

