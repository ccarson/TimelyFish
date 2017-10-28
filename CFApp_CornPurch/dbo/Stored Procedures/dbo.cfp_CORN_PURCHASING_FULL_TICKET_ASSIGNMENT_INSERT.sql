
-- ===================================================================
-- Author:  Andrew Derco
-- Create date: 04/29/2008
-- Description: Creates new FullTicketAssignment record.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_FULL_TICKET_ASSIGNMENT_INSERT]
(
    @TicketID int,
    @CornProducerID varchar(15),
    @Assignment decimal(7,4),
    @GroupName varchar(1000),
    @CreatedBy  varchar(50)
)
AS
BEGIN
  SET NOCOUNT ON

  INSERT dbo.cft_FULL_TICKET_ASSIGNMENT
  (
      [TicketID],
      [CornProducerID],
      [Assignment],
      [GroupName],
      [CreatedBy]
  )
  VALUES
  (
      @TicketID,
      @CornProducerID,
      @Assignment,
      @GroupName,
      @CreatedBy
  )
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_FULL_TICKET_ASSIGNMENT_INSERT] TO [db_sp_exec]
    AS [dbo];

