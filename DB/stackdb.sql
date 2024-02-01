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
  `nodecol` VARCHAR(45) NULL,
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
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (6, '6715 W Colfax Ave', '80214', 'CO', 'Lakewood');
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (7, '9566 Twenty Mile Rd', '80134', 'CO', 'Parker');
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (8, '14061 E lliff Ave', '80014', 'CO', 'Aurora');
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (9, '5198 N Nevada Ave #150', '80918', 'CO', 'Colorado Springs');
INSERT INTO `address` (`id`, `street`, `zip_code`, `state_abbreviation`, `city`) VALUES (10, '8271 S Quebec St,', '80112', 'CO', 'Centennial');

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
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (6, 6, 'CaveJ', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'CaveJohnson@ApetureScience.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'hen life gives you lemons, don\'t make lemonade - make life take the lemons back! Get mad! I don\'t want your darn lemons, what am I supposed to do with these? Demand to see life\'s manager.', 'Cave', 'Johnson', NULL);
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (7, 7, 'SlimP', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'SlimPickens@AF.mil', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'Been Hackin since the cold war', 'Slim', 'Pickens', NULL);
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (8, 8, 'JohnnyB', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'JohnBravo@Hannabarbra.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'I keep like i keep my hair, cool, clean, and FUNKY FRESH', 'Johnny', 'Bravo', NULL);
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (9, 9, 'TexasRed', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'TexasRed@BigRedSoda.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'I am the fastest coder, plain and simple ain\'t no coder faster than me', 'James', 'Darwin', NULL);
INSERT INTO `user` (`id`, `address_id`, `username`, `password`, `enabled`, `email`, `created_on`, `updated_on`, `role`, `about_me`, `first_name`, `last_name`, `profile_image_url`) VALUES (10, 10, 'ArizonaRanger', '$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq', 1, 'ArizonaRanger@ArizonaIceTea.com', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'user', 'I am a faster programmer than texas red ever could be', 'John ', 'Newton', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (1, 'Java', 'https://raw.githubusercontent.com/tandpfun/skill-icons/de91fca307a83d75fc5b1f6ce24540454acead41/icons/Java-Dark.svg', 'a multi-platform, object-oriented, and network-centric language that can be used as a platform in itself');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (2, 'Python', 'https://github.com/tandpfun/skill-icons/raw/main/icons/Python-Dark.svg', 'an interpreted, object-oriented, high-level programming language with dynamic semantics');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (3, 'JavaScript', 'https://github.com/tandpfun/skill-icons/raw/main/icons/JavaScript.svg', 'a multi-paradigm, dynamic language with types and operators, standard built-in objects, and methods. ');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (4, 'C++', 'https://github.com/tandpfun/skill-icons/raw/main/icons/CPP.svg', 'a cross-platform language that can be used to create high-performance applications');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (5, 'C#', 'https://github.com/tandpfun/skill-icons/raw/main/icons/CS.svg', 'a modern, object-oriented, and type-safe programming language');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (6, 'C', 'https://github.com/tandpfun/skill-icons/raw/main/icons/C.svg', 'an imperative procedural language, supporting structured programming, lexical variable scope, and recursion, with a static type system');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (7, 'CSS', 'https://github.com/tandpfun/skill-icons/raw/main/icons/CSS.svg', 'a style sheet language used for specifying the presentation and styling of a document written in a markup language such as HTML or XML.');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (8, 'HTML', 'https://github.com/tandpfun/skill-icons/raw/main/icons/HTML.svg', 'the standard markup language for documents designed to be displayed in a web browser.');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (9, 'Rust', 'https://raw.githubusercontent.com/tandpfun/skill-icons/de91fca307a83d75fc5b1f6ce24540454acead41/icons/Rust.svg', 'Rust is a multi-paradigm, general-purpose programming language that emphasizes performance, type safety, and concurrency');
INSERT INTO `technology` (`id`, `name`, `badge_url`, `description`) VALUES (10, 'Linux', 'https://raw.githubusercontent.com/tandpfun/skill-icons/de91fca307a83d75fc5b1f6ce24540454acead41/icons/Linux-Dark.svg', 'Linux is a Unix-like, open source and community-developed operating system (OS) for computers, servers, mainframes, mobile devices and embedded devices.');

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
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (1, 'Super Java bros', 1, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'We love java', 'https://img.freepik.com/free-photo/programming-background-with-person-working-with-codes-computer_23-2150010125.jpg?size=626&ext=jpg', 1, 'Denver', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (2, 'C++ pupils', 2, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'C++ is the future', 'https://img.freepik.com/free-photo/html-system-website-concept_23-2150376770.jpg?size=626&ext=jpg', 1, 'Denver', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (3, 'Tunnel Pythons', 3, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'Python coders rule, we\'re the python coders, and that\'s right we rule rule rule', 'https://img.freepik.com/free-photo/top-view-unrecognizable-hacker-performing-cyberattack-night_1098-18706.jpg?w=1060&t=st=1706735067~exp=1706735667~hmac=10db93ce012983e1d236d47dda5e1eae7664b97e1eff19852d15b75e9132bddd', 1, 'Boulder', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (4, 'No rest for the CSS', 4, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'We make it look good', 'https://img.freepik.com/free-photo/web-design-concept-with-drawings_1134-77.jpg?size=626&ext=jpg&ga=GA1.1.996327085.1706734954&semt=sph', 1, 'Littleton', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (5, 'JavaScript off script', 5, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'JavaScript is our passion', 'https://img.freepik.com/free-vector/new-app-development-desktop_23-2148684987.jpg?size=626&ext=jpg&ga=GA1.1.996327085.1706734954&semt=sph', 1, 'Centennial', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (6, 'HTML Weavers', 6, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'For those who want to learn html, join us as we weave web pages ', 'https://cdn-images-1.medium.com/max/1013/1*Dbd3olLaASRAXncGAJFQkA.jpeg', 1, 'Lakewood', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (7, 'Sharpest C# Around ', 7, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'Come Join us and learn all you could ever want to know about C#', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRZFPJ3NWeuA3GmxQMsS1yJr3p0uG5DKn34Q&usqp=CAU', 1, 'Parker', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (8, 'The Linux Lovers', 8, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'We are a group dedicated to spreading the good word of linux to all who will listen', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMo5VzGVzK273cmG9zuXWToFVZZBpbUO7ojw&usqp=CAU', 1, 'Aurora', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (9, 'Sailors of the high C', 9, 1, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'Avast ye matey, join us and learn all about C so you too can stay afloat in this job market', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTmJ6mvly55YDW9tu91Ng4T4wtcECjFp67hw&usqp=CAU', 1, 'Colorado Springs', NULL);
INSERT INTO `node` (`id`, `name`, `user_id`, `open_to_public`, `created_on`, `updated_on`, `state_abbreviation`, `description`, `image_url`, `enabled`, `city`, `nodecol`) VALUES (10, 'Rust Rangers', 10, 0, '2001-01-01 01:01:01', '2001-01-01 01:01:01', 'CO', 'We are the fastest Rust programmers in the west', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStPMZJJ-PJhSFuBO_F_WeZ9o0Y3tH1wuwtRw&usqp=CAU', 1, 'Centennial', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `function`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (1, 'Java meet up', 1, 1, 0, 1, '2024-01-22', 'discussing the philosphy of java', '1:00', '3:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 10, 'https://st2.depositphotos.com/4021139/7527/i/450/depositphotos_75272709-stock-photo-java-concept.jpg');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (2, 'C++ pupils get together', 2, 2, 0, 1, '2025-01-01', 'Getting together to C if we can have a + time!', '10:00', '12:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 2, 12, 'https://bairesdev.mo.cloudinary.net/blog/2023/10/Best-C-IDEs-Text-Editors.jpg?tx=w_3840,q_auto');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (3, 'Python AI buildathon', 3, 3, 0, 1, '2024-02-04', 'Lets see who can build the best ai!', '6:00', '12:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 3, 5, 'https://miro.medium.com/v2/resize:fit:1358/0*pU8l4-u0s1flFQiU.png');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (4, 'CSS for beginners', 4, 4, 0, 1, '2024-03-05', 'Come and join us and learn how to program in CSS', '12:00', '5:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 4, 30, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwyv7fSGJ74hmILEXaDzuEdYCJTU7CysrdNg&usqp=CAU');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (5, 'Strange ways to use JavaScript ', 5, 5, 0, 1, '2024-06-07', 'Come along and join us on our journey to use JavaScript in weird new ways', '1:00', '10:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 5, 6, 'https://res.cloudinary.com/practicaldev/image/fetch/s--X9Y_p5lV--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/ums3t6d9mjrwdau8zr2i.png');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (6, 'Java With Java: Coffee and  Java programming', 6, 1, 0, 1, '2024-02-05', 'Get some Java with us while we talk about and program in Java', '4:00', '8:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 15, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc1trv2EiXHwpuBmnJMhR0tPcXJR-wkXgixA&usqp=CAU');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (7, 'Java for beginners', 3, 1, 0, 1, '2024-02-06', 'New to Java? Come and learn what this amazing langauge can do!', '5:00', '8:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 20, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSjanQ4epJoTamKhDBDUrY9OBvOnb2PyRpew&usqp=CAU');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (8, 'HTML meet up', 7, 6, 0, 1, '2024-02-09', 'Just a fun meet up to network and meet with our lovely group members', '2:00', '4:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 6, 12, 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.thatcompany.com%2Fwp-content%2Fuploads%2F2019%2F08%2Fgoogle-snippets-3.png&tbnid=N5RqRIh5VAqAoM&vet=12ahUKEwjHl6jBo4mEAxUxADQIHbx_CDsQMygcegUIARClAQ..i&imgrefurl=https%3A%2F%2Fwww.thatcompany.com%2Fgoogle-tracking-snippets-which-should-i-use&docid=fC3TAXLI8xkv_M&w=1556&h=848&q=html%20code%20snippet&ved=2ahUKEwjHl6jBo4mEAxUxADQIHbx_CDsQMygcegUIARClAQ');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (9, 'C# sharpening your C# skills', 8, 7, 0, 1, '2024-04-05', 'We\'ll be trading tips and tricks to help sharpen our C# programming skills', '1:00', '5:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 7, 15, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_M4RL3d0yMo9-vf10-st-QDx1ruw_QTOsRA&usqp=CAU');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (10, 'Linux and You: Making the most of linux', 4, 8, 0, 1, '2024-02-12', 'Linux is an amazing operating system, but some may be intimidated by the freedom it offers, join us and learn how to make linux work for you!', '10:00', '4:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 8, 30, 'https://img.freepik.com/free-photo/business-man-celebrating-with-his-arm-up-sitting-desk-front-computer_155003-30049.jpg?w=1800&t=st=1706761145~exp=1706761745~hmac=e032120fff18112ea54adadf872bf98343721f630d409956097db2c3212bfce7');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (11, 'C: seeing the light of C', 9, 9, 0, 1, '2024-03-04', 'Come join us and learn all about the c language. Soon enough you too will C the light', '12:00', '3:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 9, 20, 'https://img.freepik.com/free-photo/computer-program-coding-screen_53876-138060.jpg?w=1800&t=st=1706761256~exp=1706761856~hmac=bceb0482fea87f37d8934e465d154efba2e09c73bde0186c30a4cb9d1b85a002');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (12, 'Rust meet and greet', 1, 10, 0, 1, '2024-02-07', 'Just a simple meet and greet for us rust programmers to get to know each other better', '10:00', '2:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 10, 40, 'https://img.freepik.com/free-photo/programming-background-with-html-text_23-2150040420.jpg?w=1800&t=st=1706761313~exp=1706761913~hmac=8a4345c9b65c5f02e3b7745cc646c3a745a7960a62c81e8440014cda1658ea11');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (13, 'C++ tips and tricks', 10, 2, 0, 1, '2024-02-11', 'Join us and share your C++ tips and tricks', '12:00', '4:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 2, 10, 'https://img.freepik.com/free-photo/closeup-programming-code-language_53876-33908.jpg?w=1800&t=st=1706761374~exp=1706761974~hmac=e28c13530776bc76bdd8b814466fc482a82f57f7334b2946e8f71e38f5f55920');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (14, 'C++ networking event', 3, 2, 0, 1, '2024-05-05', 'This is a meet up to help you network and meet fellow C++ programmers', '5:00', '8:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 2, 15, 'https://img.freepik.com/free-photo/human-resources-concept-with-people_23-2150389123.jpg?w=1800&t=st=1706761409~exp=1706762009~hmac=7bea3a00a871f67ab5cba045e1514a799c25828d19099d6234e699c9759c2f16');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (15, 'Tunnel Python Meet up', 3, 3, 0, 1, '2024-05-17', 'Lets Meet up and meet our members!', '4:30', '6:30', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 3, 16, 'https://img.freepik.com/free-photo/business-people-binary-code-sharing-technology-concept_53876-13712.jpg?w=1800&t=st=1706761470~exp=1706762070~hmac=ef195ac5850a87dbd0896a24bf684435ab17630cac734f3427ede4d5813253d4');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (16, 'RustRangers: Rust rush', 1, 10, 0, 1, '2024-02-14', 'How Fast can you make an operating system? Join us and find out', '10:00', '8:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 10, 25, 'https://img.freepik.com/free-vector/silhouettes-men-racing_1048-1470.jpg?w=1800&t=st=1706761598~exp=1706762198~hmac=518ca1392658b82c62ef0220215221d49de12f8e0e95c63be1319c098f6a299e');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (17, 'Python for pros', 8, 3, 0, 1, '2024-02-29', 'Trade your tips and tricks with fellow python pros', '2:30', '5:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 3, 18, 'https://img.freepik.com/free-photo/comic-drawings-portrait_23-2150762888.jpg?w=1800&t=st=1706761674~exp=1706762274~hmac=5a3e76b479fde7ee92d703e825de4d106dede86686c35740eae3b1ca386498e9');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (18, 'Python for profit', 4, 3, 0, 1, '2024-02-24', 'Come and learn how you can use the great language of python to make a profit ', '7:30', '11:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 3, 14, 'https://img.freepik.com/free-photo/financial-data_53876-120032.jpg?w=1800&t=st=1706761718~exp=1706762318~hmac=643a29b478f2e06d8b42a03ac77fe0ec72b4fbc78accf79fee2eb8392a90cb10');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (19, 'Java jump start the year', 2, 1, 0, 1, '2024-02-16', 'Get the year started right with some Java discussion and programming!', '10:30', '12:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 1, 22, 'https://img.freepik.com/free-vector/colorful-isometric-composition-with-electronic-gadgets-human-hand-holding-charger-3d-illustration_1284-54106.jpg?w=1800&t=st=1706761767~exp=1706762367~hmac=44eb6384b571066213cb359041615d43c79ff75e3bbd1694e0c4564ffed1986e');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (20, 'CSS summer fun', 10, 4, 0, 1, '2024-07-15', 'Get some CSS programming fun under the sun, bring your laptop and join us for summer CSS programming!', '9:00', '11:30', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 4, 11, 'https://img.freepik.com/free-photo/summer-holiday-concept_53876-41449.jpg?w=1800&t=st=1706761823~exp=1706762423~hmac=452522e182e39e44fd7e7a0b961502a1197060a2fc4d075e8cd7b336c4603258');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (21, 'JS Code meet up', 10, 5, 0, 1, '2024-03-03', ' Meet up with us and talk JavaScript!', '8:30', '10:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 5, 22, 'https://img.freepik.com/premium-photo/team-asian-business-people-collaborate-evaluate-interpret-data-using-calculator-during-meeting_875722-8968.jpg?w=1800');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (22, 'De-stress with CSS', 8, 4, 0, 1, '2024-03-12', 'Come write some code with us in a relaxing enviroment and de-stress', '9:00', '12:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 4, 40, 'https://img.freepik.com/free-vector/organic-flat-business-people-meditating-illustration_23-2148908035.jpg?w=1800&t=st=1706761996~exp=1706762596~hmac=ef31b293c777d6777a67af095aafc5ef5eb9b61c1ee34072ccbfeb1b589bde94');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (23, 'JS Spring start', 6, 5, 0, 1, '2024-03-19', 'Lets meet up with our new groupmates now that its starting to get a bit warmer!', '9:30', '11:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 5, 30, 'https://img.freepik.com/free-photo/programming-background-collage_23-2149901771.jpg?w=1800&t=st=1706762039~exp=1706762639~hmac=6fefae32c23816da6bb33251ce3bb0c7ecf0e8972b80dda27bea0d44ae0a22fc');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (24, 'C++ Networking meet up', 5, 2, 0, 1, '2024-08-09', 'Lets build some connections with fellow C++ programmers', '8:00', '10:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 2, 20, 'https://img.freepik.com/free-vector/illustration-business-people_53876-44036.jpg?w=1800&t=st=1706762115~exp=1706762715~hmac=4cdca3058dbe3739a8c216e81811c767f13a58676aa6731a1f76af29db8fdd8f');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (25, 'Rust networking and meet up', 4, 10, 0, 1, '2024-07-06', 'Rust meet up and Networking to help you build your connections', '4:00', '7:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 10, 25, 'https://img.freepik.com/free-vector/illustration-business-people-meeting_53876-17850.jpg?w=1800&t=st=1706762142~exp=1706762742~hmac=510a8a3f01f35e3b6c89dcd4a382a19b94ea1880a5711b228d27705113b3dd41');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (26, 'C for pros', 10, 9, 0, 1, '2024-08-15', 'This meet up is for C programmers who feel they are pros in the language', '12:00', '2:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 9, 30, 'https://img.freepik.com/free-photo/cyber-attack-with-unrecognizable-hooded-hacker-using-virtual-reality-digital-glitch-effect_146671-18951.jpg?w=1800&t=st=1706763207~exp=1706763807~hmac=205eb15be4e992df191307f98c87aa64a4bb6067c5ec4983ead339f961419b68');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (27, 'Linux Networking Event', 8, 8, 0, 1, '2024-05-12', 'Come and connect with some of the masters of linux ', '8:00', '10:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 8, 10, 'https://img.freepik.com/premium-photo/two-penguins-are-dressed-up-suits-one-has-red-tie_888757-597.jpg?w=1800');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (28, 'C# Meet and Greet', 6, 7, 0, 1, '2024-10-08', 'Lets meet up and introduce ourselves!', '10:00', '1:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 7, 15, 'https://img.freepik.com/free-photo/global-business-internet-network-connection-iot-internet-things-business-intelligence-concept-busines-global-network-futuristic-technology-background-ai-generative_1258-176942.jpg?w=1800&t=st=1706762508~exp=1706763108~hmac=7ecd4ddbddd9f238e9d50c62eb4a624411b284244409c6c671fa102e5b3514dd');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (29, 'HTML for Newbies', 9, 6, 0, 1, '2024-09-13', 'New to HTML? No worries come and join us and get started programming HTML on the right foot!', '10:00', '3:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 6, 50, 'https://img.freepik.com/free-photo/composition-with-html-system-websites_23-2150866300.jpg?w=1800&t=st=1706762443~exp=1706763043~hmac=66616df3bfda8c6a64242e4cf9af89f3d0daa4bd1876761b164797fd28baf96f');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (30, 'JS October meet up', 3, 5, 0, 1, '2024-10-08', 'It\'s getting colder so lets meet up and enjoy some JavaScript programming before it gets to cold outside too', '3:00', '6:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 5, 25, 'https://img.freepik.com/premium-photo/high-angle-view-mobile-phone-table_1048944-15988902.jpg?w=1800');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (31, 'CSS Eternal september', 4, 4, 0, 1, '2024-09-12', 'CSS september meet up to discuss new tips and technologies in CSS', '10:00', '2:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 4, 22, 'https://img.freepik.com/free-vector/day-programmer-poster_1308-114610.jpg?w=1800&t=st=1706762614~exp=1706763214~hmac=754c06ae7f84e94c2e4f58208e851a79dc9bbc6c649ac9b30da776b50989e1ec');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (32, 'Linux For Veterans', 8, 8, 0, 1, '2024-11-11', 'To honor those who\'ve served we would like to extend a hand to veterans and help them get started in linux', '11:00', '8:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 8, 12, 'https://img.freepik.com/free-vector/veterans-day-concept-flat-design_23-2148341176.jpg?w=1800&t=st=1706762674~exp=1706763274~hmac=39211c444d7a3918e34774904da8d6172904050671eaa50e8cffc714547abbb5');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (33, 'C Spring Rush', 7, 9, 0, 1, '2024-04-21', 'Spring is here and so are we! So lets see if your C programming skills have improved as you test your pace against others to see who is the fastest programmer', '9:00', '4:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 9, 15, 'https://img.freepik.com/free-photo/top-view-laptop-with-bouquet-light-pink-flowers-blue-surface_141793-18254.jpg?w=1800&t=st=1706762752~exp=1706763352~hmac=2ff7992545a9a1a10dfb5acd8cdf7a4592546af166f65f39308db732d45ccc7d');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (34, 'Rust language introduction', 9, 10, 0, 1, '2024-07-11', 'This meet up will serve as an introduction to the rust language for anyone who wants to learn and plans to join our group', '10:00', '4:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 10, 15, 'https://img.freepik.com/free-photo/man-working-with-laptop-with-thumbs-up_1150-52058.jpg?w=1800&t=st=1706762829~exp=1706763429~hmac=46c0b1a335bed44149e002329e67e6da431f6dafbfe8bce5fdd0ca0a61fe9c49');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (35, 'C# for pros', 5, 7, 0, 1, '2024-05-22', 'Are you a pro in C#? Well come and show off your skills!', '2:00', '5:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 7, 20, 'https://img.freepik.com/free-photo/html-css-collage-concept-with-person_23-2150061986.jpg?w=1800&t=st=1706762857~exp=1706763457~hmac=50d37d4f14fd95eb31798accabc28ab6baf74abff0bf93b103e3a2952c737396');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (36, 'Advanced HTML programming meet up', 9, 6, 0, 1, '2024-12-11', 'This meet up well help our less experienced members advance their html skills to the next level', '1:00', '4:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 6, 35, 'https://img.freepik.com/free-photo/programming-language-workplace_1134-65.jpg?w=1800&t=st=1706762881~exp=1706763481~hmac=390bf26a72580936d4be292e76d028be30921818df13f582c62e6dc7c85a8d5e');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (37, 'C for newbies', 8, 9, 0, 1, '2024-10-13', 'Wanna get into C programming? Come and Join us and get a start in the right direction, join our group and keep heading in that direction', '10:00', '2:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 9, 40, 'https://img.freepik.com/free-vector/programmer-good-coding-developer-programming-with-laptop-seat-work-from-home_40876-2624.jpg?w=1800&t=st=1706762975~exp=1706763575~hmac=c75c53c5729c3ff2758e4c17e0b7736158272d91af181de2253a5131dffd8365');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (38, 'Linux Introduction ', 9, 8, 0, 1, '2024-11-08', 'Welcome to Linux, well go over everyting you need to get started at this meeting', '9:00', '3:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 8, 34, 'https://img.freepik.com/free-photo/nature-beauty-penguin-colony-waddling-together-generated-by-ai_188544-10170.jpg?w=1800&t=st=1706763019~exp=1706763619~hmac=018f0be1303d948ffeaf88ef069f8ef8291463a34c884542400eda0a73e727d2');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (39, 'Python winter get together', 3, 3, 0, 1, '2024-11-01', 'Winter can be cold, but Python coders never get cold, come warm up your programming skills with us, don\'t let them freeze up like the weather! Free coco will be available ', '2:00', '5:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 3, 20, 'https://img.freepik.com/free-photo/hands-holding-cup-coffee-using-laptop-smartphone-with-christmas-decoration-shopping-online_1428-560.jpg?w=1800&t=st=1706763056~exp=1706763656~hmac=5118c6aefc098a7963efadd786c496f7ad891feb7a17ee6bbcd58b1735224571');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (40, 'HTML Networking', 6, 6, 0, 1, '2024-06-29', 'Meet up with local bussinesses in need of html developers and other programmers to help you on your HTML Journey', '1:00', '5:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 6, 25, 'https://img.freepik.com/free-photo/blog-blogging-digital-networking-www-global-concept_53876-21189.jpg?w=1800&t=st=1706763092~exp=1706763692~hmac=5a5f16271bae3ddcb07a47f53621c3a7b5f4351282ded15496a2783d19a20d93');
INSERT INTO `function` (`id`, `name`, `address_id`, `node_id`, `cancelled`, `enabled`, `function_date`, `description`, `start_time`, `end_time`, `created_on`, `updated_on`, `created_by`, `max_attendees`, `image_url`) VALUES (41, 'C# Program palooza', 5, 7, 0, 1, '2024-09-09', 'Just because it\'s starting to get cold, doesn\'t mean we should let our skills freeze, come join us and get some time working on C# projects to get you more experience for your portfolio', '8:00', '2:00', '2001-01-01 01:01:01', '2001-01-01 01:01:01', 7, 32, 'https://img.freepik.com/free-photo/binary-code-digits-technology-software-concept_53876-121041.jpg?w=1800&t=st=1706763239~exp=1706763839~hmac=7ef7b7c728603836e0c7420d8c1d1ca185aaf5c0d191a470965a286db1d10d60');

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
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (1, 6, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (1, 7, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (1, 8, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (2, 9, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (2, 10, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (2, 6, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (2, 7, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (3, 8, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (3, 9, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (3, 6, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (3, 10, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (4, 6, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (4, 7, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (4, 8, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (4, 10, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (5, 6, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (5, 9, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (5, 8, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (6, 6, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (6, 1, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (6, 2, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (6, 3, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (6, 5, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (6, 7, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (6, 9, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (7, 7, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (7, 2, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (7, 4, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (7, 6, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (7, 8, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (7, 10, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (8, 8, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (8, 1, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (8, 3, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (8, 5, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (8, 7, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (8, 9, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (8, 4, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (9, 9, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (9, 4, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (9, 5, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (9, 6, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (9, 7, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (9, 8, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (10, 10, 1, '2001-01-01 01:01:01', 1);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (10, 1, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (10, 2, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (10, 3, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (10, 4, 1, '2001-01-01 01:01:01', 2);
INSERT INTO `node_member` (`node_id`, `user_id`, `approved`, `date_joined`, `node_role_id`) VALUES (10, 9, 1, '2001-01-01 01:01:01', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `node_technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `stackdb`;
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (1, 1);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (1, 3);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (1, 5);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (2, 2);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (2, 4);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (2, 6);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (3, 1);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (3, 2);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (3, 4);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (4, 7);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (4, 8);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (4, 9);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (5, 3);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (5, 5);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (5, 7);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (6, 8);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (6, 9);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (6, 10);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (7, 1);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (7, 5);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (7, 6);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (8, 10);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (8, 2);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (8, 3);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (9, 4);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (9, 6);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (9, 9);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (10, 9);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (10, 10);
INSERT INTO `node_technology` (`node_id`, `technology_id`) VALUES (10, 2);

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

