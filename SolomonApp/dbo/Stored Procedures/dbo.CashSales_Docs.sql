 Create proc CashSales_Docs @parm1 varchar (10), @parm2 varchar (10) AS
SELECT * FROM ARDoc
WHERE batnbr = @parm1 AND refnbr <> @parm2 and doctype IN ('CS','RF')


