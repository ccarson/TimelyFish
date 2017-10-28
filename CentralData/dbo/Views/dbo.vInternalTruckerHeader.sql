CREATE VIEW dbo.vInternalTruckerHeader
AS
SELECT     t.StatusTypeID, c.ContactID, c.ContactName, tst.TransSchedMethodTypeDescription as ScheduleSendType,
		 ScheduleSendTo=Case c.TranSchedMethodTypeID
			when 2 then c.EmailAddress
			when 3 then cf.PhoneNbr
			else p.PhoneNbr
		End,c.TranSchedMethodTypeID,
		pt.PigTrailerDescription as DefaultTrailer
		
FROM         dbo.InternalTrucker t 

JOIN dbo.Contact c ON c.ContactID = t.ContactID
LEFT JOIN dbo.vMainContactPhone cp on cp.ContactID=t.ContactID
LEFT JOIN dbo.Phone p on cp.PhoneID=p.PhoneID
LEFT JOIN dbo.vInternalContactFax cf ON t.ContactID = cf.contactid 
LEFT OUTER JOIN dbo.PigTrailer pt ON t.DefaultPigTrailerID = pt.PigTrailerID 
LEFT OUTER JOIN dbo.TransSchedMethodType tst ON c.TranSchedMethodTypeID = tst.TransSchedMethodTypeID
where c.contactName is not null

