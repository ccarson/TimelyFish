 /****** Object:  Stored Procedure dbo.CashSumD_Currncy_All    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_Currncy_All @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24) as
    Select * from CashSumD, Currncy where cashsumd.cpnyid like @parm1 and cashsumd.bankacct like @parm2 and cashsumd.banksub like @parm3 and Cashsumd.Curyid = Currncy.Curyid
     Order by CpnyID DESC, BankAcct DESC, Banksub DESC, trandate desc


