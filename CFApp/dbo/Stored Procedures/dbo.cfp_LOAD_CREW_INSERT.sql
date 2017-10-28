-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <01/01/2008>
-- Description:	<Inserts a Cutoout record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_INSERT]
(
	@LoadCrewName				    varchar(50),
	@CreatedBy					    varchar(50)
)	
AS
BEGIN
	INSERT INTO dbo.cft_LOAD_CREW
	(
		[LoadCrewName],
		[CreatedBy]
	)
	VALUES 
	(	
		@LoadCrewName,
		@CreatedBy
	)
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_INSERT] TO [db_sp_exec]
    AS [dbo];

