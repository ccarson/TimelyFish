

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 05/13/2011
-- Description:	Returns Adjusted Inventory Count for Closed Groups
-- =============================================
CREATE PROCEDURE [dbo].[cfp_TRANSPORTATION_INVENTORY_CHECK_GROWOUT]
(
	
	 @StartDate			DateTime
	,@EndDate			DateTime
   
)
	AS
	BEGIN
	SET NOCOUNT ON

	Select 
	PG.PigGroupID,
	PG.ActCloseDate,
	PG.PigProdPhaseID,
	Contact.ContactName,
	Sum(PGTran.Qty) as Variance

	from [$(SolomonApp)].dbo.cftPigGroup PG

	left join [$(SolomonApp)].dbo.cftPGInvTran PGTran 
	on PG.PigGroupID = PGTran.PigGroupID
	
	left join [$(SolomonApp)].dbo.cftContact Contact
	on PG.SiteContactID = Contact.ContactID

	where PGTran.Acct = 'Pig Inv Adj' 
	and PGTran.Reversal = 0
	and PGTran.Rlsed = 1
	and PG.ActCloseDate between @StartDate and @EndDate
	
	Group by
	PG.PigGroupID,
	PG.ActCloseDate,
	PG.PigProdPhaseID,
	Contact.ContactName

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TRANSPORTATION_INVENTORY_CHECK_GROWOUT] TO [db_sp_exec]
    AS [dbo];

