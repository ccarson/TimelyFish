-- ==================================================================
-- Author:        Brian Cesafsky
-- Create date: 02/26/2009
-- Description:   CENTRAL DATA - Returns all barns by site ID 
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_BARN_SELECT_BY_SITE_ID]
(
      @SiteID           varchar(4)
)
AS
BEGIN
      SET NOCOUNT ON;

      SELECT Contact.ContactName
            , Barn.ContactID
            , Barn.SiteID
            , Barn.BarnNbr 
            , BarnChar.BarnID
            , BarnChar.StdPenWidth
            , BarnChar.StdPenLength
            , BarnChar.NbrStdPens
            , BarnChar.NbrStdPenSpace
            , BarnChar.FloorType
            , BarnChar.FeederType
            , BarnChar.FeederWidth
            , BarnChar.FeedersPerPen
            , BarnChar.WatererType
            , BarnChar.WaterersPerPen
            , BarnChar.SupplHeatSource
            , BarnChar.SupplHeatAvailable
            , BarnChar.SupplHeat
            , BarnChar.CenterToLoadoutDist
            , BarnChar.NbrOfLoadouts
            , BarnChar.PaymentSpaces
            , BarnChar.ContractType
            , Case 
                  when SupplHeat <> 'None' -- 2 No
                        and Site.OwnershipID in (1, 3, 8) Then 1 --Company, Company Managed, Company/Sublet    
                  When SupplHeat <> 'None' -- 2 No    
                        and Site.OwnershipID in (2, 7) --Contract, Contract/Sublet
                        and BarnChar.ContractType in (2, 3, 6, 7) Then 1 --FP MO, FP WP Option, WF, WF Single Stock
                  Else 0 
              End WFCapable
            , BarnChar.WFCapableOverride
            , BarnChar.NurAvailable
            , BarnChar.BigPen
            , BarnChar.NonPigSpace
      FROM [$(CentralData)].dbo.Barn Barn (NOLOCK)
      LEFT JOIN [$(CentralData)].dbo.BarnChar BarnChar (NOLOCK)
            On BarnChar.BarnID=Barn.BarnID
      LEFT JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
            On Barn.ContactID=Contact.ContactID
      LEFT JOIN [$(CentralData)].dbo.Site Site (NOLOCK)
            On Barn.SiteID=Site.SiteID
      WHERE Barn.SiteID = @SiteID
      AND Barn.StatusTypeID <> 2 --Inactive
      AND Contact.StatusTypeID <> 2 --Inactive
      ORDER BY Barn.BarnNbr
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_BARN_SELECT_BY_SITE_ID] TO [db_sp_exec]
    AS [dbo];

