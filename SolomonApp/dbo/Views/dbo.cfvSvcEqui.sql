
/****** Object:  View dbo.cfvSvcEqui    Script Date: 9/15/2005 1:04:51 PM ******/

/****** Object:  View dbo.cfvSvcEqui    Script Date: 9/15/2005 11:50:48 AM ******/

/****** Object:  View dbo.cfvSvcEqui    Script Date: 9/15/2005 8:21:37 AM ******/
CREATE    View cfvSvcEqui
AS
Select eq.EquipID, eq.EquipTypeID, eq.MfgYear, eq.ModelId, eq.CpnyId, eq.User6, ct.ContactName, eq.User5, 
rd.ReadDate, rd.Reading, eq.ManufID
From smSvcEquipment eq
LEFT JOIN smSvcReadings rd ON eq.equipID=rd.equipID AND rd.ReadDate = (Select Max(ReadDate) from smSvcReadings Where equipID= eq.EquipID)
LEFT JOIN cftContact ct ON eq.User6 = ct.ContactID






