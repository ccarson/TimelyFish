 /****** Object:  Stored Procedure dbo.RQAcctHist_all    Script Date: 12/17/97 10:48:22 AM ******/
CREATE Procedure RQAcctHist_all @parm1 Varchar(10), @parm2 Varchar(24), @parm3 Varchar(10), @parm4 Varchar(4), @parm5 varchar(10) as
Select * from accthist where
acct = @parm1 and
sub = @parm2 and
LedgerID = @parm3 and
FiscYr = @parm4 and
CpnyID = @parm5
Order By acct, sub, ledgerID, fiscyr


