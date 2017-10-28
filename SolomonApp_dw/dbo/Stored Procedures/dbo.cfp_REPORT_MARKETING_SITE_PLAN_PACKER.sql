-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/01/2011
-- Description:	This procedure makes the Packer dataset for the Marketing Site Plan report.
-- =============================================
CREATE PROCEDURE dbo.cfp_REPORT_MARKETING_SITE_PLAN_PACKER 
	-- Add the parameters for the stored procedure here
	@SiteName Char(50)
	
AS
BEGIN

SET NOCOUNT ON;

Declare @SiteContactID Char(6)
Select @SiteContactID = SiteContactID From  dbo.cfv_Site Where RTrim(SiteContactName) = RTrim(@SiteName)


-----------------------------------------------
--Destinations
-----------------------------------------------

Declare @Destination Table
(Packer Char(10)
, TotalHeadcount Float
, AverageRealizedWeight Float
, TargetToppingWeight Float
, TargetCloseoutWeight Float)

Insert Into @Destination

Select Case When p.PkrContactID = '002936' Then 'Triumph'
	When p.PkrContactID = '000823' Then 'Tyson'
	When p.PkrContactID In('000555','000554') Then 'Swift'
	Else 'Other' End As Packer
, Sum(p.Headcount) As TotalHeadcount
, Sum(p.DelvLiveWgt)/Sum(p.Headcount) As AverageRealizedWeight
, Null As TargetToppingWeight
, Null As TargetCloseoutWeight

From [$(SolomonApp)].dbo.cfvPIGSALEREV p


Where p.SiteContactID = @SiteContactID
	And KillDate >= DateAdd(yy,-1,GetDate())
	
Group By Case When p.PkrContactID = '002936' Then 'Triumph'
	When p.PkrContactID = '000823' Then 'Tyson'
	When p.PkrContactID In('000555','000554') Then 'Swift'
	Else 'Other' End

Update d
Set TargetToppingWeight = p.TargetToppingWeight
, TargetCloseoutWeight = p.TargetCloseoutWeight
From @Destination d
	Left Join  dbo.cft_PACKER_YIELD_ASSUMPTIONS p On d.Packer = p.Packer
	
Select *
From @Destination

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_MARKETING_SITE_PLAN_PACKER] TO [db_sp_exec]
    AS [dbo];

