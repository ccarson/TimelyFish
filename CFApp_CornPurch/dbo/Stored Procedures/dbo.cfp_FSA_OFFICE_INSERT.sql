-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 07/21/2008
-- Description:	Inserts a record into cft_FSA_OFFICE
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_FSA_OFFICE_INSERT]
(
		@FsaOfficeID				varchar(15)
		,@ContactID					int
		,@Active					bit
		,@CreatedBy					varchar(50)
)
AS
BEGIN
INSERT INTO [cft_FSA_OFFICE]
(
		[FsaOfficeID]
	   ,[ContactID]
	   ,[Active]
	   ,[CreatedBy]
)
VALUES
(
		@FsaOfficeID
		,@ContactID
		,@Active
		,@CreatedBy
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FSA_OFFICE_INSERT] TO [db_sp_exec]
    AS [dbo];

