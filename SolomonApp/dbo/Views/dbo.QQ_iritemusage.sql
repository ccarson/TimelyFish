
CREATE VIEW [QQ_iritemusage]
AS
SELECT	U.InvtID AS [Inventory ID], I.Descr AS [Inventory Descr], U.SiteID, U.Period, U.DemActAdjust AS [Demand Actual Adjustment], 
		U.DemActual AS [Demand Actual], U.DemNonRecur AS [Demand Non-Recurring], U.DemOverRide AS [Demand Override], U.DemProjected AS [Demand Projected], 
		U.DemRolledup AS [Demand Rolled Up], U.Reason, CONVERT(DATE,U.Crtd_Datetime) AS [Create Date], U.Crtd_Prog AS [Create Program], 
		U.Crtd_User AS [Create User], CONVERT(DATE,U.Lupd_Datetime) AS [Last Update Date], U.Lupd_Prog AS [Last Update Program], 
		U.Lupd_User AS [Last Update User], U.NoteID, U.S4Future01, U.S4Future02, U.S4Future03, U.S4Future04, U.S4Future05, U.S4Future06, 
		CONVERT(DATE,U.S4Future07) AS [S4Future07], CONVERT(DATE,U.S4Future08) AS [S4Future08], U.S4Future09, U.S4Future10, U.S4Future11, U.S4Future12, 
		U.User1, U.User2, U.User3, U.User4, U.User5, U.User6, CONVERT(DATE,U.User7) AS [User7], CONVERT(DATE,U.User8) AS [User8], 
		CONVERT(DATE,U.User9) AS [User9], CONVERT(DATE,U.User10) AS [User10]
FROM	IRItemUsage U with (nolock) 
			INNER JOIN Inventory I with (nolock) ON U.InvtID = I.InvtID

