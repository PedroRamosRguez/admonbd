-- MySQL Script generated by MySQL Workbench
-- 01/23/17 10:18:16
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema LuzBD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LuzBD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LuzBD` DEFAULT CHARACTER SET utf8 ;
USE `LuzBD` ;

-- -----------------------------------------------------
-- Table `LuzBD`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`PERSONA` (
  `DNI` VARCHAR(9) NOT NULL,
  `Nombre_apellidos` VARCHAR(65) NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`ZONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`ZONA` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Municipio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nombre`, `Municipio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`EDIFICIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`EDIFICIO` (
  `Calle` VARCHAR(45) NOT NULL,
  `Numero` INT NOT NULL,
  `Codigo_postal` INT NOT NULL,
  `ZONA_Nombre` VARCHAR(45) NOT NULL,
  `ZONA_Municipio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Calle`, `Numero`, `Codigo_postal`, `ZONA_Nombre`, `ZONA_Municipio`),
  INDEX `fk_EDIFICIO_ZONA1_idx` (`ZONA_Nombre` ASC, `ZONA_Municipio` ASC),
  CONSTRAINT `fk_EDIFICIO_ZONA1`
    FOREIGN KEY (`ZONA_Nombre` , `ZONA_Municipio`)
    REFERENCES `LuzBD`.`ZONA` (`Nombre` , `Municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`BLOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`BLOQUE` (
  `Letra` VARCHAR(1) NULL,
  `Edificio_Calle` VARCHAR(45) NOT NULL,
  `Edificio_Numero` INT NOT NULL,
  `Edificio_Codigo_postal` INT NOT NULL,
  PRIMARY KEY (`Edificio_Calle`, `Edificio_Numero`, `Edificio_Codigo_postal`),
  CONSTRAINT `fk_BLOQUE_Edificio`
    FOREIGN KEY (`Edificio_Calle` , `Edificio_Numero` , `Edificio_Codigo_postal`)
    REFERENCES `LuzBD`.`EDIFICIO` (`Calle` , `Numero` , `Codigo_postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`UNIFAMILIAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`UNIFAMILIAR` (
  `EDIFICIO_Calle` VARCHAR(45) NOT NULL,
  `EDIFICIO_Numero` INT NOT NULL,
  `EDIFICIO_Codigo_postal` INT NOT NULL,
  `PERSONA_DNI` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`EDIFICIO_Calle`, `EDIFICIO_Numero`, `EDIFICIO_Codigo_postal`, `PERSONA_DNI`),
  INDEX `fk_UNIFAMILIAR_PERSONA1_idx` (`PERSONA_DNI` ASC),
  CONSTRAINT `fk_UNIFAMILIAR_EDIFICIO1`
    FOREIGN KEY (`EDIFICIO_Calle` , `EDIFICIO_Numero` , `EDIFICIO_Codigo_postal`)
    REFERENCES `LuzBD`.`EDIFICIO` (`Calle` , `Numero` , `Codigo_postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UNIFAMILIAR_PERSONA1`
    FOREIGN KEY (`PERSONA_DNI`)
    REFERENCES `LuzBD`.`PERSONA` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`VIVIENDA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`VIVIENDA` (
  `BLOQUE_Edificio_Calle` VARCHAR(45) NOT NULL,
  `BLOQUE_Edificio_Numero` INT NOT NULL,
  `BLOQUE_Edificio_Codigo_postal` INT NOT NULL,
  `PERSONA_DNI` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`BLOQUE_Edificio_Calle`, `BLOQUE_Edificio_Numero`, `BLOQUE_Edificio_Codigo_postal`, `PERSONA_DNI`),
  INDEX `fk_VIVIENDA_PERSONA1_idx` (`PERSONA_DNI` ASC),
  CONSTRAINT `fk_VIVIENDA_BLOQUE1`
    FOREIGN KEY (`BLOQUE_Edificio_Calle` , `BLOQUE_Edificio_Numero` , `BLOQUE_Edificio_Codigo_postal`)
    REFERENCES `LuzBD`.`BLOQUE` (`Edificio_Calle` , `Edificio_Numero` , `Edificio_Codigo_postal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VIVIENDA_PERSONA1`
    FOREIGN KEY (`PERSONA_DNI`)
    REFERENCES `LuzBD`.`PERSONA` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`CONTRATO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`CONTRATO` (
  `N_identificador` INT NOT NULL AUTO_INCREMENT,
  `Fecha_inicio` DATE NOT NULL,
  `Contador` INT NOT NULL,
  `Fecha_final` DATE NULL,
  `Consumo` INT NULL,
  `Tipo_contrato` ENUM('NOCHE', '8HORAS', 'FINDE') NULL,
  PRIMARY KEY (`N_identificador`, `Fecha_inicio`, `Contador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`CONTRATO_UNIFAMILIAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`CONTRATO_UNIFAMILIAR` (
  `CONTRATO_N_identificador` INT NOT NULL,
  `CONTRATO_Fecha_inicio` DATE NOT NULL,
  `CONTRATO_Contador` INT NOT NULL,
  `UNIFAMILIAR_EDIFICIO_Calle` VARCHAR(45) NOT NULL,
  `UNIFAMILIAR_EDIFICIO_Numero` INT NOT NULL,
  `UNIFAMILIAR_EDIFICIO_Codigo_postal` INT NOT NULL,
  `UNIFAMILIAR_PERSONA_DNI` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`CONTRATO_N_identificador`, `CONTRATO_Fecha_inicio`, `CONTRATO_Contador`, `UNIFAMILIAR_EDIFICIO_Calle`, `UNIFAMILIAR_EDIFICIO_Numero`, `UNIFAMILIAR_EDIFICIO_Codigo_postal`, `UNIFAMILIAR_PERSONA_DNI`),
  INDEX `fk_CONTRATO_UNIFAMILIAR_UNIFAMILIAR1_idx` (`UNIFAMILIAR_EDIFICIO_Calle` ASC, `UNIFAMILIAR_EDIFICIO_Numero` ASC, `UNIFAMILIAR_EDIFICIO_Codigo_postal` ASC, `UNIFAMILIAR_PERSONA_DNI` ASC),
  CONSTRAINT `fk_CONTRATO_BLOQUE_CONTRATO1`
    FOREIGN KEY (`CONTRATO_N_identificador` , `CONTRATO_Fecha_inicio` , `CONTRATO_Contador`)
    REFERENCES `LuzBD`.`CONTRATO` (`N_identificador` , `Fecha_inicio` , `Contador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTRATO_UNIFAMILIAR_UNIFAMILIAR1`
    FOREIGN KEY (`UNIFAMILIAR_EDIFICIO_Calle` , `UNIFAMILIAR_EDIFICIO_Numero` , `UNIFAMILIAR_EDIFICIO_Codigo_postal` , `UNIFAMILIAR_PERSONA_DNI`)
    REFERENCES `LuzBD`.`UNIFAMILIAR` (`EDIFICIO_Calle` , `EDIFICIO_Numero` , `EDIFICIO_Codigo_postal` , `PERSONA_DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`CONTRATO_BLOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`CONTRATO_BLOQUE` (
  `CONTRATO_N_identificador` INT NOT NULL,
  `CONTRATO_Fecha_inicio` DATE NOT NULL,
  `CONTRATO_Contador` INT NOT NULL,
  `VIVIENDA_BLOQUE_Edificio_Calle` VARCHAR(45) NOT NULL,
  `VIVIENDA_BLOQUE_Edificio_Numero` INT NOT NULL,
  `VIVIENDA_BLOQUE_Edificio_Codigo_postal` INT NOT NULL,
  `VIVIENDA_PERSONA_DNI` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`CONTRATO_N_identificador`, `CONTRATO_Fecha_inicio`, `CONTRATO_Contador`, `VIVIENDA_BLOQUE_Edificio_Calle`, `VIVIENDA_BLOQUE_Edificio_Numero`, `VIVIENDA_BLOQUE_Edificio_Codigo_postal`, `VIVIENDA_PERSONA_DNI`),
  INDEX `fk_CONTRATO_BLOQUE_VIVIENDA1_idx` (`VIVIENDA_BLOQUE_Edificio_Calle` ASC, `VIVIENDA_BLOQUE_Edificio_Numero` ASC, `VIVIENDA_BLOQUE_Edificio_Codigo_postal` ASC, `VIVIENDA_PERSONA_DNI` ASC),
  CONSTRAINT `fk_CONTRATO_BLOQUE_CONTRATO2`
    FOREIGN KEY (`CONTRATO_N_identificador` , `CONTRATO_Fecha_inicio` , `CONTRATO_Contador`)
    REFERENCES `LuzBD`.`CONTRATO` (`N_identificador` , `Fecha_inicio` , `Contador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTRATO_BLOQUE_VIVIENDA1`
    FOREIGN KEY (`VIVIENDA_BLOQUE_Edificio_Calle` , `VIVIENDA_BLOQUE_Edificio_Numero` , `VIVIENDA_BLOQUE_Edificio_Codigo_postal` , `VIVIENDA_PERSONA_DNI`)
    REFERENCES `LuzBD`.`VIVIENDA` (`BLOQUE_Edificio_Calle` , `BLOQUE_Edificio_Numero` , `BLOQUE_Edificio_Codigo_postal` , `PERSONA_DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`SUBCONTRATA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`SUBCONTRATA` (
  `CIF` VARCHAR(9) NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `ZONA_Nombre` VARCHAR(45) NOT NULL,
  `ZONA_Municipio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CIF`, `ZONA_Nombre`, `ZONA_Municipio`),
  INDEX `fk_SUBCONTRATA_ZONA1_idx` (`ZONA_Nombre` ASC, `ZONA_Municipio` ASC),
  CONSTRAINT `fk_SUBCONTRATA_ZONA1`
    FOREIGN KEY (`ZONA_Nombre` , `ZONA_Municipio`)
    REFERENCES `LuzBD`.`ZONA` (`Nombre` , `Municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`TORRETA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`TORRETA` (
  `N_identificador` INT NOT NULL AUTO_INCREMENT,
  `Voltaje` FLOAT NULL,
  `Altura` FLOAT NULL,
  `ZONA_Nombre` VARCHAR(45) NOT NULL,
  `ZONA_Municipio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`N_identificador`, `ZONA_Nombre`, `ZONA_Municipio`),
  INDEX `fk_TORRETA_ZONA1_idx` (`ZONA_Nombre` ASC, `ZONA_Municipio` ASC),
  CONSTRAINT `fk_TORRETA_ZONA1`
    FOREIGN KEY (`ZONA_Nombre` , `ZONA_Municipio`)
    REFERENCES `LuzBD`.`ZONA` (`Nombre` , `Municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`TRANSFORMADOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`TRANSFORMADOR` (
  `Tipo_tansformador` INT NULL,
  `Voltaje_soportado` VARCHAR(45) NULL,
  `ZONA_Nombre` VARCHAR(45) NOT NULL,
  `ZONA_Municipio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ZONA_Nombre`, `ZONA_Municipio`),
  CONSTRAINT `fk_TRANSFORMADOR_ZONA1`
    FOREIGN KEY (`ZONA_Nombre` , `ZONA_Municipio`)
    REFERENCES `LuzBD`.`ZONA` (`Nombre` , `Municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`MANTENIMIENTO` (
  `Identificador` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(200) NULL,
  `Informe` VARCHAR(200) NULL,
  PRIMARY KEY (`Identificador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`CONTROLA_TRANSFORMADOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`CONTROLA_TRANSFORMADOR` (
  `Fecha_hora` DATETIME NOT NULL,
  `TRANSFORMADOR_ZONA_Nombre` VARCHAR(45) NOT NULL,
  `TRANSFORMADOR_ZONA_Municipio` VARCHAR(45) NOT NULL,
  `MANTENIMIENTO_Identificador` INT NOT NULL,
  PRIMARY KEY (`Fecha_hora`, `TRANSFORMADOR_ZONA_Nombre`, `TRANSFORMADOR_ZONA_Municipio`, `MANTENIMIENTO_Identificador`),
  INDEX `fk_CONTROLA_TRANSFORMADOR_TRANSFORMADOR1_idx` (`TRANSFORMADOR_ZONA_Nombre` ASC, `TRANSFORMADOR_ZONA_Municipio` ASC),
  INDEX `fk_CONTROLA_TRANSFORMADOR_MANTENIMIENTO1_idx` (`MANTENIMIENTO_Identificador` ASC),
  CONSTRAINT `fk_CONTROLA_TRANSFORMADOR_TRANSFORMADOR1`
    FOREIGN KEY (`TRANSFORMADOR_ZONA_Nombre` , `TRANSFORMADOR_ZONA_Municipio`)
    REFERENCES `LuzBD`.`TRANSFORMADOR` (`ZONA_Nombre` , `ZONA_Municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTROLA_TRANSFORMADOR_MANTENIMIENTO1`
    FOREIGN KEY (`MANTENIMIENTO_Identificador`)
    REFERENCES `LuzBD`.`MANTENIMIENTO` (`Identificador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`CONTROLA_TORRETA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`CONTROLA_TORRETA` (
  `Fecha_hora` DATETIME NOT NULL,
  `TORRETA_N_identificador` INT NOT NULL,
  `TORRETA_ZONA_Nombre` VARCHAR(45) NOT NULL,
  `TORRETA_ZONA_Municipio` VARCHAR(45) NOT NULL,
  `MANTENIMIENTO_Identificador` INT NOT NULL,
  PRIMARY KEY (`Fecha_hora`, `TORRETA_N_identificador`, `TORRETA_ZONA_Nombre`, `TORRETA_ZONA_Municipio`, `MANTENIMIENTO_Identificador`),
  INDEX `fk_CONTROLA_TORRETA_TORRETA1_idx` (`TORRETA_N_identificador` ASC, `TORRETA_ZONA_Nombre` ASC, `TORRETA_ZONA_Municipio` ASC),
  INDEX `fk_CONTROLA_TORRETA_MANTENIMIENTO1_idx` (`MANTENIMIENTO_Identificador` ASC),
  CONSTRAINT `fk_CONTROLA_TORRETA_TORRETA1`
    FOREIGN KEY (`TORRETA_N_identificador` , `TORRETA_ZONA_Nombre` , `TORRETA_ZONA_Municipio`)
    REFERENCES `LuzBD`.`TORRETA` (`N_identificador` , `ZONA_Nombre` , `ZONA_Municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONTROLA_TORRETA_MANTENIMIENTO1`
    FOREIGN KEY (`MANTENIMIENTO_Identificador`)
    REFERENCES `LuzBD`.`MANTENIMIENTO` (`Identificador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`REPARACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`REPARACION` (
  `MANTENIMIENTO_Identificador` INT NOT NULL,
  `SUBCONTRATA_CIF` VARCHAR(9) NOT NULL,
  `SUBCONTRATA_ZONA_Nombre` VARCHAR(45) NOT NULL,
  `SUBCONTRATA_ZONA_Municipio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MANTENIMIENTO_Identificador`, `SUBCONTRATA_CIF`, `SUBCONTRATA_ZONA_Nombre`, `SUBCONTRATA_ZONA_Municipio`),
  INDEX `fk_Reparacion_SUBCONTRATA1_idx` (`SUBCONTRATA_CIF` ASC, `SUBCONTRATA_ZONA_Nombre` ASC, `SUBCONTRATA_ZONA_Municipio` ASC),
  CONSTRAINT `fk_Reparacion_MANTENIMIENTO1`
    FOREIGN KEY (`MANTENIMIENTO_Identificador`)
    REFERENCES `LuzBD`.`MANTENIMIENTO` (`Identificador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reparacion_SUBCONTRATA1`
    FOREIGN KEY (`SUBCONTRATA_CIF` , `SUBCONTRATA_ZONA_Nombre` , `SUBCONTRATA_ZONA_Municipio`)
    REFERENCES `LuzBD`.`SUBCONTRATA` (`CIF` , `ZONA_Nombre` , `ZONA_Municipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`OPERARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`OPERARIO` (
  `DNI` VARCHAR(9) NOT NULL,
  `Nombre_apellidos` VARCHAR(65) NULL,
  `Salario` FLOAT NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LuzBD`.`REVISION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LuzBD`.`REVISION` (
  `OPERARIO_DNI` VARCHAR(9) NOT NULL,
  `MANTENIMIENTO_Identificador` INT NOT NULL,
  PRIMARY KEY (`OPERARIO_DNI`, `MANTENIMIENTO_Identificador`),
  INDEX `fk_REVISION_MANTENIMIENTO1_idx` (`MANTENIMIENTO_Identificador` ASC),
  CONSTRAINT `fk_REVISION_OPERARIO1`
    FOREIGN KEY (`OPERARIO_DNI`)
    REFERENCES `LuzBD`.`OPERARIO` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_REVISION_MANTENIMIENTO1`
    FOREIGN KEY (`MANTENIMIENTO_Identificador`)
    REFERENCES `LuzBD`.`MANTENIMIENTO` (`Identificador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `LuzBD`;

DELIMITER $$
USE `LuzBD`$$
CREATE DEFINER = CURRENT_USER TRIGGER `LuzBD`.`PERSONA_BEFORE_INSERT` BEFORE INSERT ON `PERSONA` FOR EACH ROW
 
BEGIN
	IF (NEW.DNI REGEXP '^[0-9]{8}[aA-zZ]$') = 0 THEN
		signal sqlstate '12345'
			SET message_text = 'DNI incorrecto';
	END IF;
END$$

USE `LuzBD`$$
CREATE DEFINER = CURRENT_USER TRIGGER `LuzBD`.`CONTRATO_BEFORE_INSERT` BEFORE INSERT ON `CONTRATO` FOR EACH ROW
BEGIN
	SET NEW.Fecha_final = NULL;
END$$

USE `LuzBD`$$
CREATE DEFINER = CURRENT_USER TRIGGER `LuzBD`.`SUBCONTRATA_BEFORE_INSERT` BEFORE INSERT ON `SUBCONTRATA` FOR EACH ROW
BEGIN
	IF (NEW.DNI REGEXP '^[aA-zZ][0-9]{8}$') = 0 THEN
		signal sqlstate '12345'
			SET message_text = 'CIF incorrecto';
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
