 /****** Object:  Stored Procedure dbo.CashAcct_By_Name    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashAcct_By_Name @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 varchar ( 4) as
    select * from CashAcct, Currncy
    where cpnyid like @parm1 and bankacct like @parm2 and banksub like @parm3 and CashAcct.curyid like @parm4
    and active =  1 and cashacct.curyid = currncy.curyid
     order by CpnyID, BankAcct, Banksub


