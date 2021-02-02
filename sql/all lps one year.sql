SELECT
	name,
	prtr_key AS 'GNFR (TODO)',
	administrative_number AS 'E-PRTR ID',
	'' AS 'Height class (TODO)',
	wgs84_x, wgs84_y,
	SUM(annual_load) FILTER (WHERE substance_name like 'Arsen%') AS "Arsen (kg)",
	SUM(annual_load / 1000000) FILTER (WHERE substance_name like 'Carbon dioxide%') AS "CO2 (kt)",
	SUM(annual_load / 1000) FILTER (WHERE substance_name like 'Sulphur%') AS "SO2 (t)"
FROM (
	SELECT facilities.id, name, prtr_key, wgs84_x, wgs84_y, administrative_number, releases.year, substance_name, annual_load, releases.unit
	FROM facilities
	INNER JOIN activities ON facilities.id = activities.facility_id
	INNER JOIN releases ON facilities.id = releases.facility_id
	WHERE releases.year = 2018)
GROUP BY id
/* ORDER BY name */
ORDER BY "SO2 (t)" DESC