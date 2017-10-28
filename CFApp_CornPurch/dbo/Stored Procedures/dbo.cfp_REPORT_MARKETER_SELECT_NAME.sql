-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/06/2008
-- Description:	Returns name by MarketerID
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_MARKETER_SELECT_NAME]
(
   @MarketerID	int
)
AS
BEGIN
	SET NOCOUNT ON;

IF @MarketerID = 0 BEGIN

  SELECT 'All Marketers' AS MarketerName
       
END ELSE BEGIN

  SELECT 
         LTRIM(RTRIM(FirstName)) + ' ' + LTRIM(RTRIM(MiddleInitial)) + ' ' + LTRIM(RTRIM(LastName)) AS MarketerName
  FROM dbo.cft_MARKETER
  WHERE MarketerID = @MarketerID

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKETER_SELECT_NAME] TO [db_sp_exec]
    AS [dbo];

