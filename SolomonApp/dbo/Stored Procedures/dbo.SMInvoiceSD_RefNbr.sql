 CREATE PROCEDURE SMInvoiceSD_RefNbr @parm1 varchar(10)

AS
	SELECT * FROM smInvoice WHERE Refnbr LIKE @parm1 and (Doctype = 'S' and BillingType <> "M") ORDER BY Refnbr


