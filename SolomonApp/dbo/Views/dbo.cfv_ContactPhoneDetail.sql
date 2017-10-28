CREATE VIEW cfv_ContactPhoneDetail (ContactID, ContactName, Extension, 
					PhoneNbr, PhoneType, SpeedDial, tstamp)
AS
-- Author: TJONES
-- Created: 1/25/05
-- Used In: CF15000
SELECT c.ContactID, c.ContactName, p.Extension, p.PhoneNbr, 
	pt.Description, p.SpeedDial,  p.tstamp
	FROM cftContact c
	JOIN cftContactPhone cp ON c.ContactID = cp.ContactID
	JOIN cftPhone p ON cp.PhoneID = p.PhoneID
	JOIN cftPhoneType pt ON cp.PhoneTypeID = pt.PhoneTypeID
