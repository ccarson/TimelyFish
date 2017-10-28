-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/16/2008
-- Description:	Inserts a record into cfp_AUGER_INSERT
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_AUGER_INSERT]
(
		@Size						varchar(25)
		,@Active					bit
		,@CreatedBy					varchar(50)
)
AS
BEGIN
INSERT INTO [cft_AUGER]
(
	   [Size]
	   ,[Active]
	   ,[CreatedBy]
)
VALUES
(
		@Size
		,@Active
		,@CreatedBy
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_AUGER_INSERT] TO [db_sp_exec]
    AS [dbo];

