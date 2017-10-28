-- =============================================
-- Author:		Dave Killion
-- Create date: 11/26/2007
-- Description:	Returns valid pig suppliers for
-- purchased pigs that have valid contracts based 
-- upon the date supplied
-- =============================================
create PROCEDURE [dbo].[cfp_PURCHASED_PIG_SUPPLIERS_SELECT_BY_DATE]
	-- Add the parameters for the stored procedure here
	@DeliveryDate DateTime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select
	pp.PurchaseDate
	,pp.ContactID
	,c.ContactName
	,pp.BegDelvDate BeginDeliveryDate
	,pp.EndDelvDate EndDeliveryDate
	, '' BarnNumber
	, '' RoomNumber
	, '' PigGroupID
	, 'PP' + pp.ContactID ProjectID
	, 'SC00000' TaskID
from [$(SolomonApp)].dbo.cftPigPurchase pp (NOLOCK)
JOIN [$(SolomonApp)].dbo.cftContact c (NOLOCK) on pp.ContactID=c.ContactID 
where @DeliveryDate between BegDelvDate and EndDelvDate
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PURCHASED_PIG_SUPPLIERS_SELECT_BY_DATE] TO [db_sp_exec]
    AS [dbo];

