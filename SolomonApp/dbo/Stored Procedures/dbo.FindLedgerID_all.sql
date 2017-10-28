 /****** Object:  Stored Procedure dbo.FindLedgerID_all    Script Date: 4/7/98 12:38:58 PM ******/
Create Procedure FindLedgerID_all @parm1 varchar ( 10)  As
Select LedgerID from Ledger where ledgerid like @parm1
Order by LedgerID

