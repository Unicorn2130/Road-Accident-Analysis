select * from road_accid;

select count(*) from road_accid;

-- PRIMARY KPIs

-- Finding Current Year Casualties
select sum(number_of_casualties) as CY_casualties
from road_accid
where year(accident_date)='2022';

-- No of accidents 
select count(DISTINCT accident_index) as CY_Accidents
from road_accid
where year(accident_date)='2022';

-- No of fatal casualities
select SUM(number_of_casualties) as CY_Fatal_casualties
from road_accid
where year(accident_date)='2022' AND accident_severity='Fatal';

-- No of Serious casualities
select SUM(number_of_casualties) as CY_Fatal_casualties
from road_accid
where year(accident_date)='2022' AND accident_severity='Serious';

-- No of Slight casualities
select SUM(number_of_casualties) as CY_Fatal_casualties
from road_accid
where year(accident_date)='2022' AND accident_severity='Slight';

select (ROUND((SUM(number_of_casualties)*100/(select sum(number_of_casualties) from road_accid)),2) ) as CY_Fatal_casualties
from road_accid
where accident_severity='Slight';

-- SECONDARY KPIs

-- No of casualties by vehicle type

     -- grouping the vehicles
SELECT
	CASE
		WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricultural'
        WHEN vehicle_type IN ('Car','Taxi/Private hire car') THEN 'Cars'
        WHEN vehicle_type IN ('Motorcycle 125cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle 50cc and under','Motorcycle over 500cc') THEN 'Bike'
        WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)','Minibus (8 - 16 passenger seats)') THEN 'Bus'
        WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
        ELSE 'Other'
	END as Vehicle_group,
SUM(number_of_casualties) as CY_Casualties
FROM road_accid        
-- WHERE YEAR(accident_date)='2022'
GROUP BY 
   CASE
		WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricultural'
        WHEN vehicle_type IN ('Car','Taxi/Private hire car') THEN 'Cars'
        WHEN vehicle_type IN ('Motorcycle 125cc and under','Motorcycle over 125cc and up to 500cc','Motorcycle 50cc and under','Motorcycle over 500cc') THEN 'Bike'
        WHEN vehicle_type IN ('Bus or coach (17 or more pass seats)','Minibus (8 - 16 passenger seats)') THEN 'Bus'
        WHEN vehicle_type IN ('Goods 7.5 tonnes mgw and over','Goods over 3.5t. and under 7.5t','Van / Goods 3.5 tonnes mgw or under') THEN 'Van'
        ELSE 'Other'
	END;

-- Month-wise casualties
SELECT MONTH(accident_date) as month_name,sum(number_of_casualties) as CY_Casualties
FROM road_accid
WHERE YEAR(accident_date)='2022'
GROUP BY MONTH(accident_date);

-- casualties by road type 
SELECT road_type, SUM(number_of_casualties) as CY_Casualties
FROM road_accid
WHERE YEAR(accident_date)='2022'
GROUP BY road_type
order by CY_Casualties desc;

-- casualties by urban or rural area
SELECT urban_or_rural_area,SUM(number_of_casualties) as Total_casualties,SUM(number_of_casualties)*100/ (SELECT SUM(number_of_casualties) FROM road_accid WHERE YEAR(accident_date)='2022' )as CY_Casualties
FROM road_accid
WHERE YEAR(accident_date)='2022'
GROUP BY urban_or_rural_area;

-- No of casulaties by light conditions
select 
	Case
		when light_conditions in ('Darkness - lights lit','Darkness - lighting unknown','Darkness - lights unlit','Darkness - no lighting') then 'Darkness'
		else 'Day'
    End as light_condition,
    sum(number_of_casualties) as CY_Casualties
	
from road_accid
where year(accident_date)='2022'
group by light_condition;