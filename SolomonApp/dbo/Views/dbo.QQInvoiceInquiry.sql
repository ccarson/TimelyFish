CREATE VIEW [dbo].[QQInvoiceInquiry]
AS
SELECT        dbo.ARDoc.ProjectID, dbo.ARDoc.RefNbr, dbo.ARDoc.DocDate, dbo.ARDoc.DocBal, dbo.ARDoc.OpenDoc, dbo.ARDoc.DocType, dbo.ARDoc.OrigDocAmt, 
                         dbo.Customer.Name, dbo.PJINVHDR.draft_num, dbo.PJINVHDR.end_date, 
                         dbo.PJINVHDR.gross_amt + dbo.PJINVHDR.other_amt + dbo.PJINVHDR.tax_amt - dbo.PJINVHDR.retention_amt - dbo.PJINVHDR.paid_amt AS Base_Amount, 
                         dbo.PJINVHDR.Curygross_amt + dbo.PJINVHDR.Curyother_amt + dbo.PJINVHDR.Curytax_amt - dbo.PJINVHDR.Curyretention_amt - dbo.PJINVHDR.Curypaid_amt
                          AS Cury_Amount, dbo.ARDoc.CuryId, dbo.PJINVHDR.ShipperID
FROM            dbo.ARDoc INNER JOIN
                         dbo.Customer ON dbo.ARDoc.CustId = dbo.Customer.CustId LEFT OUTER JOIN
                         dbo.PJINVHDR ON dbo.ARDoc.RefNbr = dbo.PJINVHDR.invoice_num
WHERE        (dbo.ARDoc.PC_Status = '1') AND (dbo.ARDoc.Rlsed = 1)
