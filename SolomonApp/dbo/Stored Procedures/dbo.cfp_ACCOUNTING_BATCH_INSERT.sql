-- =======================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/13/2008
-- Description:	Inserts a batch record into the Batch table 
-- =======================================================================
CREATE PROCEDURE dbo.cfp_ACCOUNTING_BATCH_INSERT
(
	@BalanceType				char(1)
	,@BaseCuryID				char(4)
	,@BatNbr					char(10)
	,@BatType					char(1)
	,@CpnyID					char(10)
	,@Crtd_Prog					char(8)
	,@Crtd_User					char(10)
	,@CrTot						float
	,@CtrlTot					float
	,@CuryCrTot					float
	,@CuryCtrlTot				float
	,@CuryDepositAmt			float
	,@CuryDrTot					float
	,@CuryEffDate				smalldatetime
	,@CuryId					char(4)
	,@CuryMultDiv				char(1)
	,@CuryRate					float
	,@DateEnt					smalldatetime
	,@DrTot						float
	,@EditScrnNbr				char(5)
	,@GLPostOpt					char(1)
	,@JrnlType					char(3)
	,@LedgerID					char(10)
	,@Module					char(2)
	,@PerEnt					char(6)
	,@PerPost					char(6)
	,@Rlsed						smallint
	,@Status					char(1)
)
AS
BEGIN
INSERT INTO SolomonApp.dbo.Batch
(
	BalanceType
	,BaseCuryID
	,BatNbr
	,BatType
	,CpnyID
	,Crtd_Prog
	,Crtd_User
	,CrTot
	,CtrlTot
	,CuryCrTot	
	,CuryCtrlTot
	,CuryDepositAmt
	,CuryDrTot
	,CuryEffDate
	,CuryId
	,CuryMultDiv
	,CuryRate
	,DateEnt
	,DrTot
	,EditScrnNbr
	,GLPostOpt
	,JrnlType
	,LedgerID
	,Module
	,PerEnt
	,PerPost
	,Rlsed
	,Status
)
VALUES
(
	@BalanceType
	,@BaseCuryID  
	,@BatNbr
	,@BatType
	,@CpnyID
	,@Crtd_Prog
	,@Crtd_User
	,@CrTot
	,@CtrlTot
	,@CuryCrTot	
	,@CuryCtrlTot
	,@CuryDepositAmt
	,@CuryDrTot
	,@CuryEffDate
	,@CuryId
	,@CuryMultDiv
	,@CuryRate
	,@DateEnt
	,@DrTot
	,@EditScrnNbr
	,@GLPostOpt
	,@JrnlType
	,@LedgerID
	,@Module
	,@PerEnt
	,@PerPost
	,@Rlsed
	,@Status
)
END

