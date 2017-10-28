 /****** Object:  Stored Procedure dbo.CashAvgD_Period    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashAvgD_Period @parm1 varchar ( 10), @parm2 varchar(10), @Parm3 varchar ( 24), @parm4 varchar ( 6) as
    Select * from CashAvgD where cpnyid like @parm1 and bankacct like @parm2 and banksub like @parm3 and PerNbr like @parm4
     Order by CpnyID, BankAcct, Banksub, PerNbr


