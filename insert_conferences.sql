-- Load NCAA conferences from CSV file

USE `ncaa_track`;

LOAD DATA LOCAL INFILE 'conferences.csv'
INTO TABLE `conferences`
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS
(division_id, name, abbreviation);
