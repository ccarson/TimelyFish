 

CREATE VIEW vr_OrderTakersStats 
AS

SELECT	UserID, UserName,
	TodayOrders = SUM(CASE CrtdDateTime WHEN CONVERT(VARCHAR(12), GETDATE()) THEN OrderCount ELSE 0 END),
	TodayLines = SUM(CASE CrtdDateTime WHEN CONVERT(VARCHAR(12), GETDATE()) THEN LineCount ELSE 0 END),
	MoToDateOrders = SUM(OrderCount),
	MoToDateLines = SUM(LineCount),
	DailyAvgOrders = AVG(NULLIF(OrderCount,0)),
	DailyAvgLines = AVG(NULLIF(LineCount,0))
FROM	(
	SELECT	UserID = SOHeader.Crtd_User, UserName,
		CrtdDateTime = SOHeader.Crtd_DateTime,
		OrderCount = CONVERT(NUMERIC(14,2),COUNT(*)),
		LineCount = CONVERT(NUMERIC(14,2),0)
	FROM	SOHeader INNER JOIN
		vs_UserRec ON
		SOHeader.Crtd_User = vs_UserRec.UserID
	WHERE	SOHeader.Crtd_DateTime >= Convert(Varchar(12), DatePart(Month, getdate())) + '/01/' + Convert(Varchar(12), DatePart(Year, getdate()))
		AND SOHeader.Crtd_DateTime < DateAdd(Day, 1, CONVERT(varchar(12), getdate()))
	GROUP BY SOHeader.Crtd_User, vs_UserRec.UserName, SOHeader.Crtd_DateTime

	UNION ALL

	SELECT	UserID = SOLine.Crtd_User, UserName,
		CrtdDateTime = SOLine.Crtd_DateTime,
		OrderCount = CONVERT(NUMERIC(14,2),0),
		LineCount = CONVERT(NUMERIC(14,2),COUNT(*))
	FROM	SOLine INNER JOIN
		vs_UserRec ON
		SOLine.Crtd_User = vs_UserRec.UserID
	WHERE	SOLine.Crtd_DateTime >= Convert(Varchar(12), DatePart(Month, getdate())) + '/01/' + Convert(Varchar(12), DatePart(Year, getdate()))
		AND SOLine.Crtd_DateTime < DateAdd(Day, 1, CONVERT(varchar(12), getdate()))
	GROUP BY SOLine.Crtd_User, vs_UserRec.UserName, SOLine.Crtd_DateTime
	) s
GROUP BY UserID, UserName


 
