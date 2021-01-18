-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema obd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema obd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `obd` DEFAULT CHARACTER SET utf8 ;
USE `obd` ;

-- -----------------------------------------------------
-- Table `obd`.`sourceTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `obd`.`sourceTypes` (
  `id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `obd`.`sources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `obd`.`sources` (
  `id` INT NOT NULL,
  `type` VARCHAR(255) NULL,
  `name` VARCHAR(255) NULL,
  `url` VARCHAR(2048) NOT NULL,
  `sourceTypeId` INT NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_sources_sourceTypes1_idx` (`sourceTypeId` ASC),
  CONSTRAINT `fk_sources_sourceTypes1`
    FOREIGN KEY (`sourceTypeId`)
    REFERENCES `obd`.`sourceTypes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `obd`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `obd`.`authors` (
  `id` INT NOT NULL,
  `firstName` VARCHAR(255) NULL,
  `lastName` VARCHAR(255) NULL,
  `specification` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `obd`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `obd`.`videos` (
  `id` INT NOT NULL,
  `length` INT NULL,
  `sourceId` INT NOT NULL,
  `authorId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_videos_sources_idx` (`sourceId` ASC),
  INDEX `fk_videos_authors1_idx` (`authorId` ASC),
  CONSTRAINT `fk_videos_sources`
    FOREIGN KEY (`sourceId`)
    REFERENCES `obd`.`sources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_authors1`
    FOREIGN KEY (`authorId`)
    REFERENCES `obd`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `obd`.`articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `obd`.`articles` (
  `id` INT NOT NULL,
  `source` VARCHAR(2048) NULL,
  `body` VARCHAR(2048) NULL,
  `authorId` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_articles_authors1_idx` (`authorId` ASC),
  CONSTRAINT `fk_articles_authors1`
    FOREIGN KEY (`authorId`)
    REFERENCES `obd`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
