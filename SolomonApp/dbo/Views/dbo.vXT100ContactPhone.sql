--*************************************************************
--	Purpose:Contact's main numbers for transportation
--	Author: Charity Anderson
--	Date: 2/18/2005
--	Usage: Pig Flow 
--	Parms: (view
--	      
--*************************************************************

CREATE VIEW dbo.vXT100ContactPhone
	
AS

SELECT    c.ContactID, dbo.cftPhone.PhoneNbr
FROM    cftContact c WITH (NOLOCK) LEFT JOIN    
	dbo.cftContactPhone WITH (NOLOCK) on c.ContactID=cftContactPhone.ContactID
	JOIN
                      dbo.cftPhone ON dbo.cftContactPhone.PhoneID = dbo.cftPhone.PhoneID
WHERE     (dbo.cftContactPhone.PhoneTypeID = 7)
