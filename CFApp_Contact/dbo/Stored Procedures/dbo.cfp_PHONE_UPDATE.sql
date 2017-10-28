
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/22/2008
-- Description:	Updates a phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_PHONE_UPDATE
(
	@PhoneID		int,
	@PhoneNbr		varchar(10),
	@Extension		varchar(50),
	@SpeedDial		int,
	@UpdatedBy		varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_PHONE
	SET [PhoneNbr] = @PhoneNbr
		,[Extension] = @Extension
		,[SpeedDial] = @SpeedDial
		,[UpdatedBy] = @UpdatedBy

	WHERE 
		[PhoneID] = @PhoneID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PHONE_UPDATE] TO [db_sp_exec]
    AS [dbo];

