 CREATE PROCEDURE ADG_OrderTakersStats

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	Create table #OrderStats (
		UserID		varchar(10)	not null,
		UserName	varchar(30)	null,
		TodayOrders	numeric(14,2)	null,
		TodayLines	numeric(14,2)	null,
		MoToDateOrders	numeric(14,2)	null,
		MoToDateLines	numeric(14,2)	null,
		DailyAvgOrders	numeric(14,2)	null,
		DailyAvgLines	numeric(14,2)	null)

	--Use Execute so this procedure will compile even though the view may not exist

	-- Total orders for today.
	execute('INSERT INTO #OrderStats (UserID, UserName, TodayOrders) ' +
	'SELECT SOHeader.Crtd_User, VS_USERREC.UserName, Count(SOHeader.OrdNbr) ' +
	'FROM 	SOHeader, VS_USERREC ' +
	'WHERE 	SOHeader.Crtd_User = VS_USERREC.UserID ' +
	  'AND	SOHeader.Crtd_DateTime = CONVERT(varchar(12), getdate()) ' +
	'GROUP BY SOHeader.Crtd_User, VS_USERRec.UserName')

	-- Total lines for today.
	execute('INSERT INTO #OrderStats (UserID, UserName, TodayLines) ' +
	'SELECT SOLine.Crtd_User, VS_USERREC.UserName, Count(SOLine.OrdNbr) ' +
	'FROM 	SOLine, VS_USERREC ' +
	'WHERE 	SOLine.Crtd_User = VS_USERREC.UserID ' +
	  'AND	SOLine.Crtd_DateTime = CONVERT(varchar(12), getdate()) ' +
	'GROUP BY SOLine.Crtd_User, VS_USERRec.UserName')

	-- Total orders month-to-date.
	execute('INSERT INTO #OrderStats (UserID, UserName, MoToDateOrders) ' +
	'SELECT SOHeader.Crtd_User, VS_USERREC.UserName, Count(SOHeader.OrdNbr) ' +
	'FROM 	SOHeader, VS_USERREC ' +
	 'WHERE SOHeader.Crtd_User = VS_USERREC.UserID ' +
	  'AND	SOHeader.Crtd_DateTime >= Convert(Varchar(12), DatePart(Month, getdate())) + ' +
		'''/01/'' + Convert(Varchar(12), DatePart(Year, getdate())) ' +
	  'AND	SOHeader.Crtd_DateTime < DateAdd(Day, 1, CONVERT(varchar(12), getdate())) ' +
	'GROUP BY SOHeader.Crtd_User, VS_USERRec.UserName')

	-- Total lines month-to-date.
	execute('INSERT INTO #OrderStats (UserID, UserName, MoToDateLines) ' +
	'SELECT SOLine.Crtd_User, VS_USERREC.UserName, Count(SOLine.OrdNbr) ' +
	'FROM 	SOLine, VS_USERREC ' +
	'WHERE 	SOLine.Crtd_User = VS_USERREC.UserID ' +
	  'AND	SOLine.Crtd_DateTime >= Convert(Varchar(12), DatePart(Month, getdate())) + ' +
		'''/01/'' + Convert(Varchar(12), DatePart(Year, getdate())) ' +
	  'AND	SOLine.Crtd_DateTime < DateAdd(Day, 1, CONVERT(varchar(12), getdate())) ' +
	'GROUP BY SOLine.Crtd_User, VS_USERRec.UserName')

	-- Daily average number of orders.
	execute('INSERT INTO #OrderStats (UserID, UserName, DailyAvgOrders) ' +
	'SELECT SOHeader.Crtd_User, VS_USERREC.UserName, Count(SOHeader.OrdNbr) ' +
	'FROM 	SOHeader, VS_USERREC ' +
	'WHERE 	SOHeader.Crtd_User = VS_USERREC.UserID ' +
	  'AND	SOHeader.Crtd_DateTime >= Convert(Varchar(12), DatePart(Month, getdate())) + ' +
		'''/01/'' + Convert(Varchar(12), DatePart(Year, getdate())) ' +
	  'AND	SOHeader.Crtd_DateTime < DateAdd(Day, 1, CONVERT(varchar(12), getdate())) ' +
	'GROUP BY SOHeader.Crtd_User, VS_USERRec.UserName, Crtd_DateTime')

	-- Daily average number of lines.
	execute('INSERT INTO #OrderStats (UserID, UserName, DailyAvgLines) ' +
	'SELECT SOLine.Crtd_User, VS_USERREC.UserName, Count(SOLine.OrdNbr) ' +

	'FROM 	SOLine, VS_USERREC ' +
	'WHERE 	SOLine.Crtd_User = VS_USERREC.UserID ' +
	  'AND	SOLine.Crtd_DateTime >= Convert(Varchar(12), DatePart(Month, getdate())) + ' +
		'''/01/'' + Convert(Varchar(12), DatePart(Year, getdate())) ' +
	  'AND	SOLine.Crtd_DateTime < DateAdd(Day, 1, CONVERT(varchar(12), getdate())) ' +
	'GROUP BY SOLine.Crtd_User, VS_USERRec.UserName, Crtd_DateTime')

	-- Return all records from the temp table.

	SELECT 	UserID, UserName, Sum(TodayOrders) TodayOrders, Sum(TodayLines) TodayLines,
		Sum(MoToDateOrders) MoToDateOrders, Sum(MoToDateLines) MoToDateLines,
		Avg(DailyAvgOrders) DailyAvgOrders, Avg(DailyAvgLines) DailyAvgLines
	FROM 	#OrderStats
	GROUP BY UserID, UserName

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_OrderTakersStats] TO [MSDSL]
    AS [dbo];

