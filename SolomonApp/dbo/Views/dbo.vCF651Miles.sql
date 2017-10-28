
CREATE VIEW vCF651Miles

	as
	Select AddressIDFrom,
	 AddressIDTo,
	 c.ContactID,
	 c.ContactName,
         MillID = ml.contactid,
	 OneWayHours,
	 OneWayMiles,
	 RestrictOneWayHours,
	 RestrictOneWayMiles
	from
	cftMilesMatrix mx
	join vCF401Mills ml on mx.AddressIDFrom = ml.AddressID
	JOIN cftContactAddress ca ON mx.addressIDTO = ca.AddressID and ca.AddressTypeID= 1
	JOIN cftContact c ON c.ContactID = ca.ContactID 

