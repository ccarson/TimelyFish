-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <11/19/2007>
-- Description:	<Delete Packer Contract record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_CONTRACT_DELETE]
(
	@ContractID					int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Delete from dbo.cft_PACKER_CONTRACT
	Where ContractID = @ContractID
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_CONTRACT_DELETE] TO [db_sp_exec]
    AS [dbo];

