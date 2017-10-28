
CREATE VIEW [dbo].[QQCuryTaskNetProfit]
AS
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(0)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(1)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(2)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(3)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(4)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(5)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(6)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(7)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(8)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(9)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(10)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(11)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(12)
	UNION
	SELECT        *
	FROM            dbo.CuryTaskNetProfitPerPeriod(13)
