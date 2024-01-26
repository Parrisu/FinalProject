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
-- Table `city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `city` ;

CREATE TABLE IF NOT EXISTS `city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(300) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_city1_idx` (`city_id` ASC),
  CONSTRAINT `fk_address_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` TINYINT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `created_on` DATETIME NULL,
  `updated_on` DATETIME NULL,
  `role` VARCHAR(45) NOT NULL,
  `about_me` TEXT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `profile_image_url` VARCHAR(2000) NULL,
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
  `user_d` INT NOT NULL,
  `technology_id` INT NOT NULL,
  PRIMARY KEY (`user_d`, `technology_id`),
  INDEX `fk_user_profile_has_technology_technology1_idx` (`technology_id` ASC),
  INDEX `fk_user_profile_has_technology_user_profile1_idx` (`user_d` ASC),
  CONSTRAINT `fk_user_profile_has_technology_user_profile1`
    FOREIGN KEY (`user_d`)
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
  `url` VARCHAR(2000) NULL,
  `name` VARCHAR(60) NULL,
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
  `open_to_public` TINYINT NULL,
  `created_on` DATETIME NOT NULL,
  `updated_on` DATETIME NOT NULL,
  `city_id` INT NOT NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sub_stack_user_profile1_idx` (`user_id` ASC),
  INDEX `fk_node_city1_idx` (`city_id` ASC),
  CONSTRAINT `fk_sub_stack_user_profile1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_node_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `city` (`id`)
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
  `cancelled` TINYINT NULL,
  `enabled` TINYINT NULL,
  `function_date` DATE NULL,
  `description` TEXT NULL,
  `start_time` TIME NULL,
  `end_time` TIME NULL,
  `created_on` DATETIME NULL,
  `updated_on` DATETIME NULL,
  `created_by` INT NOT NULL,
  `open_to_public` TINYINT NULL,
  `max_attendees` INT NULL,
  `image_url` VARCHAR(2000) NULL,
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
  `role` VARCHAR(100) NULL,
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
  `approved` TINYINT NULL,
  `date_joined` DATETIME NULL,
  `date_approved` DATETIME NULL,
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
  `reciever_id` INT NOT NULL,
  `body` TEXT NULL,
  `created_on` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user1_idx` (`sender_id` ASC),
  INDEX `fk_message_user2_idx` (`reciever_id` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`reciever_id`)
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
  `enabled` TINYINT NULL,
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
  `article_comment_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_comment_article1_idx` (`article_id` ASC),
  INDEX `fk_article_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_article_comment_article_comment1_idx` (`article_comment_id` ASC),
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
    FOREIGN KEY (`article_comment_id`)
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
-- Data for table `city`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `city` (`id`, `name`, `state`) VALUES (1, 'Denver', 'Colorado');
INSERT INTO `city` (`id`, `name`, `state`) VALUES (2, 'Centennial', 'Colorado');
INSERT INTO `city` (`id`, `name`, `state`) VALUES (3, 'Aurora', 'Colorado');
INSERT INTO `city` (`id`, `name`, `state`) VALUES (4, 'Littleton', 'Colorado');
INSERT INTO `city` (`id`, `name`, `state`) VALUES (5, 'Boulder', 'Colorado');

COMMIT;


-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `address` (`id`, `street`, `zip_code`, `city_id`) VALUES (1, '7 havana St', '80112', 2);
INSERT INTO `address` (`id`, `street`, `zip_code`, `city_id`) VALUES (2, 'dover st', '80123', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (1, 1, 'admin', 'admin', 1, 'admin@admin.com', NULL, NULL, 'admin', 'I\'m admin, and I\'m an admin', 'admin', 'admin', NULL);
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (2, 2, 'SteveB', 'steveB', 1, 'steveBuschemi@g.com', NULL, NULL, 'user', 'I\'m in a class case of emotion', 'Steve', 'Buschemi ', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (1, 'Java', NULL, 'Its java');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `user_technology` (`user_d`, `technology_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `profile_link`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `profile_link` (`id`, `url`, `name`, `user_id`) VALUES (1, 'image.123', 'test image', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `node`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `city_id`, `description`, `image_url`) VALUES (1, 'Super Java bros', 1, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 'We love java', '123.image');

COMMIT;


-- -----------------------------------------------------
-- Data for table `function`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `open_to_public`, `max_attendees`, `image_url`) VALUES (1, 'Java meet up', 1, 1, 0, 1, NULL, 'discussing the philosphy of java', '', '', NULL, NULL, 1, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `node_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node_role` (`id`, `role`, `description`) VALUES (1, 'Owner', 'The owner of the node');

COMMIT;


-- -----------------------------------------------------
-- Data for table `node_member`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `date_approved`, `node_role_id`) VALUES (1, 1, 1, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `node_technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `message`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `message` (`id`, `sender_id`, `reciever_id`, `body`, `created_on`) VALUES (1, 2, 1, 'You\'re a wizard admin', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `notification`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `notification` (`id`, `content`, `enabled`, `type`, `created_on`) VALUES (1, 'Event cancelled', 1, 'Cancellation', NULL);

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
INSERT INTO `function_comment` (`id`, `function_id`, `content`, `created_on`, `user_id`, `reply_to_comment_id`) VALUES (1, 1, 'Java is for the birds', NULL, 1, NULL);
INSERT INTO `function_comment` (`id`, `function_id`, `content`, `created_on`, `user_id`, `reply_to_comment_id`) VALUES (2, 1, 'You\'re for the birds ', NULL, 1, 1);

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
INSERT INTO `node_resource` (`id`, `url`, `title`, `created_on`, `updated_on`, `node_id`) VALUES (1, 'discord.com', 'Our discord', NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `function_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `function_image` (`id`, `image_url`, `function_id`) VALUES (1, '123.image', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `article`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `article` (`id`, `content`, `created_on`, `updated_on`, `node_id`, `user_id`) VALUES (1, 'What is life', NULL, NULL, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `article_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `article_comment` (`id`, `content`, `created_on`, `updated_on`, `article_id`, `user_id`, `article_comment_id`) VALUES (1, 'Wrong node to ask that bro', NULL, NULL, 1, 2, NULL);
INSERT INTO `article_comment` (`id`, `content`, `created_on`, `updated_on`, `article_id`, `user_id`, `article_comment_id`) VALUES (2, 'My bad', NULL, NULL, 1, 1, 1);

COMMIT;

