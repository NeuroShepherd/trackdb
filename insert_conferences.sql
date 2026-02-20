-- Insert NCAA Division I conferences into the conferences table
-- Excludes track-only organizing groups (e.g., IC4A/ECAC, NEICAAA)

USE `ncaa_track`;

INSERT INTO `conferences` (`division_id`, `name`, `abbreviation`) VALUES
(1, 'Atlantic Coast Conference', 'ACC'),
(1, 'American Conference', 'American'),
(1, 'ASUN Conference', 'ASUN'),
(1, 'America East Conference', 'America East'),
(1, 'Atlantic 10 Conference', 'A-10'),
(1, 'BIG EAST Conference', 'Big East'),
(1, 'Big 12 Conference', 'Big 12'),
(1, 'Big Sky Conference', 'Big Sky'),
(1, 'Big South Conference', 'Big South'),
(1, 'Big Ten Conference', 'Big Ten'),
(1, 'Big West Conference', 'Big West'),
(1, 'Coastal Athletic Association', 'CAA'),
(1, 'Conference USA', 'C-USA'),
(1, 'Horizon League', 'Horizon'),
(1, 'Ivy League', 'Ivy'),
(1, 'Metro Atlantic Athletic Conference', 'MAAC'),
(1, 'Mid-American Conference', 'MAC'),
(1, 'Mid-Eastern Athletic Conference', 'MEAC'),
(1, 'Missouri Valley Conference', 'MVC'),
(1, 'Mountain West Conference', 'MW'),
(1, 'Northeast Conference', 'NEC'),
(1, 'Ohio Valley Conference', 'OVC'),
(1, 'Pacific-12 Conference', 'Pac-12'),
(1, 'Patriot League', 'Patriot'),
(1, 'Southeastern Conference', 'SEC'),
(1, 'Southern Conference', 'SoCon'),
(1, 'Southland Conference', 'Southland'),
(1, 'Southwestern Athletic Conference', 'SWAC'),
(1, 'Summit League', 'Summit'),
(1, 'Sun Belt Conference', 'Sun Belt'),
(1, 'Western Athletic Conference', 'WAC');
