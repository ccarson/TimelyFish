
/****** Object:  View dbo.cfvCompany    Script Date: 3/28/2005 9:32:21 AM ******/

/****** Object:  View dbo.cfvCompany    Script Date: 9/1/2004 2:59:48 PM ******/

/****** Object:  View dbo.cfvCompany    Script Date: 9/1/2004 2:31:19 PM ******/
CREATE    VIEW cfvCompany (CpnyID, CpnyName)AS SELECT CpnyID, CpnyName FROM SolomonSystem..Company
Where Active = 1


