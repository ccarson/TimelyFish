 /****** Object:  Stored Procedure dbo.BankRec_LastStmt    Script Date: 4/7/98 12:49:19 PM ******/
Create Proc BankRec_LastStmt @parm1 smalldatetime as
Select * from BankRec
where ReconDate > @parm1
Order by recondate desc


