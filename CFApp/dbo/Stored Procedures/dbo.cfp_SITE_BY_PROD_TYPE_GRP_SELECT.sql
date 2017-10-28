--*************************************************************
--	Purpose: Select sites by prod type of GRP
--		
--	Author: Brian Cesafsky
--	Date: 12/06/2007	
--*************************************************************

CREATE PROCEDURE [dbo].[cfp_SITE_BY_PROD_TYPE_GRP_SELECT]
	(@MovementDate as smalldatetime,
	 @NumberOfDaysOutToLook as smallint,
	 @TransSubTypeID as varchar(2),
	 @SourceorDest as varchar(6))
AS
DECLARE @ProdPhase varchar(3), @NbrDays smallint
IF @SourceorDest='Source'
BEGIN
SET @ProdPhase=(Select Top 1 SrcProdPhaseID from [$(SolomonApp)].dbo.cftPigTranSys (nolock) where TranTypeID=@TransSubTypeID) 
SET @NbrDays=(Select EstDays from [$(SolomonApp)].dbo.cftPigProdPhase (nolock) where PigProdPhaseID=@ProdPhase)
IF @ProdPhase in ('ISO','TEF','NSG','FIN','WTF')
	BEGIN
	Select DISTINCT
        ct.ContactID
        ,ct.ContactName as SiteName
	from	
		[$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK) 
		LEFT JOIN [$(SolomonApp)].dbo.cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
		LEFT JOIN [$(SolomonApp)].dbo.cftContact ct on pg.SiteContactID=ct.ContactID
		JOIN [$(SolomonApp)].dbo.cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
			and s.status_transport='A' 
			and pg.PigProdPhaseID=@ProdPhase
 			and pg.EstStartDate<@MovementDate
	order by 
		ct.ContactName
	END
ELSE
	BEGIN
	Select DISTINCT
        ct.ContactID
        ,ct.ContactName as SiteName
	from 
		[$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK) 
		LEFT JOIN [$(SolomonApp)].dbo.cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
		LEFT JOIN [$(SolomonApp)].dbo.cftContact ct on pg.SiteContactID=ct.ContactID
		JOIN [$(SolomonApp)].dbo.cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
			and EstCloseDate between DateAdd(d,-1*@NumberOfDaysOutToLook,@MovementDate) and DateAdd(d,@NumberOfDaysOutToLook,@MovementDate)
			and pg.EstStartDate<@MovementDate
			and s.status_transport='A' 
			and pg.PigProdPhaseID=@ProdPhase
	order by 
		ct.ContactName
	END
END
ELSE
BEGIN
SET @ProdPhase=(Select Top 1 DestProdPhaseID from [$(SolomonApp)].dbo.cftPigTranSys (nolock) where TranTypeID=@TransSubTypeID) 
SET @NbrDays=(Select EstDays from [$(SolomonApp)].dbo.cftPigProdPhase (nolock) where PigProdPhaseID=@ProdPhase)
IF @ProdPhase in ('ISO','TEF','NSG','FIN','WTF')
	BEGIN
	Select DISTINCT
        ct.ContactID
        ,ct.ContactName as SiteName
	from 
		[$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK) 
		LEFT JOIN [$(SolomonApp)].dbo.cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
		LEFT JOIN [$(SolomonApp)].dbo.cftContact ct on pg.SiteContactID=ct.ContactID
		JOIN [$(SolomonApp)].dbo.cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
		and s.status_transport='A' 
		and pg.PigProdPhaseID=@ProdPhase
		and pg.EstCloseDate>@MovementDate
	order by 
		ct.ContactName
	END
ELSE
	BEGIN
	Select DISTINCT
        ct.ContactID
        ,ct.ContactName as SiteName
	from
		[$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK) 
		LEFT JOIN [$(SolomonApp)].dbo.cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
		LEFT JOIN [$(SolomonApp)].dbo.cftContact ct on pg.SiteContactID=ct.ContactID
		JOIN [$(SolomonApp)].dbo.cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
		and EstStartDate between DateAdd(d,-1*@NumberOfDaysOutToLook,@MovementDate) and DateAdd(d,@NumberOfDaysOutToLook,@MovementDate)
		and s.status_transport='A' 
		and pg.PigProdPhaseID=@ProdPhase
	order by 
		ct.ContactName
	END
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_BY_PROD_TYPE_GRP_SELECT] TO [db_sp_exec]
    AS [dbo];

