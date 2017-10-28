
CREATE VIEW [QQ_smConHistory]
AS
SELECT     C.CpnyID AS [Company ID], H.ContractID, H.HistYear AS [History Year], 
                      H.HistMonth AS [History Month], C.ContractType, C.BranchId, C.CustId AS [Customer ID], 
		      CASE WHEN CHARINDEX('~' , CU.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(CU.Name, 1 , CHARINDEX('~' , 
		      CU.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(CU.Name, CHARINDEX('~' , CU.Name) + 1 , 60)))) ELSE CU.Name END AS [Customer Name],
		      C.SiteId AS [Customer Site], A.Name AS [Customer Site Name], 
                      C.TotalAmt AS [Contract Amount], H.AmtInvoiced AS [Amount Billed], H.AmtRevenue AS [Revenue Amount], 
                      convert(date,C.StartDate) AS [StartDate], convert(date,C.ExpireDate) AS [End Date], convert(date,H.Crtd_DateTime) AS [Create Date], 
                      H.Crtd_Prog AS [Create Program], H.Crtd_User AS [Create User], H.LaborBillHrs AS [Labor Hours Billed], 
                      H.LaborCost, H.LaborHours AS [Labor Hours Entered], H.LaborSales, 
                      convert(date,H.Lupd_DateTime) AS [Last Update Date], H.Lupd_Prog AS [Last Update Program], 
                      H.Lupd_User AS [Last Update User], H.OtherCost, H.OtherSales, H.SalesTotal, 
                      H.TaxTotal, H.User1, H.User2, H.User3, H.User4, H.User5, 
                      H.User6, convert(date,H.User7) AS [User7], convert(date,H.User8) AS [User8]
FROM         smConHistory H with (nolock) INNER JOIN
                      SMContract C with (nolock) ON H.ContractID = C.ContractId INNER JOIN
                      Customer CU with (nolock) ON C.CustId = CU.CustId INNER JOIN
                      SOAddress A with (nolock) ON C.CustId = A.CustId AND C.SiteId = A.ShipToId

