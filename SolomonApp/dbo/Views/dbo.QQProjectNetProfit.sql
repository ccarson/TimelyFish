CREATE VIEW [dbo].[QQProjectNetProfit]
AS
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(0)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(1)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(2)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(3)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(4)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(5)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(6)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(7)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(8)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(9)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(10)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(11)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(12)
	UNION
	SELECT        *
	FROM            dbo.ProjectNetProfitPerPeriod(13)
