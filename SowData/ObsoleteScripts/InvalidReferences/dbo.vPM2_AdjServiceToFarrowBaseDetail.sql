



-- 20130624 smr change 115 to 119
-- 20130712 smr change the (wd.WeekofDate - 109) to (wd.WeekofDate - 113)

CREATE VIEW [dbo].[vPM2_AdjServiceToFarrowBaseDetail] (FarmID, WeekOfDate, SowID, SowGenetics, SowParity)
	As
 SELECT sme.FarmID, wd.WeekOfDate, sme.SowId, sme.SowGenetics, sme.SowParity
	FROM WeekDefinitionTemp wd WITH (NOLOCK)
	LEFT JOIN SowMatingEventTemp sme WITH (NOLOCK)ON sme.EventDate Between (wd.WeekOfDate - 119) And (wd.WeekofDate - 113)
	-----  This code has been added to take out Sows that are culled because of DEPOPULATION  -------
	--left join (select * from SowRemoveEvent with (Nolock)
	--where PrimaryReason in ('DEPOP','DEPOPULATION')
	----This is the date where the DEPOPULATION reason in the removal data is valid
	--and EventDate >= '10/4/2009'
	----Just a guess for when the depopulation will be done.
	--and EventDate <= '12/12/2009') re
	--New code added 11/25/2010 to take out C55 depops. John Maas
	left join (select * from SowRemoveEvent with (Nolock)
	where (PrimaryReason in ('DEPOP','DEPOPULATION')
	--This is the date where the DEPOPULATION reason in the removal data is valid
	and EventDate >= '10/4/2009'
	--This is when the depopulation will be done.
	and EventDate <= '12/5/2009') OR
	(PrimaryReason in ('DEPOP','DEPOPULATION')
	--This is the date and Farm where the DEPOPULATION happened for C55 in early November 2010
	and FarmID = 'C55OLD3'
	and EventDate >= '11/2/2010'
	and EventDate <= '11/5/2010')	
	) re	
	on sme.FarmID=re.FarmID
	and sme.SowID=re.SowID
	and sme.SowParity=re.SowParity
	-----  End of code for Sows that are culled because of DEPOPULATION  -------
	WHERE sme.MatingNbr = 1 
-- 20130722 phone conversation with Jayne from [$(PigCHAMP)].  they look at actual farrow numbers when they calculate adjusted farrow rate.
-- they do not do what is being done in the next section of the code.  (estimate and exclude farrowing sows)
		AND sme.SowID Not In(SELECT Distinct SowID FROM SowFarrowEventTemp WITH (NOLOCK)
			Where FarmID = sme.FarmID 
			AND SowID = sme.SowID 
			AND (
				(EventDate Between (wd.WeekOfDate - 7) AND (wd.WeekOfDate-1)) 
				 OR
			     	(EventDate Between (wd.WeekOfDate + 7) AND (wd.WeekOfDate+13)) 
			)) 
	-----  This code has been added to take out Sows that are culled because of DEPOPULATION  -------
			and re.PrimaryReason is null
 	-----  End of code for Sows that are culled because of DEPOPULATION  -------
UNION
 SELECT sfe.FarmID, sfe.WeekOfDate, sfe.SowID, sfe.SowGenetics, sfe.SowParity
	FROM SowFarrowEventTemp sfe WITH (NOLOCK)










