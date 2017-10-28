 /****** Object:  Stored Procedure dbo.CashAcct_Acct    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashAcct_Acct @parm1 varchar ( 10), @parm2 varchar(10) as
    select * from CashAcct
     where cpnyid like @parm1 and bankacct like @parm2
    and active =  1
    order by CpnyID, BankAcct


