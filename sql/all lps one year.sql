SELECT
	name AS 'LPS',
	nace_code || ': ' || nace_text AS 'NACE (DELETE!)',
	prtr_key AS 'PRTR activity (DELETE!)',
	prtr_key AS 'GNFR (TODO)',
	administrative_number AS 'E-PRTR/PRTR Facility ID',
	'' AS 'Height class (TODO)',
	wgs84_x AS 'Longitude', wgs84_y AS 'Latitude',
	SUM(annual_load / 1000000) FILTER (WHERE substance_name = 'Nitrogen oxides (NOx/NO2)') AS 'NOx (as NO2) [kt]',
	SUM(annual_load / 1000000) FILTER (WHERE substance_name = 'Sulphur oxides (SOx/SO2)') AS 'NMVOC [kt]',
	SUM(annual_load / 1000000) FILTER (WHERE substance_name = 'Non-methane volatile organic compounds (NMVOC)') AS 'SOx (as SO2) [kt]',
	SUM(annual_load / 1000000) FILTER (WHERE substance_name = 'Ammonia (NH3)') AS 'NH3 [kt]',
	SUM(annual_load / 1000000) FILTER (WHERE substance_name = 'Particulate matter (PM2.5)') AS 'PM2.5 [kt]',
	SUM(annual_load / 1000000) FILTER (WHERE substance_name = 'Particulate matter (PM10)') AS 'PM10 [kt]',
	SUM(annual_load / 1000000) FILTER (WHERE substance_name = 'Carbon monoxide (CO)') AS 'CO [kt]',
	SUM(annual_load / 1000) FILTER (WHERE substance_name = 'Lead and compounds (as Pb)') AS 'Pb [t]',
	SUM(annual_load / 1000) FILTER (WHERE substance_name = 'Cadmium and compounds (as Cd)') AS 'Cd [t]',
	SUM(annual_load / 1000) FILTER (WHERE substance_name = 'Mercury and compounds (as Hg)') AS 'Hg [t]',
	SUM(annual_load * 1000) FILTER (WHERE substance_name = 'PCDD + PCDF (dioxins + furans) (as Teq)') AS 'PCDD/ PCDF (dioxins/ furans) [g I-Teq]',
	SUM(annual_load / 1000) FILTER (WHERE substance_name = 'Polycyclic aromatic hydrocarbons (PAHs)') AS 'PAHs [t]',
	SUM(annual_load) FILTER (WHERE substance_name = 'Hexachlorobenzene (HCB)') AS 'HCB [kg]',
	SUM(annual_load) FILTER (WHERE substance_name = 'Polychlorinated biphenyls (PCBs)') AS 'PCBs [kg]'
FROM (
	SELECT facilities.id, name, nace_code, nace_text, prtr_key, wgs84_x, wgs84_y, administrative_number, substance_name, annual_load
	FROM facilities
	INNER JOIN activities ON facilities.id = activities.facility_id
	INNER JOIN releases ON facilities.id = releases.facility_id
	WHERE facilities.year = 2018 and releases.compartment = 'Air')
GROUP BY id
ORDER BY name