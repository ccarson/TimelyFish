
CREATE VIEW [QQ_pjinvhdr]
AS
SELECT     H.project_billwith AS [primary billing project], P.project_desc AS [project name], H.customer, 
                      CASE WHEN CHARINDEX('~', C.Name) > 0 THEN CONVERT(CHAR(30), LTRIM(SUBSTRING(C.Name, 1, CHARINDEX('~', 
                      C.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(C.Name, CHARINDEX('~', C.Name) + 1, 30)))) 
                      ELSE C.Name END AS [customer name], H.draft_num AS [draft number], H.inv_status AS [invoice status], 
                      convert(date,H.begin_date) AS [invoice start date], convert(date,H.end_date) AS [invoice end date], H.invoice_num AS [invoice number], 
                      convert(date,H.invoice_date) AS [invoice date], H.fiscalno AS [fiscal period], H.docdesc AS [document description], 
                      H.invoice_type AS [invoice type], H.doctype AS [document type], H.gross_amt AS [gross amount], 
                      H.tax_amt AS [tax items sum in base currency], H.paid_amt AS [deposit items sum in base currency], 
                      H.retention_amt AS [retention items sum in base currency], H.other_amt AS [other items sum in base currency], 
                      H.ih_id06 AS [bill to date amount], H.ih_id18 AS [terms ID], H.CpnyId AS company, 
                      H.approver_id AS approver, H.slsperid AS [salesperson ID], H.ShipperID AS [shipper ID], 
                      H.ih_id11 AS [application number], H.BaseCuryId AS [base currency], H.CuryId AS [currency ID], 
                      H.CuryRate AS [currency rate], H.Curygross_amt AS [regular items sum in source currency], 
                      H.Curytax_amt AS [tax items sum in source currency], H.Curypaid_amt AS [deposit items sum in source currency], 
                      H.Curyretention_amt AS [retention items sum in source currency], H.Curyother_amt AS [other items sum in source currency], 
                      convert(date,H.CuryEffDate) AS [currency effective date], H.CuryRateType AS [currency rate type], H.batch_id AS [batch number], H.ih_id01, 
                      H.ih_id02, H.ih_id03, H.ih_id04, H.ih_id05, H.ih_id07 AS [reprint contract value], 
                      convert(date,H.ih_id08) AS [ih_id08], convert(date,H.ih_id09) AS [ih_id09], H.ih_id10, H.ih_id12 AS [original invoice number], 
                      H.ih_id13 AS [bill group], H.ih_id14, H.ih_id15, H.ih_id16, H.ih_id17, 
                      H.ih_id19, convert(date,H.ih_id20) AS [ih_id20], H.inv_attach_cd AS [invoice attachment format code], 
                      H.inv_format_cd AS [invoice format code], convert(date,H.last_bill_date) AS [last invoice end date], 
                      H.preparer_id AS [preparer id], convert(date,H.crtd_datetime) AS [create date], H.crtd_prog AS [create program], 
                      H.crtd_user AS [create user], convert(date,H.lupd_datetime) AS [last update date], H.lupd_prog AS [last update program], 
                      H.lupd_user AS [last update user]
FROM         PJINVHDR H WITH (nolock) LEFT OUTER JOIN
                      PJPROJ P WITH (nolock) ON H.project_billwith = P.project LEFT OUTER JOIN
                      Customer C WITH (nolock) ON H.customer = C.CustId

