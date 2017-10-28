 /****** Object:  Stored Procedure dbo.CARecur_Date    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CARecur_Date @parm1 smalldatetime, @parm2 varchar(10) as
    select * from CARecur
     where NextGenDate <= @parm1
     and CpnyID like @parm2
    order by CpnyID, Bankacct, BankSub


