 /****** Object:  Stored Procedure dbo.APDoc_PayDate    Script Date: 4/7/98 12:49:19 PM ******/
Create Proc APDoc_PayDate @parm1 smalldatetime, @parm2 smalldatetime as
Select * from APDoc where paydate between @parm1 and @parm2
Order by cpnyid, acct, sub, Refnbr


