
-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Returns Region in Division
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_PL_REGION]
(
	@StartPeriod		int
	,@EndPeriod			int
	,@Division			varchar(20)
	   
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

	SELECT	'--All--' as Region
	UNION ALL
	SELECT	DISTINCT

	Region

	from  dbo.cfv_SOW_DIVISION_REGION_SITE

	Where
	Division like @TempDivision
	
	Order by
	Region
			
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_PL_REGION] TO [db_sp_exec]
    AS [dbo];

