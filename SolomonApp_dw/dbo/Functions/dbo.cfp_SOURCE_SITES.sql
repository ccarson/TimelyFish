



-- =============================================
-- Author:		Brian Diehl
-- Create date: 2/21/2013
-- Description:	Returns Source Site names for a piggroup (use for non-SLF flows)
-- =============================================
CREATE FUNCTION [dbo].[cfp_SOURCE_SITES] (@PigGroupID	VARCHAR(10))
  RETURNS varchar(1000)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

Declare @columns varchar(1000)

SELECT 
@columns= 
coalesce(@columns+', '+ContactName, ContactName )
  FROM [dbo].[cft_PIG_FLOW_SOURCE_FARMS] PFSF
  INNER JOIN [$(CentralData)].dbo.contact c on pfsf.SourceContactID = C.ContactID
  where PFSF.PigGroupID='PG'+@PigGroupID

return @columns
	
END



