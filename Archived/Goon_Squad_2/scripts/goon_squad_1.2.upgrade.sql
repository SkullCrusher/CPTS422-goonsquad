SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE `goon_squad`.`users` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;
SET FOREIGN_KEY_CHECKS=1;