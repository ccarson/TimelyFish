
CREATE VIEW [dbo].[QQCuryProjectNetProfit]
AS
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(0)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(1)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(2)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(3)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(4)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(5)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(6)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(7)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(8)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(9)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(10)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(11)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(12)
	UNION
	SELECT        *
	FROM            dbo.CuryProjectNetProfitPerPeriod(13)
