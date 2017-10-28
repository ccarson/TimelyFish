 /****** Object:  Stored Procedure dbo.POBudHist_all    Script Date: 12/17/97 10:48:25 AM ******/
Create Procedure POBudHist_all @parm1 Varchar(10), @parm2 Varchar(24), @parm3 Varchar(10), @parm4 Varchar(4) as
Select * from POBudhist where
acct = @parm1 and
sub = @parm2 and
Ledgerid = @parm3 and
FiscYr = @parm4
Order By acct, sub, Ledgerid, fiscyr


