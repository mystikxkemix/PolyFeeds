DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`t_formations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_formations` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_formations` (
  `id_formation` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `annee` INT NOT NULL,
  PRIMARY KEY (`id_formation`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_users`    wekgLeN042D5U
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_users` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `id_formation` INT NOT NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_module`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_modules` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_modules` (
  `id_module` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `id_formation` INT NOT NULL,
  `semestre` INT NULL,
  `abreviation` VARCHAR(10),
  PRIMARY KEY (`id_module`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_notes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_notes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_notes` (
  `id_note` INT NOT NULL AUTO_INCREMENT,
  `note` INT NULL,
  `id_user` INT NOT NULL,
  `id_module` INT NOT NULL,
  `infos` VARCHAR(45),
  PRIMARY KEY (`id_note`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_edts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_edts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_edts` (
  `id_edt` INT NOT NULL AUTO_INCREMENT,
  `id_module` INT NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id_edt`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `mydb`.`t_contacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_contacts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_contacts` (
  `id_contact` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NULL,
  `telephone` INT NULL,
  `bureau` VARCHAR(45) NULL,
  PRIMARY KEY (`id_contact`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`t_beacons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_beacons` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_beacons` (
  `id_beacon` INT NOT NULL AUTO_INCREMENT,
  `salle` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_beacon`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_presences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_presences` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_presences` (
  `id_presence` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `id_beacon` INT NOT NULL,
  PRIMARY KEY (`id_presence`))
ENGINE = InnoDB;

CREATE TABLE t_presences(id_presence INT NOT NULL AUTO_INCREMENT PRIMARY KEY, id_user INT NOT NULL, id_beacon INT NOT NULL, date_passage TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE t_beacons(id_beacon INT NOT NULL AUTO_INCREMENT PRIMARY KEY, salle VARCHAR(45),UUID VARCHAR(45),major VARCHAR(45),minor VARCHAR(45)); 