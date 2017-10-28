 CREATE PROCEDURE SMInvoiceSN_ASID @parm1 int

AS
	SELECT * FROM smInvoice WHERE ASID = @parm1 and (Doctype = 'C' or Doctype = 'M') ORDER BY asid


