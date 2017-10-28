 /****** Object:  Stored Procedure dbo.RQBudHist_all    Script Date: 9/4/2003 6:21:18 PM ******/

/****** Object:  Stored Procedure dbo.RQBudHist_all    Script Date: 7/5/2002 2:44:38 PM ******/

CREATE Procedure RQBudHist_all @parm1 Varchar(10), @parm2 Varchar(24), @parm3 Varchar(10), @parm4 Varchar(4), @parm5 varchar(10)  as
Select * from RQBudhist where
acct = @parm1 and
sub = @parm2 and
Ledgerid = @parm3 and
FiscYr = @parm4 and
User5 = @parm5
Order By acct, sub, Ledgerid, fiscyr


