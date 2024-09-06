CREATE DATABASE IF NOT EXISTS SHEIN;
USE SHEIN;

-- MySQL Workbench Synchronization
-- Generated: 2023-03-30 15:07
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: vvan 

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `SHEIN` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Company-SHEIN` (
  `Company_id` INT(11) NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Contact_Information` VARCHAR(45) NULL DEFAULT NULL,
  `City` VARCHAR(45) NULL DEFAULT NULL,
  `Province` VARCHAR(45) NULL DEFAULT NULL,
  `Street` VARCHAR(45) NULL DEFAULT NULL,
  `Postal_code` VARCHAR(45) NULL DEFAULT NULL,
  `Country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Company_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Employee_Login` (
  `Employee_lgin_id` INT(11) NOT NULL,
  `Password` INT(11) NULL DEFAULT NULL,
  `E_Employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`Employee_lgin_id`, `E_Employee_id`),
  INDEX `E_Employee_id_idx` (`E_Employee_id` ASC) VISIBLE,
  CONSTRAINT `E_Employee_id`
    FOREIGN KEY (`E_Employee_id`)
    REFERENCES `SHEIN`.`Employee` (`Employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Employee_Permission` (
  `Permission_id` INT(11) NOT NULL,
  `Permitted_module` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Permission_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Employee` (
  `Employee_id` INT(11) NOT NULL,
  `Name` VARCHAR(30) NULL DEFAULT NULL,
  `Mobile` VARCHAR(15) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Title` VARCHAR(45) NULL DEFAULT NULL,
  `C_id` INT(11) NOT NULL,
  PRIMARY KEY (`Employee_id`, `C_id`),
  INDEX `C_id _idx` (`C_id` ASC) VISIBLE,
  CONSTRAINT `C_id `
    FOREIGN KEY (`C_id`)
    REFERENCES `SHEIN`.`Company-SHEIN` (`Company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Payment` (
  `Transaction_id` INT(11) NOT NULL,
  `Billing_address` VARCHAR(45) NULL DEFAULT NULL,
  `Payment_amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `Transaction_date` DATETIME NULL DEFAULT NULL,
  `Payment_type` VARCHAR(45) NULL DEFAULT NULL,
  `C_Company_id` INT(11) NOT NULL,
  PRIMARY KEY (`Transaction_id`, `C_Company_id`),
  INDEX `C_Company_id_idx` (`C_Company_id` ASC) VISIBLE,
  CONSTRAINT `C_Company_id`
    FOREIGN KEY (`C_Company_id`)
    REFERENCES `SHEIN`.`Company-SHEIN` (`Company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Purchase_Order` (
  `Order_id` INT(11) NOT NULL,
  `Delivery_time` DATETIME NULL DEFAULT NULL,
  `Quantity` INT(11) NULL DEFAULT NULL,
  `Order_detail` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Product` (
  `Sku_id` INT(11) NOT NULL,
  `Type` VARCHAR(10) NULL DEFAULT NULL,
  `Color` VARCHAR(45) NULL DEFAULT NULL,
  `Size` VARCHAR(10) NULL DEFAULT NULL,
  `Unit_price` DECIMAL(6,2) NULL DEFAULT NULL,
  PRIMARY KEY (`Sku_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Supplier` (
  `Supplier_id` INT(11) NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Type` VARCHAR(20) NULL DEFAULT NULL,
  `County` VARCHAR(45) NULL DEFAULT NULL,
  `Province` VARCHAR(45) NULL DEFAULT NULL,
  `City` VARCHAR(45) NULL DEFAULT NULL,
  `Street` VARCHAR(45) NULL DEFAULT NULL,
  `Postal_code` VARCHAR(45) NULL DEFAULT NULL,
  `Bank_name` VARCHAR(45) NULL DEFAULT NULL,
  `Account_number` VARCHAR(45) NULL DEFAULT NULL,
  `First_name` VARCHAR(45) NULL DEFAULT NULL,
  `Last_name` VARCHAR(45) NULL DEFAULT NULL,
  `P_Transaction_id` INT(11) NOT NULL,
  PRIMARY KEY (`Supplier_id`, `P_Transaction_id`),
  INDEX `P_Transaction_id_idx` (`P_Transaction_id` ASC) VISIBLE,
  CONSTRAINT `P_Transaction_id`
    FOREIGN KEY (`P_Transaction_id`)
    REFERENCES `SHEIN`.`Payment` (`Transaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Employee_Has_Employee_Permission` (
  `E_Employee_id` INT(11) NOT NULL,
  `EP_Permission_id` INT(11) NOT NULL,
  PRIMARY KEY (`E_Employee_id`, `EP_Permission_id`),
  INDEX `fk_Employee_has_Employee_Permission_Employee_Permission1_idx` (`EP_Permission_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_has_Employee_Permission_Employee1`
    FOREIGN KEY (`E_Employee_id`)
    REFERENCES `SHEIN`.`Employee` (`Employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Employee_has_Employee_Permission_Employee_Permission1`
    FOREIGN KEY (`EP_Permission_id`)
    REFERENCES `SHEIN`.`Employee_Permission` (`Permission_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Employee_makes_Purchase_Order` (
  `E_Employee_id` INT(11) NOT NULL,
  `P_Order_Order_id` INT(11) NOT NULL,
  PRIMARY KEY (`E_Employee_id`, `P_Order_Order_id`),
  INDEX `fk_Employee_has_Purchase_Order_Purchase_Order1_idx` (`P_Order_Order_id` ASC) VISIBLE,
  INDEX `fk_Employee_has_Purchase_Order_Employee1_idx` (`E_Employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_has_Purchase_Order_Employee1`
    FOREIGN KEY (`E_Employee_id`)
    REFERENCES `SHEIN`.`Employee` (`Employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Employee_has_Purchase_Order_Purchase_Order1`
    FOREIGN KEY (`P_Order_Order_id`)
    REFERENCES `SHEIN`.`Purchase_Order` (`Order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Purchase_Order_Contains_Product` (
  `P_Order_id` INT(11) NOT NULL,
  `P_Sku_id` INT(11) NOT NULL,
  PRIMARY KEY (`P_Order_id`, `P_Sku_id`),
  INDEX `fk_Purchase_Order_has_Product_Product1_idx` (`P_Sku_id` ASC) VISIBLE,
  INDEX `fk_Purchase_Order_has_Product_Purchase_Order1_idx` (`P_Order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Purchase_Order_has_Product_Purchase_Order1`
    FOREIGN KEY (`P_Order_id`)
    REFERENCES `SHEIN`.`Purchase_Order` (`Order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Purchase_Order_has_Product_Product1`
    FOREIGN KEY (`P_Sku_id`)
    REFERENCES `SHEIN`.`Product` (`Sku_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `SHEIN`.`Supplier_has_Product` (
  `S_Supplier_id` INT(11) NOT NULL,
  `Product_Sku_id` INT(11) NOT NULL,
  PRIMARY KEY (`S_Supplier_id`, `Product_Sku_id`),
  INDEX `fk_Supplier_has_Product_Product1_idx` (`Product_Sku_id` ASC) VISIBLE,
  INDEX `fk_Supplier_has_Product_Supplier1_idx` (`S_Supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_Supplier_has_Product_Supplier1`
    FOREIGN KEY (`S_Supplier_id`)
    REFERENCES `SHEIN`.`Supplier` (`Supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Supplier_has_Product_Product1`
    FOREIGN KEY (`Product_Sku_id`)
    REFERENCES `SHEIN`.`Product` (`Sku_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO 





