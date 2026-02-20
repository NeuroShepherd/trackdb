-- Insert divisions into the divisions table
-- This script populates the divisions with NCAA, NAIA, and other governing bodies

USE `ncaa_track`;

INSERT INTO `divisions` (`division_id`, `name`, `abbreviation`) VALUES
(1, 'National Collegiate Athletic Association Division I', 'NCAA Div. I'),
(2, 'National Collegiate Athletic Association Division II', 'NCAA Div. II'),
(3, 'National Collegiate Athletic Association Division III', 'NCAA Div. III'),
(4, 'National Association of Intercollegiate Athletics', 'NAIA'),
(5, 'National Junior College Athletic Association', 'NJCAA'),
(6, 'National Christian College Athletic Association', 'NCCAA'),
(7, 'Northwest Athletic Association of Community Colleges', 'NWAC'),
(8, 'United States Collegiate Athletic Association', 'USCAA');
