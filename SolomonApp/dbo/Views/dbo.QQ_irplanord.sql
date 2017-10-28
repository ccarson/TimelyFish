
CREATE VIEW [QQ_irplanord]
AS
SELECT	P.PlanOrdNbr AS [Planned Ord Nbr], P.InvtID AS [Inventory ID], I.Descr AS [Inventory Description], P.CpnyID AS [Company ID], 
		CONVERT(DATE,P.StartDate) AS [Start Date], CONVERT(DATE,P.FirmedDate) AS [Firmed Date], CONVERT(DATE,P.FinishDate) AS [End Date], 
		P.PlanQty AS Quantity, P.UnitDesc AS UOM, P.SiteID AS [To Site], P.TransferSiteID AS [From Site], P.VendID AS [Vendor ID], 
		CASE WHEN CHARINDEX('~' , V.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(V.Name, 1 , CHARINDEX('~' , V.Name) - 1)) + ', ' 
		+ LTRIM(RTRIM(SUBSTRING(V.Name, CHARINDEX('~' , V.Name) + 1 , 60)))) ELSE V.Name END AS [Vendor Name], P.ShipViaID, P.Planner, P.Buyer, 
		CASE WHEN CHARINDEX('~' , S.BuyerName) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(S.BuyerName, 1 , CHARINDEX('~' , S.BuyerName) - 1)) + ', ' 
		+ LTRIM(RTRIM(SUBSTRING(S.BuyerName, CHARINDEX('~' , S.BuyerName) + 1 , 60)))) ELSE S.BuyerName END AS [Buyer Name], P.Status, P.LeadTime, 
		P.IRDocType AS [Doc Type], P.SolDocID AS [Document ID], P.CnvFact AS [Conversion Factor], CONVERT(DATE,P.Crtd_Datetime) AS [Create Date], 
		P.Crtd_Prog AS [Create Program], P.Crtd_User AS [Create User], CONVERT(DATE,P.Lupd_Datetime) AS [Last Update Date], 
		P.Lupd_Prog AS [Last Update Program], P.Lupd_User AS [Last Update User], P.S4Future01, P.S4Future02, P.S4Future03, P.S4Future04, 
		P.S4Future05, P.S4Future06, CONVERT(DATE,P.S4Future07) AS [S4Future07], CONVERT(DATE,P.S4Future08) AS [S4Future08], P.S4Future09, 
		P.S4Future10, P.S4Future11, P.S4Future12, P.UnitMultDiv AS [UOM Multiply/Divide], P.User1, P.User2, P.User3, P.User4, P.User5, 
        P.User6, CONVERT(DATE,P.User7) AS [User7], CONVERT(DATE,P.User8) AS [User8], CONVERT(DATE,P.User9) AS [User9], CONVERT(DATE,P.User10) AS [User10]
FROM	IRPlanOrd P with (nolock) 
			INNER JOIN Inventory I with (nolock) ON P.InvtID = I.InvtID 
			LEFT OUTER JOIN Vendor V with (nolock) ON P.VendID = V.VendId 
			LEFT OUTER JOIN SIBuyer S with (nolock) ON P.Buyer = S.Buyer

