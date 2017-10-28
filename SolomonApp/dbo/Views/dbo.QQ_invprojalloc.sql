
CREATE VIEW [QQ_invprojalloc]
AS
SELECT     A.CpnyID AS [Company ID], A.InvtID AS [Inventory ID], I.Descr AS [Inv Description], A.SiteID, 
                      A.ProjectID, P.project_desc AS [Proj Description], A.TaskID, T.pjt_entity_desc AS [Task Description], 
                      A.WhseLoc AS [Warehouse Bin Location], A.QtyAllocated AS [Quantity Allocated], A.QtyRemainToIssue AS [Quantity Remaining To Issue], 
                      A.UnitCost, A.UnitDesc AS [Unit of Measure], I.ValMthd AS [Valuation Method],
                      I.LotSerTrack AS [Lot/Serial Tracked], P.status_pa AS [Project Status], P.customer AS [Project Customer], 
                      CASE WHEN CHARINDEX('~' , C.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(C.Name, 1 , CHARINDEX('~' , C.Name) - 1)) 
                      + ', ' + LTRIM(RTRIM(SUBSTRING(C.Name, CHARINDEX('~' , C.Name) + 1 , 60)))) ELSE C.Name END AS [Project Customer Name],
                      P.manager1 AS [Project Manager], CASE WHEN CHARINDEX('~' , E.emp_name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(E.emp_name, 1 , 
                      CHARINDEX('~' , E.emp_name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(E.emp_name, CHARINDEX('~' , E.emp_name) + 1 , 60)))) 
                      ELSE E.emp_name END AS [Project Manager Name], CONVERT(DATE,A.Crtd_DateTime) AS [Create Date], A.Crtd_Prog AS [Create Program], 
                      A.Crtd_User AS [Create User], CONVERT(DATE,A.LUpd_DateTime) AS [Last Update Date], A.LUpd_Prog AS [Last Update Program], 
                      A.LUpd_User AS [Last Update User], A.OrdNbr AS [Order Number], A.PerNbr AS [Period Number], 
                      A.PO_QtyOrd AS [Purchasing Quantity Ordered], A.PO_UnitCost AS [Purchasing Unit Cost], A.PO_UOM AS [Purchasing UOM], 
                      A.POLineRef AS [Purchase Order Line Reference Number], A.PONbr AS [Purchase Order Number], A.S4Future01, 
                      A.S4Future02, A.S4Future03, A.S4Future04, A.S4Future05, A.S4Future06, 
                      CONVERT(DATE,A.S4Future07) AS [S4Future07], CONVERT(DATE,A.S4Future08) AS [S4Future08], A.S4Future09, A.S4Future10, A.S4Future11, 
                      A.S4Future12, CONVERT(DATE,A.SrcDate) AS [Source Date], A.SrcLineRef AS [Source Line Reference Number], 
                      A.SrcNbr AS [Source Number], A.SrcType AS [Source Type], A.User1, A.User2, A.User3, A.User4, A.User5, A.User6, 
                      CONVERT(DATE,A.User7) AS [User7], CONVERT(DATE,A.User8) AS [User8], A.WIP_COGS_Acct AS [WIP COGS Account], 
                      A.WIP_COGS_Sub AS [WIP COGS Subaccount]
FROM	InvProjAlloc A with (nolock)
			INNER JOIN Inventory I with (nolock) ON A.InvtID = I.InvtID 
			INNER JOIN PJPROJ P with (nolock) ON A.ProjectID = P.project 
			INNER JOIN PJPENT T with (nolock) ON A.ProjectID = T.project AND A.TaskID = T.pjt_entity 
			LEFT OUTER JOIN Customer C with (nolock) ON P.customer = C.CustId 
			LEFT OUTER JOIN PJEMPLOY E with (nolock) ON P.manager1 = E.employee

