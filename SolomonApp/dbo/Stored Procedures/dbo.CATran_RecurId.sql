 /****** Object:  Stored Procedure dbo.CATran_RecurId    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CATran_RecurId @parm1 varchar ( 10), @parm2 varchar(10) as
  Select * from CATran
  Where RecurId like @parm1
  and BankCpnyID like @parm2
  and batnbr = recurid
Order by RecurId, BankCpnyID, linenbr


