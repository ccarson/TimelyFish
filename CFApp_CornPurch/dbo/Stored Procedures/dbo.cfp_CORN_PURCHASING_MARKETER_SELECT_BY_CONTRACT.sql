
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 07/11/2008
-- Description: Selects all Marketers for Contract
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT_BY_CONTRACT]
(
    @ContractID		int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT CM.MarketerID,    
       ISNULL(M.FirstName + ' ' + ISNULL(M.MiddleInitial, '') + ' ' + ISNULL(M.LastName, ''), '') as Name,
       CM.Value,
       CM.[CreatedDateTime],
       CM.[CreatedBy],
       CM.[UpdatedDateTime],
       CM.[UpdatedBy]
FROM  dbo.cft_CONTRACT_MARKETER CM
INNER JOIN dbo.cft_MARKETER M ON Cm.MarketerID = M.MarketerID
WHERE ContractID = @ContractID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_MARKETER_SELECT_BY_CONTRACT] TO [db_sp_exec]
    AS [dbo];

