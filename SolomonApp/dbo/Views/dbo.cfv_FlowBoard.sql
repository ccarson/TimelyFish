
/****** Object:  View dbo.cfv_FlowBoard    Script Date: 4/18/2005 11:26:20 AM ******/

/****** Object:  View dbo.cfv_FlowBoard    Script Date: 4/13/2005 11:36:12 AM ******/

/****** Object:  View dbo.cfv_FlowBoard    Script Date: 4/13/2005 9:45:46 AM ******/

/****** Object:  View dbo.cfv_FlowBoard    Script Date: 4/12/2005 3:30:21 PM ******/


CREATE      VIEW dbo.cfv_FlowBoard (PMType, MoveDate, Source, SourceBarn, Qty, Gender, Dest, DestBarn, BegofWeek, DayofWeek)

AS

Select  lt.PMTypeID, lt.MovementDate, cts.ContactName, lt.SourceBarnNbr, lt.EstimatedQty, lt.PigGenderTypeID, ctd.ContactName, lt.DestBarnNbr,
	BegOfWeek = dbo.GetWeekofdate(lt.MovementDate),
	DayofWeek =  DatePart(weekday, lt.MovementDate) 
	From dbo.cftPM lt
	LEFT JOIN cftContact cts on lt.SourceContactID=cts.ContactID
	LEFT JOIN cftContact ctd ON lt.DestContactID=ctd.ContactID
	Where EstimatedQty>0 AND lt.PMTypeID='01'





