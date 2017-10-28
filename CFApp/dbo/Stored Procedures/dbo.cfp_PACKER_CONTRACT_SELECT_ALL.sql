-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/06/2007>
-- Description:	<Selects PackerContract record(s)>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_CONTRACT_SELECT_ALL]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select packerContract.ContractID,
			packerContract.ContactID, 
			contact.ContactName,
			packerContract.ContractFromDate,
			packerContract.ContractToDate,
			packerContract.PriceAllowance,
			packerContract.CutOutOverage,
			packerContract.LeanFormulaXValue,
			packerContract.LeanFormulaX2Value,
			packerContract.LeanFormulaX3Value,
			packerContract.LeanFormulaConstantValue
	from dbo.cft_PACKER_CONTRACT packerContract (NOLOCK)
	inner join [$(CentralData)].dbo.Contact contact (NOLOCK)
	on contact.ContactID = packerContract.ContactID
	Where Inactive is null
	Order By contact.ContactName
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_CONTRACT_SELECT_ALL] TO [db_sp_exec]
    AS [dbo];

