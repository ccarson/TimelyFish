
CREATE VIEW [QQ_SmServCall]
AS
SELECT     s.BranchID, s.CallType, s.ServiceCallID, smCallTypes.CallTypeDesc As [Call Type Description], smBranch.Name AS [Branch Name], 
                      a.Addr1 As [Address Line 1], a.Addr2 As [Address Line 2] ,'(' + SUBSTRING(a.Phone, 1, 3) + ')' + SUBSTRING(a.Phone, 4, 3) + '-' + RTRIM(SUBSTRING(a.Phone, 7, 24)) AS [Phone], 
                      convert(date,s.ServiceCallDateProm) As [Date Promised], s.AssignEmpID As [Assigned Employee ID], s.ServiceCallCompleted, 
                      s.PromiseTimeAMPM As [Promise Time AM/PM], s.PromTimeFrom As [Promise Time From], s.AmountLabor As [Labor Amount], s.AmountFRTM As [T&M Amount],
		      s.InvoiceNumber, s.InvoiceAmount, s.CallStatus, 
		      CASE WHEN CHARINDEX('~' , s.CustName) > 0 THEN 
		      CONVERT (CHAR(60) , LTRIM(SUBSTRING(s.CustName, 1 , CHARINDEX('~' , s.CustName) - 1)) + ', ' + 
		      LTRIM(RTRIM(SUBSTRING(s.CustName, CHARINDEX('~' , s.CustName) + 1 , 60)))) ELSE s.CustName END As [Customer Name], 
		      s.CustCity As [Customer City],
		      '(' + SUBSTRING(s.CustPhone, 1, 3) + ')' + SUBSTRING(s.CustPhone, 4, 3) + '-' + RTRIM(SUBSTRING(s.CustPhone, 7, 24)) AS [Customer Phone],
		      s.AdjustLabor As [Labor Adjustment Amount], 
                      s.AdjustTM As [T&M Adjustment Amount], s.AltCustID As [Billing Customer ID], 
                      s.BillDay As [Billing Day], s.BillDayofMonth As [Billing Day of Month], 
		      s.BillFrequency As [Billing Frequency], s.BillingType,  s.CallerName, 
		      s.cmbCODInvoice As [Invoice Type], s.cmbInvoiceType As [Service Detail Type], s.Comments, convert(date,s.CompleteDate) AS [CompleteDate], s.CompletedNotReview As [Completion Notes], 
		      s.CompleteTime AS [CompleteTime], s.CompleteUserID, s.ContractID, s.ContractType, s.ControlAmount As [Transaction Amount], 
		      s.CostFRTM As [T&M Costs], s.CostLabor As [Labor Pay Rate],  
                      s.CouponID, s.CpnyID As [Company ID], convert(date,s.CreditCardExpDate) AS [CreditCardExpDate], convert(date,s.Crtd_DateTime) As [Create Date], 
		      s.Crtd_Prog As [Create Program], s.Crtd_User As [Create User], s.CustAvgRevenue As [Customer Average Revenue], 
		      s.CustDwelling As [Building Type], s.CustGeographicID As [Customer Geographic Region], 
                      s.CustMapCoord As [Map Coordinates], s.CustMapPage As [Map Page], 
			s.CustomerId, s.CustomerPO, 
                      s.CustomerSatisfied As [Customer Satisfaction], 
	 	      s.CustPromiseTimeMi As [Time Promised], s.DiscAmount As [Discount Amount], s.DiscPercent As [Discount Percent], s.Duration, convert(date,s.EndDate) As [Schedule End Date], 
		      CONVERT(TIME,s.EndTime) As [Schedule End Time], s.HrsBilled As [Hours Billed], s.HrsWorked As [Hours Worked], 
                      s.InvoiceFlag As [Invoiced], s.InvoiceHandling,  s.InvoiceStatus, 
                      convert(date,s.LastInvoiceDate) AS [LastInvoiceDate], convert(date,s.Lupd_DateTime) As [Last Update Date] , s.Lupd_Prog As [Last Update Program], s.Lupd_User As [Last Update User], s.MediaGroupId, s.NoteId,
                      convert(date,s.OrderDate) AS [OrderDate], s.OrdNbr As [Order Number], s.PaymentMethod, s.PaymentNumber, s.PerEnt As [Period Entered], 
                      s.PMCode, s.PMFlag, s.PostToPeriod, s.PrimaryFaultCode, s.ProcessedBy, 
                      convert(date,s.ProcessedDate) AS [ProcessedDate], s.ProjectID, s.PromiseTimeTOAMPM As [AM/PM Promise Time], s.PromTimeTo As [Promise Time To], s.ReadyToInvoice, 
                      s.ReviewedBy, convert(date,s.ReviewedDate) AS [ReviewedDate], s.SecurityEntryCode, convert(date,s.ServiceCallDate) AS [ServiceCallDate], 
                      s.ServiceCallDuration, s.ServiceCallPriority, s.ServiceCallStatus, CONVERT(TIME,s.ServiceCallTime) AS [ServiceCallTime], 
                      s.ShiptoId, s.SiteAddr1 As [Site Address Line 1], s.SiteAddr2 As [Site Address Line 2], s.SiteCity, s.SiteCountry, 
		      '(' + SUBSTRING(s.SiteFax, 1, 3) + ')' + SUBSTRING(s.SiteFax, 4, 3) + '-' + RTRIM(SUBSTRING(s.SiteFax, 7, 24)) As [Site Fax Number], 
                      CASE WHEN CHARINDEX('~' , s.SiteName) > 0 THEN 
		      CONVERT (CHAR(60) , LTRIM(SUBSTRING(s.SiteName, 1 , CHARINDEX('~' , s.SiteName) - 1)) + ', ' + 
		      LTRIM(RTRIM(SUBSTRING(s.SiteName, CHARINDEX('~' , s.SiteName) + 1 , 60)))) ELSE s.SiteName END AS [Site Customer Name], 
		     '(' + SUBSTRING(s.SitePhone, 1, 3) + ')' + SUBSTRING(s.SitePhone, 4, 3) + '-' + RTRIM(SUBSTRING(s.SitePhone, 7, 24)) As [Site Phone Number], 
		      s.SiteState, s.SiteZip As [Site Zip Code], s.SlsperID As [Salesperson ID], s.SourceCallID, 
                      convert(date,s.StartDate) AS [StartDate], CONVERT(TIME,s.StartTime) AS [StartTime], s.TaxAmt00 As [Tax Amount(0)], s.TaxAmt01 As [Tax Amount(1)], s.TaxAmt02 As [Tax Amount(2)], s.TaxAmt03 As [Tax Amount(3)], 
                      s.TaxFRTM, s.TaxId00 As [Tax ID(0)], s.TaxId01 As [Tax Id (1)], s.TaxId02 As [Tax Id(2)], s.TaxId03 As [Tax Id(3)], s.TaxLabor As [Labor Tax Amount], 
                      s.TaxTot As [Total Tax], s.TermID, s.TimeZoneID, s.TxblAmt00 As [Taxable Amount(0)], s.TxblAmt01 As [Taxable Amount(1)], s.TxblAmt02 As [Taxable Amount(2)], 
                      s.TxblAmt03 As [Taxable Amount(3)], s.User1, s.User2, s.User3, s.User4, s.User5, 
                      s.User6, convert(date,s.User7) AS [User7], convert(date,s.User8) AS [User8], s.User9, s.UserID, s.WrkOrdNbr As [Work Order Number], 
                      a.Attn As [Attention], a.City, a.Country, 
		      CASE WHEN CHARINDEX('~' , a.Name) > 0 THEN 
		      CONVERT (CHAR(60) , LTRIM(SUBSTRING(a.Name, 1 , CHARINDEX('~' , a.Name) - 1)) + ', ' + 
		      LTRIM(RTRIM(SUBSTRING(a.Name, CHARINDEX('~' , a.Name) + 1 , 60)))) ELSE a.Name END AS [Ship To Name], smCallTypes.CallTypeId, 
                      smBranch.BranchId AS [Branch ID]
	 FROM         smServCall s with (nolock) INNER JOIN
                      SOAddress a with (nolock) ON s.ShiptoId = a.ShipToId AND s.CustomerId = a.CustId 
                      INNER JOIN smCallTypes with (nolock) ON s.CallType = smCallTypes.CallTypeId INNER JOIN
                      smBranch with (nolock) ON s.BranchID = smBranch.BranchId

