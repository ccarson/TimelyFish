-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/06/2007>
-- Description:	<Inserts a Packer Contract record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_CONTRACT_INSERT]
(
	@ContactID						int,
	@ContractFromDate				smalldatetime,
	@ContractToDate					smalldatetime,
	@PriceAllowance					decimal(10, 4),
	@CutOutOverage					decimal(10, 4),
	@LeanFormulaXValue				decimal(12, 10),
	@LeanFormulaX2Value				decimal(12, 10),
	@LeanFormulaX3Value				decimal(12, 10),
	@LeanFormulaConstantValue		decimal (12, 10),
	@CreatedBy					    varchar(50)
)	
AS
BEGIN
	INSERT INTO dbo.cft_PACKER_CONTRACT
	(   
		[ContactID],
		[ContractFromDate],
		[ContractToDate],
		[PriceAllowance],
		[CutOutOverage],
		[LeanFormulaXValue],
		[LeanFormulaX2Value],
		[LeanFormulaX3Value],
		[LeanFormulaConstantValue],
		[CreatedBy]
	)
	VALUES 
	(	
		@ContactID,
		@ContractFromDate,
		@ContractToDate,
		@PriceAllowance,
		@CutOutOverage,
		@LeanFormulaXValue,
		@LeanFormulaX2Value,
		@LeanFormulaX3Value,
		@LeanFormulaConstantValue,
		@CreatedBy
	)
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_CONTRACT_INSERT] TO [db_sp_exec]
    AS [dbo];

