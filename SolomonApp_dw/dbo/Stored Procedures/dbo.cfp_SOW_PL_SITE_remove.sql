
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns Sites in Region & Division
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_PL_SITE_remove]
(
	@Division			varchar(20)
	,@Region			varchar(20)
	   
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TempDivision varchar(20)

	IF @Division = '%' 

	BEGIN
		SET @TempDivision = '%'
	END
	
	ELSE
	BEGIN
		SET @TempDivision = @Division
	END
	
	DECLARE @TempRegion varchar(20)

	IF @Region = '%' 

	BEGIN
		SET @TempRegion = '%'
	END
	
	ELSE
	BEGIN
		SET @TempRegion = @Region
	END

	SELECT	-1 as SiteID, '--All--' as Site
	UNION ALL
	SELECT	DISTINCT
	
	SiteID,
	ContactName2 as Site

	from  dbo.cfv_SOW_DIVISION_REGION_SITE

	Where
	Division like @TempDivision
	and Region like @TempRegion
	
	Group by
	ContactName2,
	SiteID
	
			
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_PL_SITE_remove] TO [db_sp_exec]
    AS [dbo];

