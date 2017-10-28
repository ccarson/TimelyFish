
CREATE VIEW [QQ_smcontract]
AS
SELECT     s.ContractId, s.CustId As [Customer ID], CASE WHEN CHARINDEX('~', c.Name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(c.Name, 1, CHARINDEX('~', 
	c.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(c.Name, CHARINDEX('~', c.Name) + 1, 60)))) ELSE c.Name END AS [Customer Name], s.SiteId, CASE WHEN CHARINDEX('~' , 
	a.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(a.Name, 1 , CHARINDEX('~' , a.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(a.Name, 
	CHARINDEX('~' , a.Name) + 1 , 60)))) ELSE a.Name END AS [Site Customer Name], s.OriginalContractId, s.LastContractID, s.NextContractId, s.BillName As 
	[Bill To Name], s.BillAttn As [Attention], s.BillAddr1 As [Billing Address Line 1], s.BillAddr2 As [Billing Address Line 2], s.BillCity As [Billing City], 
	s.BillState As [Billing State], s.BillZip As [Billing Zip Code], s.BillCountry As [Billing Country/Region], '(' + SUBSTRING(s.BillPhone, 1, 3) + ')' + 
	SUBSTRING(s.BillPhone, 4, 3) + '-' + RTRIM(SUBSTRING(s.BillPhone, 7, 24)) AS [Billing Phone], '(' + SUBSTRING(s.BillFax, 1, 3) + ')' + SUBSTRING(s.BillFax, 4, 3) 
	+ '-' + RTRIM(SUBSTRING(s.BillFax, 7, 24)) AS [Billing Fax Number], s.Status, s.CalcellationCode As [Cancellation Code], s.ContractType, s.TotalAmt As 
	[Total Amount], s.CalculatedAmount, s.MinPerCall As [Minimum Per Call], s.MinHours As [Minimum Hours], convert(date,s.QuoteExpDate) As [Quote Expiration Date], 
	convert(date,s.StartDate) As [Contract Start Date], convert(date,s.ExpireDate) As [Contract Expiration Date], s.AmortFreq As [Amortization Frequency], 
	convert(date,s.AmortStartDate) As [Amortization Start Date], convert(date,s.LastAmortDate) As [Last Amortization Date], s.CustomerPO, s.RenewType As 
	[Renewal Method], s.EscCode As [Escalation Code], s.Renewals As [Renewals Allowed], s.RenewalsUsed As [Renewals Used], s.Response As [Maximum Response Time], 
    s.PrimaryTech As [Primary Technician], s.SecondTech AS [Secondary Technician], s.SalesPerson, s.MasterID As [Master Contract ID], s.BillingFreq As 
    [Billing Frequency], convert(date,s.LastBillDate) As [Last Billing Date], convert(date,s.LastCallDate) AS [LastCallDate], s.AccrualFlag As [Accrual Run], 
    s.AccrualPeriod, s.AgeCode As[Equipment Age Code], s.BillingsToDate As [Amount Billed To Date], s.BillingType As [Billing Method], convert(date,s.BillStartDate) 
    As [Billing Start Date], s.BranchId, s.CalculateBy As [Calculation Method], s.CancelBy As [Cancelled By User], convert(date,s.CancelDate) AS [CancelDate], 
    s.CommAmt As [Commission Amount], s.CO_ID10 As [Misc Charge Invoiced], s.CO_ID11 As [Misc Charge Description], s.CO_ID12 As [Charge Subaccount], s.CO_ID15 As 
    [Charge Account], s.CO_ID18 As [Misc Charge Account], CONVERT(DATE,s.CO_ID19) As [Charge Transaction Date], s.CommBatNbr As [Commission Batch Number], 
	s.CommPaid As [Commission Paid], s.CommPrct As [Commission Percent], s.CommType As [Commission Type], s.CpnyID As [Company ID], convert(date,s.Crtd_DateTime) As 
	[Create Date], s.Crtd_Prog As [Create Program], s.Crtd_User As [Create User], convert(date,s.EffectiveDate) AS [EffectiveDate], s.EndTimeMilitary00 As 
	[24 Hour Monday End Time], s.EndTimeMilitary01 As [24 Hour Tuesday End Time], s.EndTimeMilitary02 As [24 Hour Wednesday End Time], s.EndTimeMilitary03 As [24 Hour Thursday End Time], 
                s.EndTimeMilitary04 As [24 Hour Friday End Time], s.EndTimeMilitary05 As [24 Hour Saturday End Time], s.EndTimeMilitary06 As [24 Hour Sunday End Time], s.EnteredBy , 
                s.LabMarkupID As [Labor Markup ID], s.LaborCost, s.LaborHrsTD As [T&M Labor Hours], s.LaborPct As [Labor Percent], convert(date,s.Lupd_DateTime) As [Last Update Date], 
                s.Lupd_Prog As [Last Update Program], s.Lupd_User As [Last Update User], s.MasterAgreement, s.MaterialPct As [Material Markup Percentage], 
		s.MatMarkupID As [Material Markup ID], s.MediaID, s.MiscCost As [Miscellaneous Cost], s.NewContractAmt As [New Contract Amount], s.NoteId,
		s.OrigContractAmt As [Original Contract Amount], s.PartCost As [Cost of Parts], s.PMLaborPct As [Preventative Maintenance Labor Percent], 
		s.PMMaterialPct As [Preventative Maintenance Material Percent], convert(date,s.POEndDate) As [Purchase Order End Date], convert(date,s.POStartDate) As [Purchase Order Start Date], s.Priority, 
                s.ProcessType, s.RenewalAmount, convert(date,s.RenewalBillDate) AS [RenewalBillDate], s.RenewalBillFreq As [Renewal Bill Frequency], s.RenewalPeriod, 
                convert(date,s.RenewalRevDate) As [Revenue Renewal Date], s.RenewalRevFreq As [Revenue Renewal Frequency], s.RevenueAcct As [Revenue Account], s.RevenueSub As [Revenue Subaccount],
		s.StartTime00 As [Monday Start Time], s.StartTime01 As [Tuesday Start Time], s.StartTime02 As [Wednesday Start Time], 
                s.StartTime03 As [Thursday Start Time], s.StartTime04 As [Friday Start Time], s.StartTime05 As [Saturday Start Time], s.StartTime06 As [Sunday Start Time], 
		s.StartAMPM00 As [Monday AM/PM Start Time], s.StartAMPM01 As [Tuesday AM/PM Start Time], s.StartAMPM02 As [Wednesday AM/PM Start Time], 
		s.StartAMPM03 As [Thursday AM/PM Start Time], s.StartAMPM04 As [Friday AM/PM Start Time], s.StartAMPM05 As [Saturday AM/PM Start Time], 
                s.StartAMPM06 As [Sunday AM/PM Start Time], s.EndTime00 As [Monday End Time], s.EndTime01 As [Tuesday End Time], s.EndTime02 As [Wednesday End Time], 
		s.EndTime03 As [Thursday End Time], s.EndTime04 As [Friday End Time], s.EndTime05 As [Satursday End Time], s.EndTime06 As [Sunday End Time], 
		s.EndAMPM00 As [Monday AM/PM End Time], s.EndAMPM01 As [Tuesday AM/PM End Time], s.EndAMPM02 As [Wednesday AM/PM End Time], s.EndAMPM03 As [Thursday AM/PM End Time],
	        s.EndAMPM04 As [Friday AM/PM End Time], s.EndAMPM05 As [Saturday AM/PM End Time], s.EndAMPM06 As [Sunday AM/PM End Time], 
                s.Hours2400 As [24 Hour Monday Coverage], s.Hours2401 As [24 Hour Tuesday Coverage], s.Hours2402 As [24 Hour Wednesday Coverage],
	        s.Hours2403 As [24 Hour Thursday Coverage], s.Hours2404 As [24 Hour Friday Coverage], s.Hours2405 As [24 Hour Saturday Coverage],
	        s.Hours2406 As [24 Hour Sunday Coverage],  s.StartTimeMilitary00 As [24 Hour Monday Start Time], s.StartTimeMilitary01 As [24 Hour Tuesday Start Time], s.StartTimeMilitary02 As [24 Hour Wednesday Start Time],
	        s.StartTimeMilitary03 As [24 Hour Thursday Start Time], s.StartTimeMilitary04 As [24 Hour Friday Start Time], s.StartTimeMilitary05 As [24 Hour Saturday Start Time],
		s.StartTimeMilitary06 As [24 Hour Sunday Start Time], s.Taxable As [Is Taxable], s.TotalAmort As [Accrued Amount], s.TotalBilled, 
		s.TotalBills, s.TotalCalls, s.User1, s.User2, s.User3, s.User4, s.User5, s.User6, convert(date,s.User7) AS [User7], convert(date,s.User8) AS [User8]
FROM         SMContract s with (nolock) INNER JOIN
                      SOAddress a with (nolock) ON s.CustId = a.CustId AND s.SiteId = a.ShipToId INNER JOIN
                      Customer c with (nolock) ON s.CustId = c.CustId

