-- MySQL Script generated by MySQL Workbench
-- Tue Dec 22 21:29:04 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`klient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`klient` (
  `id_klienta` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(45) NOT NULL,
  `nazwisko` VARCHAR(45) NOT NULL,
  `adres` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `data_urodzenia` DATE NOT NULL,
  `waga` VARCHAR(45) NOT NULL,
  `rozmiar_buta` VARCHAR(45) NOT NULL,
  `udzwig` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_klienta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tory` (
  `id_toru` INT NOT NULL AUTO_INCREMENT,
  `dlugosc` VARCHAR(45) NOT NULL,
  `nazwa_toru` VARCHAR(45) NOT NULL,
  `bandy` VARCHAR(5) NOT NULL COMMENT '\"tak\" lub \"nie\"',
  PRIMARY KEY (`id_toru`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`salon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`salon` (
  `id_salonu` INT NOT NULL AUTO_INCREMENT,
  `miasto` VARCHAR(45) NOT NULL,
  `miejsce` VARCHAR(45) NOT NULL,
  `poziom_trudnosci` VARCHAR(45) NOT NULL,
  `max_ilosc_osob` VARCHAR(45) NULL,
  PRIMARY KEY (`id_salonu`),
  UNIQUE INDEX `max_ilosc_osob_UNIQUE` (`max_ilosc_osob` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rezerwacja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rezerwacja` (
  `id_rezerwacji` INT NOT NULL,
  `data_rezerwacji` DATE NOT NULL,
  `klient_id_klienta` INT NOT NULL,
  `tory_id_toru` INT NOT NULL,
  `salon_id_salonu` INT NOT NULL,
  PRIMARY KEY (`id_rezerwacji`),
  INDEX `fk_rezerwacja_klient_idx` (`klient_id_klienta` ASC) VISIBLE,
  INDEX `fk_rezerwacja_tory1_idx` (`tory_id_toru` ASC) VISIBLE,
  INDEX `fk_rezerwacja_salon1_idx` (`salon_id_salonu` ASC) VISIBLE,
  CONSTRAINT `fk_rezerwacja_klient`
    FOREIGN KEY (`klient_id_klienta`)
    REFERENCES `mydb`.`klient` (`id_klienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rezerwacja_tory1`
    FOREIGN KEY (`tory_id_toru`)
    REFERENCES `mydb`.`tory` (`id_toru`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rezerwacja_salon1`
    FOREIGN KEY (`salon_id_salonu`)
    REFERENCES `mydb`.`salon` (`id_salonu`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`buty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`buty` (
  `id_butow` INT NOT NULL AUTO_INCREMENT,
  `rozmiar` INT NOT NULL,
  `firma` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_butow`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`kule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`kule` (
  `id_kuli` INT NOT NULL AUTO_INCREMENT,
  `waga` VARCHAR(45) NOT NULL,
  `kolor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_kuli`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`klient-buty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`klient-buty` (
  `klient_id_klienta` INT NOT NULL,
  `buty_id_butow` INT NOT NULL,
  PRIMARY KEY (`klient_id_klienta`, `buty_id_butow`),
  INDEX `fk_klient-buty_buty1_idx` (`buty_id_butow` ASC) VISIBLE,
  CONSTRAINT `fk_klient-buty_klient1`
    FOREIGN KEY (`klient_id_klienta`)
    REFERENCES `mydb`.`klient` (`id_klienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_klient-buty_buty1`
    FOREIGN KEY (`buty_id_butow`)
    REFERENCES `mydb`.`buty` (`id_butow`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`klient-kula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`klient-kula` (
  `klient_id_klienta` INT NOT NULL,
  `kule_id_kuli` INT NOT NULL,
  PRIMARY KEY (`klient_id_klienta`, `kule_id_kuli`),
  INDEX `fk_klient-kula_kule1_idx` (`kule_id_kuli` ASC) VISIBLE,
  CONSTRAINT `fk_klient-kula_klient1`
    FOREIGN KEY (`klient_id_klienta`)
    REFERENCES `mydb`.`klient` (`id_klienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_klient-kula_kule1`
    FOREIGN KEY (`kule_id_kuli`)
    REFERENCES `mydb`.`kule` (`id_kuli`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`klient-tor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`klient-tor` (
  `klient_id_klienta` INT NOT NULL,
  `tory_id_toru` INT NOT NULL,
  PRIMARY KEY (`klient_id_klienta`, `tory_id_toru`),
  INDEX `fk_klient-tor_tory1_idx` (`tory_id_toru` ASC) VISIBLE,
  CONSTRAINT `fk_klient-tor_klient1`
    FOREIGN KEY (`klient_id_klienta`)
    REFERENCES `mydb`.`klient` (`id_klienta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_klient-tor_tory1`
    FOREIGN KEY (`tory_id_toru`)
    REFERENCES `mydb`.`tory` (`id_toru`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- procedure wizytowka_gracza
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE wizytowka_gracza(IN id INT, OUT przedstawienie VARCHAR(255))
BEGIN
SELECT concat('Dane_gracza', k.imie, ' ', k.nazwisko,' ',datediff(now()-k.data_urodzenia) as wiek,' ',k.kolor as kolor_kuli,'.') INTO przedstawienie from klient as k INNER JOIN kule as k ON klient_id_klienta=kule_id_kuli where id_klienta=id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function ilosc_torow_dla_dzieci
-- -----------------------------------------------------

DELIMITER $$
USE `mydb`$$
CREATE FUNCTION ilosc_torow_dla_dzieci()
RETURNS INTEGER
BEGIN
  DECLARE ilosc INT;
  SELECT COUNT(*) INTO @ilosc FROM tory where bandy='TAK' AND dlugosc<20 ;
  RETURN @ilosc;
END$$

DELIMITER ;
USE `mydb`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`klient_AFTER_INSERT` 
AFTER INSERT ON `klient`
FOR EACH ROW
BEGIN
IF year(now())-year(data_urodzenia)<10 
THEN SET udzwig=0;
end if;
END$$

USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`tory_AFTER_INSERT` 
AFTER INSERT ON `tory`
FOR EACH ROW
BEGIN
IF year(now())-year(klient.data_urodzenia)<20
THEN SET bandy="TAK";
END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
