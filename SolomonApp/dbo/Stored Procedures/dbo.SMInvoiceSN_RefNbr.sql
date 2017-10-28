 CREATE PROCEDURE SMInvoiceSN_RefNbr @parm1 varchar(10)

AS
	SELECT * FROM smInvoice WHERE Refnbr LIKE @parm1 and (Doctype = 'C' or Doctype = 'M') ORDER BY Refnbr


