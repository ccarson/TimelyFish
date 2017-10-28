
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/29/2009
-- Description:	CENTRAL DATA - Updates a phone record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_PHONE_UPDATE
(
	@PhoneID		int,
	@PhoneNbr		varchar(10),
	@Extension		varchar(50),
	@SpeedDial		int
)
AS
BEGIN
	UPDATE [$(CentralData)].dbo.Phone
	SET [PhoneNbr] = @PhoneNbr
		,[Extension] = @Extension
		,[SpeedDial] = @SpeedDial
	WHERE 
		[PhoneID] = @PhoneID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_PHONE_UPDATE] TO [db_sp_exec]
    AS [dbo];

