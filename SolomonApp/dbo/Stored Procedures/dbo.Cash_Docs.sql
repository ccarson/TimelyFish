 Create proc Cash_Docs @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (15) AS
SELECT * FROM ARDoc
WHERE batnbr = @parm1 AND (refnbr <> @parm2 or custid <> @parm3) and doctype IN ('PA','PP')


