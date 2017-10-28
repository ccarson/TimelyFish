
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/07/2008
-- Description:	 inserts record into temp table for previewing commissions on commission management screen
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_INSERT_TEMP_TABLE
(
 @PartialTicketID	int, 
 @MarketerID		int 
)
AS
BEGIN
SET NOCOUNT ON;


INSERT dbo.cft_COMMISSION_TEMP
(
  PartialTicketID, 
  MarketerID
) 
VALUES 
(
  @PartialTicketID, 
  @MarketerID
)


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_INSERT_TEMP_TABLE] TO [db_sp_exec]
    AS [dbo];

