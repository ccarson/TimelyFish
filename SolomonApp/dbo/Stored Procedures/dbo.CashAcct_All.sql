 /****** Object:  Stored Procedure dbo.CashAcct_All    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashAcct_All @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24) as
    Select * from Cashacct where cpnyid like @parm1 and bankacct like @parm2 and banksub like @parm3
    Order by CpnyID, BankAcct, Banksub


