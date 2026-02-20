-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ncaa_track
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ncaa_track
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ncaa_track` DEFAULT CHARACTER SET utf8mb3 ;
USE `ncaa_track` ;

-- -----------------------------------------------------
-- Table `ncaa_track`.`athletes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`athletes` (
  `athlete_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `sex` TINYINT NOT NULL,
  PRIMARY KEY (`athlete_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`universities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`universities` (
  `universities_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`universities_id`),
  UNIQUE INDEX `iduniversities_UNIQUE` (`universities_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`athlete_universities_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`athlete_universities_map` (
  `athlete_id` INT NOT NULL,
  `universities_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  PRIMARY KEY (`athlete_id`, `universities_id`, `start_date`),
  INDEX `fk_athlete_universities_map_universities1_idx` (`universities_id` ASC) VISIBLE,
  CONSTRAINT `fk_athlete_universities_map_athletes1`
    FOREIGN KEY (`athlete_id`)
    REFERENCES `ncaa_track`.`athletes` (`athlete_id`),
  CONSTRAINT `fk_athlete_universities_map_universities1`
    FOREIGN KEY (`universities_id`)
    REFERENCES `ncaa_track`.`universities` (`universities_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`divisions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`divisions` (
  `division_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`division_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`conferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`conferences` (
  `conference_id` INT NOT NULL AUTO_INCREMENT,
  `division_id` INT NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `region` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`conference_id`),
  INDEX `fk_conference_divisions1_idx` (`division_id` ASC) VISIBLE,
  CONSTRAINT `fk_conference_divisions1`
    FOREIGN KEY (`division_id`)
    REFERENCES `ncaa_track`.`divisions` (`division_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`events` (
  `event_id` INT NOT NULL AUTO_INCREMENT,
  `event_name` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`event_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`meets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`meets` (
  `meet_id` INT NOT NULL,
  `meet_name` VARCHAR(250) NOT NULL,
  `host_university_id` INT NOT NULL,
  `track_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`meet_id`),
  INDEX `fk_meets_track_idx` (`track_id` ASC) VISIBLE,
  INDEX `fk_meets_universities_idx` (`host_university_id` ASC) VISIBLE,
  CONSTRAINT `fk_meets_track`
    FOREIGN KEY (`track_id`)
    REFERENCES `ncaa_track`.`tracks` (`track_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_meets_universities`
    FOREIGN KEY (`host_university_id`)
    REFERENCES `ncaa_track`.`universities` (`universities_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`meet_events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`meet_events` (
  `meet_event_id` INT NOT NULL,
  `meet_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`meet_event_id`),
  UNIQUE INDEX `unique_meet_event` (`meet_id` ASC, `event_id` ASC) VISIBLE,
  INDEX `fk_meet_id_idx` (`meet_id` ASC) VISIBLE,
  INDEX `fk_events_id_idx` (`event_id` ASC) VISIBLE,
  CONSTRAINT `fk_events_id`
    FOREIGN KEY (`event_id`)
    REFERENCES `ncaa_track`.`events` (`event_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_meet_id`
    FOREIGN KEY (`meet_id`)
    REFERENCES `ncaa_track`.`meets` (`meet_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`meet_university_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`meet_university_roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `role_name_UNIQUE` (`role_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`meet_universities_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`meet_universities_map` (
  `meet_id` INT NOT NULL,
  `university_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`meet_id`, `university_id`, `role_id`),
  INDEX `universities_id_idx` (`university_id` ASC) VISIBLE,
  INDEX `fk_role_id_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_meet_universities_map_meet`
    FOREIGN KEY (`meet_id`)
    REFERENCES `ncaa_track`.`meets` (`meet_id`),
  CONSTRAINT `fk_meet_universities_map_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `ncaa_track`.`meet_university_roles` (`role_id`),
  CONSTRAINT `fk_meet_universities_map_universities`
    FOREIGN KEY (`university_id`)
    REFERENCES `ncaa_track`.`universities` (`universities_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`results` (
  `result_id` INT NOT NULL AUTO_INCREMENT,
  `meet_event_id` INT NOT NULL,
  `athlete_id` INT NOT NULL,
  `round_number` INT NOT NULL,
  `performance` INT NULL DEFAULT NULL,
  `performance_units` VARCHAR(45) NULL DEFAULT NULL,
  `place` INT NULL DEFAULT NULL,
  `points` INT NULL DEFAULT NULL,
  `result_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`result_id`),
  UNIQUE INDEX `unique_meet_event_athlete_round` (`meet_event_id` ASC, `athlete_id` ASC, `round_number` ASC) VISIBLE,
  INDEX `fk_meet_events_id_idx` (`meet_event_id` ASC) VISIBLE,
  INDEX `fk_athletes_idx` (`athlete_id` ASC) VISIBLE,
  CONSTRAINT `fk_athletes`
    FOREIGN KEY (`athlete_id`)
    REFERENCES `ncaa_track`.`athletes` (`athlete_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_meet_events_id`
    FOREIGN KEY (`meet_event_id`)
    REFERENCES `ncaa_track`.`meet_events` (`meet_event_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`track_universities_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`track_universities_map` (
  `university_id` INT NOT NULL,
  `track_id` INT NOT NULL,
  PRIMARY KEY (`university_id`, `track_id`),
  INDEX `fk_track_universities_map_track1_idx` (`track_id` ASC) VISIBLE,
  CONSTRAINT `fk_track_universities_map_track1`
    FOREIGN KEY (`track_id`)
    REFERENCES `ncaa_track`.`tracks` (`track_id`),
  CONSTRAINT `fk_track_universities_map_universities`
    FOREIGN KEY (`university_id`)
    REFERENCES `ncaa_track`.`universities` (`universities_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`tracks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`tracks` (
  `track_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  `elevation` INT NULL DEFAULT NULL,
  `environment` ENUM('Outdoor', 'Indoor') NOT NULL,
  PRIMARY KEY (`track_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ncaa_track`.`university_conference_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaa_track`.`university_conference_map` (
  `university_id` INT NOT NULL,
  `conference_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`university_id`, `conference_id`),
  INDEX `fk_university_conference_map_conference1_idx` (`conference_id` ASC) VISIBLE,
  CONSTRAINT `fk_university_conference_map_conference1`
    FOREIGN KEY (`conference_id`)
    REFERENCES `ncaa_track`.`conferences` (`conference_id`),
  CONSTRAINT `fk_university_conference_map_universities1`
    FOREIGN KEY (`university_id`)
    REFERENCES `ncaa_track`.`universities` (`universities_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
