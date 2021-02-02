SELECT name, year, prtr_key, wgs84_x, wgs84_y,
	SUM(annual_load) FILTER (WHERE substance_name like 'Arsen%') Arsen,
	SUM(annual_load) FILTER (WHERE substance_name like 'Carbon dioxide%') CO2,
	SUM(annual_load) FILTER (WHERE substance_name like 'Sulphur%') SO2
FROM (
	SELECT facilities.id, facilities.name, facilities.wgs84_x, facilities.wgs84_y, activities.prtr_key, releases.year, releases.substance_name, releases.annual_load, releases.unit
	FROM facilities 
	INNER JOIN releases ON facilities.id = releases.facility_id
	INNER JOIN activities ON facilities.id = activities.facility_id
	WHERE facilities.name like '%Lippendorf%'
	)
GROUP BY year
ORDER BY year