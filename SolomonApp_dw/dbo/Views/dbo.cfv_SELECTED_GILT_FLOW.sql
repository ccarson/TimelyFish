
-- ==================================================================
-- Author:		Mike Zimanski
-- Create date: 10/13/2010
-- Description:	Selected Gilt - Source, Flow and Phase information by site
-- ==================================================================
CREATE VIEW [dbo].[cfv_SELECTED_GILT_FLOW]

AS

Select 

	Site.SiteID,
	Contact.Contactname,
	Case when Site.SiteID = 8410 then 1
	when Site.SiteID in (6525,2280) then 2
	when Site.SiteID in (8052,8053,8054) then 3
	when Site.SiteID in (7935,0262) then 4
	when Site.SiteID = 0511 then 5
	when Site.SiteID = 6430 then 6
	when Site.SiteID = 5321 then 7
	when Site.SiteID in (8145,8101) then 8
	when Site.SiteID in (0260,0330,0360,6410,6625,4170,6800,6360,6614) then 9
	when Site.SiteID in (4670,0530,6450,6490,6260,6370,6380,6501,6790,6995,6610,6280) then 10
	when Site.SiteID = 8051 then 11
	when Site.SiteID in (6502,6470) then 12
	when Site.SiteID in (7980,8102) then 13
	when Site.SiteID in (6440,6460,6480) then 14
	when Site.SiteID in (5950,6565,5983,6568,0266) then 15
	when Site.SiteID = 8050 then 16
	when Site.SiteID in (9820,9870,8454) then 17
	when Site.SiteID in (8467,8468) then 18 else '' end as FlowID,
	Case when Site.SiteID = 8410 then 'Boar Farm M2'
	when Site.SiteID in (6525,2280) then 'Finish M2' 
	when Site.SiteID in (8052,8053,8054) then 'Gilt Development M1'
	when Site.SiteID in (7935,0262) then 'ILL Flow'
	when Site.SiteID = 0511 then 'Isolation M2'
	when Site.SiteID = 6430 then 'Isolation M3/M4'
	when Site.SiteID = 5321 then 'Isolation M5/M6'
	when Site.SiteID in (8145,8101) then 'LDC Complex'
	when Site.SiteID in (0260,0330,0360,6410,6625,4170,6800,6360,6614) then 'MN HH Flow'
	when Site.SiteID in (4670,0530,6450,6490,6260,6370,6380,6501,6790,6995,6610,6280) then 'MN PRRS Pos GDU in MN'
	when Site.SiteID = 8051 then 'Nursery M1'
	when Site.SiteID in (6502,6470) then 'Nursery M2'
	when Site.SiteID in (7980,8102) then 'ON Complex'
	when Site.SiteID in (6440,6460,6480) then 'PRRS Neg Nursery M3/M4'
	when Site.SiteID in (5950,6565,5983,6568,0266) then 'SI Flow'
	when Site.SiteID = 8050 then 'Sow Farms M1'
	when Site.SiteID in (9820,9870,8454) then 'Sow Farms M3/M4'
	when Site.SiteID in (8467,8468) then 'Sow Farms M5/M6' else '' end as FlowName,
	Case when Site.SiteID in (7935,8145,8051,6502,6470,7980,6440,6460,6480) then 'FP'
	when Site.SiteID in (6430,5321) then 'Gilt'
	when Site.SiteID in (6525,2280) then 'SB'
	when Site.SiteID = 0511 then 'BoarIso'
	when Site.SiteID in (8052,8053,8054,0262,8101,0260,0330,0360,6410,6625,4170,6800,6360,6614,4670,0530,6450,6490,6260,6370,6380,6501,6790,
	6995,6610,6280,8102,5950,6565,5983,6568,0266) then 'SG'
	when Site.SiteID in (8410,8050,9820,9870,8454,8467,8468) then 'WP' else '' end as Phase,
	Case when Site.SiteID in (8051,8052,8053,8054,8050) then 'M1'
	when Site.SiteID in (6525,2280,6502,6470,0511,8410) then 'M2'
	when Site.SiteID in (8145,7980,6440,6460,6480,6430,8101,0260,0330,0360,6410,6625,4170,6800,6360,6614,4670,0530,6450,6490,6260,6370,6380,
	6501,6790,6995,6610,6280,8102,9820,9870,8454) then 'M3/M4'
	when Site.SiteID in (7935,5321,0262,5950,6565,5983,6568,0266,8467,8468) then 'M5/M6' else '' end as Source,
	Case when Site.SiteID in (8410,6525,2280,8052,8053,8054,7935,0262,0511,6430,5321,8145,8101,0260,0330,0360,6410,6625,4170,6800,6360,
	4670,0530,6450,6490,6260,6370,6380,6501,6790,6995,8051,6502,6470,7980,8102,6440,6460,6480,5950,6565,5983,0266,8050,9820,9870,8454,
	8467,8468) then '200801'
	when Site.SiteID in (6610,6614) then '201008'
	when Site.SiteID = 6568 then '201102' 
	when Site.SiteID = 6280 then '200912' else '' end as StartPeriod,
	Case when Site.SiteID in (6800,6360) then '201007'
	when Site.SiteID = 6280 then '201008' else CurrentDate.GroupPeriod end as EndPeriod

	from [$(SolomonApp)].dbo.cftSite Site

	left join [$(SolomonApp)].dbo.cftContact Contact
	on Site.Contactid = Contact.Contactid 

	cross join 
	(Select Case When wd.FiscalPeriod < 10 
	Then Rtrim(Cast(wd.FiscalYear as char))+'0'+Rtrim(Cast(wd.FiscalPeriod as char)) 
	else Rtrim(Cast(wd.FiscalYear as char))+Rtrim(Cast(wd.FiscalPeriod as char)) end As GroupPeriod
	from [$(SolomonApp)].dbo.cftDayDefinition dd
	left join [$(SolomonApp)].dbo.cftWeekDefinition wd
	on dd.weekofdate = wd.weekofdate
	where rtrim(dd.daydate) = DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) CurrentDate

	where 
	Site.Siteid in (8410,6525,2280,8052,8053,8054,7935,0262,0511,6430,5321,8145,8101,0260,0330,0360,6410,6625,4170,6800,6360,6614,
	4670,0530,6450,6490,6260,6370,6380,6501,6790,6995,6610,6280,8051,6502,6470,7980,8102,6440,6460,6480,5950,6565,5983,6568,0266,8050,
	9820,9870,8454,8467,8468) 

	Union

	Select 

	Case when Site.SiteID = 8050 then 0001 else '' end as SiteID,
	Case when Contact.Contactname = 'M001' then 'M001Lr' else '' end as Contactname,
	Case when Site.SiteID = 8050 then 19 else '' end as FlowID,
	Case when Site.SiteID = 8050 then 'Sow Farms M1Lr' else '' end as FlowName,
	Case when Site.SiteID = 8050 then 'WPLr' else '' end as Phase,
	Case when Site.SiteID = 8050 then 'M1' else '' end as Source,
	Case when Site.SiteID = 8050 then '200801' else '' end as StartPeriod,
	Case when Site.SiteID = 8050 then CurrentDate.GroupPeriod else '' end as EndPeriod

	from [$(SolomonApp)].dbo.cftSite Site

	left join [$(SolomonApp)].dbo.cftContact Contact
	on Site.Contactid = Contact.Contactid 

	cross join 
	(Select Case When wd.FiscalPeriod < 10 
	Then Rtrim(Cast(wd.FiscalYear as char))+'0'+Rtrim(Cast(wd.FiscalPeriod as char)) 
	else Rtrim(Cast(wd.FiscalYear as char))+Rtrim(Cast(wd.FiscalPeriod as char)) end As GroupPeriod
	from [$(SolomonApp)].dbo.cftDayDefinition dd
	left join [$(SolomonApp)].dbo.cftWeekDefinition wd
	on dd.weekofdate = wd.weekofdate
	where dd.daydate = DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) CurrentDate

	where 
	Site.Siteid = 8050
	
	Union

	Select 

	Case when Site.SiteID = 8050 then 0002 else '' end as SiteID,
	Contact.Contactname,
	Case when Site.SiteID = 8050 then 17 else '' end as FlowID,
	Case when Site.SiteID = 8050 then 'Sow Farms M3/M4' else '' end as FlowName,
	Case when Site.SiteID = 8050 then 'WP' else '' end as Phase,
	Case when Site.SiteID = 8050 then 'M3/M4' else '' end as Source,
	Case when Site.SiteID = 8050 then '200801' else '' end as StartPeriod,
	Case when Site.SiteID = 8050 then CurrentDate.GroupPeriod else '' end as EndPeriod

	from [$(SolomonApp)].dbo.cftSite Site

	left join [$(SolomonApp)].dbo.cftContact Contact
	on Site.Contactid = Contact.Contactid 

	cross join 
	(Select Case When wd.FiscalPeriod < 10 
	Then Rtrim(Cast(wd.FiscalYear as char))+'0'+Rtrim(Cast(wd.FiscalPeriod as char)) 
	else Rtrim(Cast(wd.FiscalYear as char))+Rtrim(Cast(wd.FiscalPeriod as char)) end As GroupPeriod
	from [$(SolomonApp)].dbo.cftDayDefinition dd
	left join [$(SolomonApp)].dbo.cftWeekDefinition wd
	on dd.weekofdate = wd.weekofdate
	where dd.daydate = DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) CurrentDate
	
	where 
	Site.Siteid = 8050

	Union

	Select 

	Site.SiteID,
	Contact.Contactname,
	Case when Site.SiteID = 6614 then 10 else '' end as FlowID,
	Case when Site.SiteID = 6614 then 'MN PRRS Pos GDU in MN' else '' end as FlowName,
	Case when Site.SiteID = 6614 then 'SG' else '' end as Phase,
	Case when Site.SiteID = 6614 then 'M3/M4' else '' end as Source,
	Case when Site.SiteID = 6614 then '200801' else '' end as StartPeriod,
	Case when Site.SiteID = 6614 then '201007' else CurrentDate.GroupPeriod end as EndPeriod

	from [$(SolomonApp)].dbo.cftSite Site

	left join [$(SolomonApp)].dbo.cftContact Contact
	on Site.Contactid = Contact.Contactid 

	cross join 
	(Select Case When wd.FiscalPeriod < 10 
	Then Rtrim(Cast(wd.FiscalYear as char))+'0'+Rtrim(Cast(wd.FiscalPeriod as char)) 
	else Rtrim(Cast(wd.FiscalYear as char))+Rtrim(Cast(wd.FiscalPeriod as char)) end As GroupPeriod
	from [$(SolomonApp)].dbo.cftDayDefinition dd
	left join [$(SolomonApp)].dbo.cftWeekDefinition wd
	on dd.weekofdate = wd.weekofdate
	where dd.daydate = DateAdd(Day,0,DateDiff(Day,0,Current_TimeStamp))) CurrentDate

	where 
	Site.Siteid = 6614
