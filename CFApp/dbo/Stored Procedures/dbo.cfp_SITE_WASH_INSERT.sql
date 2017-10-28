
-- ==================================================
-- Author:	mdawson
-- Create date: 11/8/2007
-- Description:	Inserts a Site Wash Schedule Record
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_SITE_WASH_INSERT]
(
	@ContactID				int,
	@WashFromEffectDate		datetime,
	@WashToEffectDate		datetime,
	@CreatedBy				varchar(50)
)	
AS
BEGIN
	INSERT INTO dbo.cft_SITE_WASH
	(   
		[ContactID],
		[WashFromEffectDate],
		[WashToEffectDate],
		[CreatedBy]
	)
	VALUES 
	(	
		@ContactID,
		@WashFromEffectDate,
		@WashToEffectDate,
		@CreatedBy
	)
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_WASH_INSERT] TO [db_sp_exec]
    AS [dbo];

