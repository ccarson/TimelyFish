
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/11/2008
-- Description: Updates Marketer for Contract
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_MARKETER_UPDATE_BY_CONTRACT]
(
    @ContractID	int,
    @MarketerID	int,
    @Value	decimal(5,2),
    @CreatedBy	varchar(50)
)
AS
BEGIN
SET NOCOUNT ON;



INSERT dbo.cft_CONTRACT_MARKETER
(
   ContractID,
   MarketerID,
   Value,
   CreatedBy
)
VALUES
(
   @ContractID,
   @MarketerID,
   @Value,
   @CreatedBy   
)

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_UPDATE_BY_CONTRACT] TO [db_sp_exec]
    AS [dbo];

