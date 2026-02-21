-- Insert divisions into the divisions table
-- This script populates the divisions with NCAA, NAIA, and other governing bodies

-- NWAC are two year universities/colleges
-- NJCAA is a mix of community college, technical schools, and junior colleges
-- NCCAA is a mix of Christian colleges and universities, some of which are also members of NCAA or NAIA
-- USCAA is a mix of community/junior colleges

-- Collectively, the schools in these categories do not really fit into the structure of NCAA divisions,
-- their "conferences" are not clearly defined or easily accessible, and they do not have a large presence in 
-- track and field, so I am leaving them out entirely.
-- A similar argument could be made for NAIA, but I am including it because it is a well-known governing body 
-- with a significant presence in track and field i.e. still highly competitive times, and often 4 year institutions.


USE `ncaa_track`;

INSERT INTO `divisions` (`division_id`, `name`, `abbreviation`) VALUES
(1, 'National Collegiate Athletic Association Division I', 'NCAA Div. I'),
(2, 'National Collegiate Athletic Association Division II', 'NCAA Div. II'),
(3, 'National Collegiate Athletic Association Division III', 'NCAA Div. III'),
(4, 'National Association of Intercollegiate Athletics', 'NAIA');


-- (5, 'National Junior College Athletic Association', 'NJCAA'),
-- (6, 'National Christian College Athletic Association', 'NCCAA'),
-- (7, 'Northwest Athletic Association of Community Colleges', 'NWAC'),
-- (8, 'United States Collegiate Athletic Association', 'USCAA')
