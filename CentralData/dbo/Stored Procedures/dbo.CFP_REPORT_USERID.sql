
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CFP_REPORT_USERID] 
	
	@ContactID  [char](6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT
	 c.SolomonContactID
	,e.UserID as UserName
FROM   dbo.Contact c (NOLOCK) 
	INNER JOIN  dbo.Employee e (NOLOCK) on c.ContactID = e.ContactID
	WHERE c.SolomonContactID = @ContactID
END

