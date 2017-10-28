

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 1/13/2011
-- Description:	Returns Sow Sites 
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_FEED_CONSUMPTION_SITE_remove]
(
	
		
	 @Region			varchar(20)

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
	DECLARE @TempRegion varchar(20)

	IF @Region = '%' 

	BEGIN
		SET @TempRegion = '%'
	END
	
	ELSE
	BEGIN
		SET @TempRegion = @Region
	END

	Select -1 as SiteID, '--All--' as Contactname
	Union All

	Select Distinct 
	SiteID,
	ContactName2 as ContactName
	
	From  dbo.cfv_SOW_DIVISION_REGION_SITE
	
	Where Region like @TempRegion

	Group by
	Contactname2,
	SiteID
	
	END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_FEED_CONSUMPTION_SITE_remove] TO [db_sp_exec]
    AS [dbo];

