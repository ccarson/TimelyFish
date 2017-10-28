CREATE VIEW [dbo].[QQTaskNetProfit]
AS
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(0)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(1)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(2)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(3)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(4)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(5)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(6)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(7)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(8)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(9)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(10)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(11)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(12)
	UNION
	SELECT        *
	FROM            dbo.TaskNetProfitPerPeriod(13)
