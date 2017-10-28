-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/06/2008
-- Description:	Returns all active Marketers
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_MARKETER_SELECT]
(
   @IncludeAll	bit
)
AS
BEGIN
	SET NOCOUNT ON;

IF @IncludeAll = 1 BEGIN

  SELECT 0 AS MarketerID,
         '--All--' AS MarketerName
       
  UNION ALL 

  SELECT MarketerID,
         LTRIM(RTRIM(FirstName)) + ' ' + LTRIM(RTRIM(MiddleInitial)) + ' ' + LTRIM(RTRIM(LastName)) AS MarketerName
  FROM dbo.cft_MARKETER
  WHERE MarketerStatusID = 1
  ORDER BY 2

END ELSE BEGIN

  SELECT MarketerID,
         LTRIM(RTRIM(FirstName)) + ' ' + LTRIM(RTRIM(MiddleInitial)) + ' ' + LTRIM(RTRIM(LastName)) AS MarketerName
  FROM dbo.cft_MARKETER
  WHERE MarketerStatusID = 1
  ORDER BY 2

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKETER_SELECT] TO [db_sp_exec]
    AS [dbo];

