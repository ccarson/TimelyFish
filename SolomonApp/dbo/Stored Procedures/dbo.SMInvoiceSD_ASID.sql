 CREATE PROCEDURE SMInvoiceSD_ASID @parm1 int

AS
	SELECT * FROM smInvoice WHERE ASID = @parm1 and (Doctype = 'S' and BillingType <> "M") ORDER BY asid


