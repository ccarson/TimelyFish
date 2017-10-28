-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/06/2007>
-- Description:	<Updates a Packer Contract record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_CONTRACT_UPDATE]
(
	@ContractID 					int,
	@ContactID 						int,
	@ContractFromDate				smalldatetime,
	@ContractToDate					smalldatetime,
	@PriceAllowance					decimal(10, 4),
	@CutOutOverage					decimal(10, 4),
	@LeanFormulaXValue				decimal(12, 10),
	@LeanFormulaX2Value				decimal(12, 10),
	@LeanFormulaX3Value				decimal(12, 10),
	@LeanFormulaConstantValue		decimal(12, 10),
	@UpdatedBy					    varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_PACKER_CONTRACT
	SET ContactID = @ContactID,
		ContractFromDate = @ContractFromDate,
		ContractToDate = @ContractToDate,
		PriceAllowance = @PriceAllowance,
		CutOutOverage = @CutOutOverage,
		LeanFormulaXValue = @LeanFormulaXValue,
		LeanFormulaX2Value = @LeanFormulaX2Value,
		LeanFormulaX3Value = @LeanFormulaX3Value,
		LeanFormulaConstantValue = @LeanFormulaConstantValue,
		UpdatedBy = @UpdatedBy,
		UpdatedDateTime = getdate()
	WHERE ContractID = @ContractID 
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_CONTRACT_UPDATE] TO [db_sp_exec]
    AS [dbo];

