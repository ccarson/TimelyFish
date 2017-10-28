 /****** Object:  Stored Procedure dbo.CashSumD_Date    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_Date @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime as
    Select * from CashSumD where cpnyid like @parm1 and bankacct like @parm2 and banksub like @parm3
     and (trandate >= @parm4 and trandate <= @parm5)
     Order by Cpnyid, BankAcct, Banksub, trandate


