-- =============================================
-- Author:	Andrey Derco
-- Create date: 10/13/2008
-- Description:	Returns all ticket payment types
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PAYMENT_TYPE_SELECT]
(
   @IncludeAll	bit
)
AS
BEGIN
	SET NOCOUNT ON;

IF @IncludeAll = 1 BEGIN

  SELECT 0 AS PaymentTypeID,
         '--All--' AS PaymentTypeName
       
  UNION ALL 

  SELECT PaymentTypeID,
         Name
  FROM dbo.cft_TICKET_PAYMENT_TYPE

  ORDER BY 2

END ELSE BEGIN

  SELECT PaymentTypeID,
         Name AS PaymentTypeName
  FROM dbo.cft_TICKET_PAYMENT_TYPE
  ORDER BY 2

END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PAYMENT_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

