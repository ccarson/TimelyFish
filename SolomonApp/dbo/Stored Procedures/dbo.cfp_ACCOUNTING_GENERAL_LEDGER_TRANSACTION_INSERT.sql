-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/18/2008
-- Description:	Inserts an inventory into the inventory transaction table
-- =======================================================================
CREATE PROCEDURE dbo.cfp_ACCOUNTING_GENERAL_LEDGER_TRANSACTION_INSERT
(	
		@Acct							char(10)
		,@BalanceType					char(1)
		,@BaseCuryID					char(4)
		,@BatNbr						char(10)
		,@CpnyID						char(10)
		,@CrAmt							float
		,@Crtd_Prog						char(8)
		,@Crtd_User						char(10)
		,@CuryCrAmt						float
		,@CuryDrAmt						float
		,@CuryEffDate					smalldatetime
		,@CuryId						char(4)
		,@CuryMultDiv					char(1)
		,@CuryRate						float
		,@DrAmt							float
		,@FiscYr						char(4)
		,@JrnlType						char(3)
		,@LedgerID						char(10)
		,@LineID						int
		,@LineNbr						int
		,@LineRef						char(5)
		,@Module						char(2)
		,@PerEnt						char(6)
		,@PerPost						char(6)
		,@Posted						char(1)
		,@Qty							float
		,@RefNbr						char(10)
		,@Rlsed							smallint
		,@Sub							char(24)
		,@TranDate						smalldatetime
		,@TranDesc						char(30)
		,@TranType						char(2)
)
AS
BEGIN
INSERT INTO SolomonApp.dbo.GLTran
(
		Acct
		,BalanceType
		,BaseCuryID
		,BatNbr
		,CpnyID
		,CrAmt
		,Crtd_DateTime
		,Crtd_Prog
		,Crtd_User
		,CuryCrAmt
		,CuryDrAmt
		,CuryEffDate
		,CuryId
		,CuryMultDiv
		,CuryRate
		,DrAmt
		,FiscYr
		,JrnlType
		,LedgerID
		,LineID
		,LineNbr
		,LineRef
		,LUpd_DateTime
		,LUpd_Prog
		,LUpd_User
		,Module
		,PerEnt
		,PerPost
		,Posted
		,Qty
		,RefNbr
		,Rlsed
		,Sub
		,TranDate
		,TranDesc
		,TranType
		,AppliedDate
		,CuryRateType
		,EmployeeID
		,ExtRefNbr
		,IC_Distribution
		,Id
		,Labor_Class_Cd
		,NoteID
		,OrigAcct
		,OrigBatNbr
		,OrigCpnyID
		,OrigSub
		,PC_Flag
		,PC_ID
		,PC_Status
		,ProjectID
		,RevEntryOption
		,S4Future01
		,S4Future02
		,S4Future03
		,S4Future04
		,S4Future05
		,S4Future06
		,S4Future07
		,S4Future08
		,S4Future09
		,S4Future10
		,S4Future11
		,S4Future12
		,ServiceDate
		,TaskID
		,Units
		,User1
		,User2
		,User3
		,User4
		,User5
		,User6
		,User7
		,User8
)
VALUES
(
		@Acct
		,@BalanceType
		,@BaseCuryID
		,@BatNbr
		,@CpnyID
		,@CrAmt
		,getdate()		-- Crtd_DateTime
		,@Crtd_Prog
		,@Crtd_User
		,@CuryCrAmt
		,@CuryDrAmt
		,@CuryEffDate
		,@CuryId
		,@CuryMultDiv
		,@CuryRate
		,@DrAmt
		,@FiscYr
		,@JrnlType
		,@LedgerID
		,@LineID
		,@LineNbr
		,@LineRef
		,getdate()		-- LUpd_DateTime
		,@Crtd_Prog		-- LUpd_Prog
		,@Crtd_User		-- LUpd_User
		,@Module
		,@PerEnt
		,@PerPost
		,@Posted
		,@Qty
		,@RefNbr
		,@Rlsed
		,@Sub
		,@TranDate
		,@TranDesc
		,@TranType
		,'01/01/1900'	-- AppliedDate
		,''				-- CuryRateType
		,''				-- EmployeeID
		,''				-- ExtRefNbr
		,0				-- IC_Distribution
		,''				-- Id
		,''				-- Labor_Class_Cd
		,0				-- NoteID
		,''				-- OrigAcct
		,''				-- OrigBatNbr
		,''				-- OrigCpnyID
		,''				-- OrigSub
		,'N'			-- PC_Flag
		,''				-- PC_ID
		,'0'			-- PC_Status
		,''				-- ProjectID
		,''				-- RevEntryOption
		,''				-- S4Future01
		,''				-- S4Future02
		,0				-- S4Future03
		,0				-- S4Future04
		,0				-- S4Future05
		,0				-- S4Future06
		,getdate()		-- S4Future07
		,'01/01/1900'	-- S4Future08
		,0				-- S4Future09
		,0				-- S4Future10
		,'C'			-- S4Future11
		,''				-- S4Future12
		,'01/01/1900'	-- ServiceDate
		,''				-- TaskID
		,0				-- units
		,''				-- User1
		,''				-- User2
		,0				-- User3
		,0				-- User4
		,''				-- User5
		,''				-- User6
		,'01/01/1900'	-- User7
		,'01/01/1900'	-- User8
)
END

