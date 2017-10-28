
--*************************************************************
--	Purpose:Milage Tracking
--	Author: Matt Dawson
--	Date: 7/30/2007
--	Usage:  
--	Parms:
--  Mantis Ticket :  514
--*************************************************************


CREATE      View [dbo].[cfvSvcEquiMileage]
AS
select 	rd.User5 As ContactID, 
	ct.ContactName, 
	eq.equipid, eq.descr, 
	FirstReadValue=(Select Min(Reading) from smsvcreadings where equipid=eq.equipid and User5=rd.user5 and ReadDate>='10/1/2007' Group by equipid, user5),
	FirstReadDate=(Select Min(ReadDate) from smsvcreadings where equipid=eq.equipid and User5=rd.user5 and ReadDate>='10/1/2007' Group by equipid, user5),
	LastReadValue=(Select Max(Reading) from smsvcreadings where equipid=eq.equipid and User5=rd.user5 and ReadDate<='9/30/2008' Group by equipid, user5),
	LastReadDate=(Select Max(ReadDate) from smsvcreadings where equipid=eq.equipid and User5=rd.user5 and ReadDate<='9/30/2008' Group by equipid, user5),
	PersonalMiles=Sum(Convert(NUMERIC(7,2),rd.user3)),
	MileageReimburse=Sum(Convert(NUMERIC(7,2),rd.User4))
from smsvcreadings rd
JOIN smsvcequipment eq 
	on rd.equipid=eq.equipid
JOIN cftContact ct 
	on rd.user5=ct.ContactID
--WHERE rd.ReadDate BETWEEN '10/1/2007' AND '9/30/2008'
Group by 
	rd.User5, 
	eq.equipid, 
	ct.ContactName, 
	eq.descr
