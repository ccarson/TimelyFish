CREATE PROCEDURE pXF185cftFeedOrder_WEMOrds
--*************************************************************
--	Purpose:Look up WEM Orders Delivered
--	Author: Sue Matter
--	Date: 10/30/2006
--	Usage: Feed Delivery app 
--	Parms:MillID, BegDate, EndDate
--*************************************************************
	@parm1 varchar (6), --MillID
	--@parm2 datetime, --SchedDate
	--@parm3 datetime --SchedDate
	@parm2 varchar(22),
	@parm3 varchar(22)
	AS 
	--DECLARE @BegDate As DateTime
	--DECLARE @EnDDate As DateTime
	--Select @BegDate = CONVERT(datetime,@parm2,120)
	--Select @EndDate = CONVERT(datetime,@parm3,120)
	SELECT mt.[Bin Feed Amount 1], f.ContactID, mt.[Formula No], mt.[Load Date],
	f.MillID, f.OrdNbr
	FROM cftFeedOrder f
	JOIN MTECHLOADORDERS mt ON f.OrdNbr=mt.[Ticket Comment]
	LEFT JOIN cftFOList l on f.OrdNbr=l.OrdNbr 
	WHERE f.MillId LIKE @parm1  
	AND f.Status <>'C'
	--AND CONVERT(datetime, mt.[Load Date],101) BETWEEN @parm2 AND @parm3
	--AND CONVERT(datetime,mt.[Load Date],120) BETWEEN CONVERT(datetime,@parm2,120) AND CONVERT(datetime,@parm3,120)
	AND CONVERT(datetime,mt.[Load Date],120) BETWEEN @parm2 AND @parm3
	AND Exists (SELECT * FROM cftOrderStatus WHERE Status = f.Status AND RelFlg = 1)
	AND (l.OrdNbr is null)
	--Group by f.ContactID
	ORDER BY f.ContactID
