

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 1/18/2011
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_MARKET_DRIVER_LOAD_INFORMATION_INSERT]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_MARKET_DRIVER_LOAD_INFORMATION

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_MARKET_DRIVER_LOAD_INFORMATION
(	PMLoadID
	,BatNbr
	,RefNbr
	,SaleDate
	,SiteContactID
	,Site
	,PkrContactID
	,Packer
	,TaskID
	,SaleTypeID
	,PigTypeID
	,MarketSaleTypeID
	,MovementDate
	,PICYear_Week
	,TruckerContactID
	,Trucker
	,EstimatedQty
	,DetailTypeID
	,Qty
	,WgtLive)
	
	Select
	 
	PM.PMLoadID,  
	PSR.BatNbr,
	PSR.RefNbr,
	PSR.SaleDate,
	PSR.SiteContactID,
	SC.ContactName as Site,
	PSR.PkrContactID,
	PC.ContactName as Packer,
	PSR.TaskID,
	PSR.SaleTypeID,
	PM.PigTypeID,
	PM.MarketSaleTypeID,
	PM.MovementDate,
	WeekInfo.PICYear_Week,
	PM.TruckerContactID,
	TC.ContactName as Trucker,
	PM.EstimatedQty,
	PS.DetailTypeID,
	PS.Qty,
	PS.WgtLive
	
	From [$(SolomonApp)].dbo.cftPM PM (nolock) 
	
	left join [$(SolomonApp)].dbo.cfvPIGSALEREV PSR (nolock)
	on PM.PMLoadID = PSR.PMLoadID
	
	left join [$(SolomonApp)].dbo.cftPSDetail PS (nolock)
	on PSR.BatNbr = PS.BatNbr
	and PSR.RefNbr = PS.RefNbr
	
	left join [$(SolomonApp)].dbo.cftContact SC (nolock)
	on PM.SourceContactID = SC.ContactID
	
	left join [$(SolomonApp)].dbo.cftContact PC (nolock)
	on PSR.PkrContactID = PC.ContactID
	
	left join [$(SolomonApp)].dbo.cftContact TC (nolock)
	on PM.TruckerContactID = TC.ContactID
	
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WeekInfo (nolock)
	on PSR.SaleDate = WeekInfo.DayDate
	
	Where PSR.RefNbr <> ''
	and PSR.SaleTypeID not in ('CS','MC','CB')
	and PM.PigTypeID = '04'
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_DRIVER_LOAD_INFORMATION_INSERT] TO [db_sp_exec]
    AS [dbo];

