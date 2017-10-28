

CREATE  VIEW [dbo].[vCF401Miles]

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
	cftMilesMatrix mx (nolock)  -- 201303 sripley nolock hint
	join vCF401Mills ml on mx.AddressIDFrom = ml.AddressID
	JOIN cftContactAddress ca (nolock)  ON mx.addressIDTO = ca.AddressID and ca.AddressTypeID= 1-- 201303 sripley nolock hint
	JOIN cftContact c (nolock)  ON c.ContactID = ca.ContactID -- 201303 sripley nolock hint



