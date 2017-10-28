 /****** Object:  Stored Procedure dbo.CashSumD_Period    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_Period @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 varchar ( 6)  as
  Select * from CashSumD where CpnyID like @parm1 and BankAcct like @parm2 and Banksub like @parm3 and pernbr =       @parm4
   Order by CpnyID, BankAcct, Banksub, pernbr


