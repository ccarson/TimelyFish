--*************************************************************
--	Purpose:Select available barns by site and prodType GRP
--		
--	Author: Brian Cesafsky
--	Date: 12/06/2007	
--*************************************************************

CREATE PROCEDURE [dbo].[cfp_SITE_BARN_BY_PROD_TYPE_GRP_SELECT]
(
	@MovementDate as smalldatetime,
	@NumberOfDaysOutToLook as smallint,
	@TransSubTypeID as varchar(2),
	@SourceorDest as varchar(6),
	@ContactID as varchar(6)
)
AS
DECLARE @ProdPhase varchar(3), @NbrDays smallint
IF @SourceorDest='Source'
BEGIN
SET @ProdPhase=(Select Top 1 SrcProdPhaseID from [$(SolomonApp)].dbo.cftPigTranSys (nolock) where TranTypeID=@TransSubTypeID) 
SET @NbrDays=(Select EstDays from [$(SolomonApp)].dbo.cftPigProdPhase (nolock) where PigProdPhaseID=@ProdPhase)
IF @ProdPhase in ('ISO','TEF','NSG','FIN','WTF')
	BEGIN
	Select 
		PG.PigGroupID
		,pg.Description
		,PG.BarnNbr BarnNumber
		,pr.RoomNbr RoomNumber
		,s.Status_Transport StatusTransport
		,pg.eststartdate EstimatedStartDate
		,pg.estclosedate EstimatedCloseDate
		,PG.SiteContactID
		,PG.ProjectID
		,PG.TaskID
		,ct.ContactName as SiteName
	from	
		[$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK) 
		LEFT JOIN [$(SolomonApp)].dbo.cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
		LEFT JOIN [$(SolomonApp)].dbo.cftContact ct on pg.SiteContactID=ct.ContactID
		JOIN [$(SolomonApp)].dbo.cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
			and s.status_transport='A' 
			and pg.PigProdPhaseID=@ProdPhase
 			and pg.EstStartDate<@MovementDate
	where ContactID = @ContactID
	order by 
		pg.BarnNbr, pr.RoomNbr
	END
ELSE
	BEGIN
	Select 
		PG.PigGroupID
		,pg.Description
		,PG.BarnNbr BarnNumber
		,pr.RoomNbr RoomNumber
		,s.Status_Transport StatusTransport
		,pg.eststartdate EstimatedStartDate
		,pg.estclosedate EstimatedCloseDate
		,PG.SiteContactID
		,PG.ProjectID
		,PG.TaskID
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
	where ContactID = @ContactID
	order by 
		pg.BarnNbr, pr.RoomNbr
	END
END
ELSE
BEGIN
SET @ProdPhase=(Select Top 1 DestProdPhaseID from [$(SolomonApp)].dbo.cftPigTranSys (nolock) where TranTypeID=@TransSubTypeID) 
SET @NbrDays=(Select EstDays from [$(SolomonApp)].dbo.cftPigProdPhase (nolock) where PigProdPhaseID=@ProdPhase)
IF @ProdPhase in ('ISO','TEF','NSG','FIN','WTF')
	BEGIN
	Select 
		PG.PigGroupID
		,pg.Description
		,PG.BarnNbr BarnNumber
		,pr.RoomNbr RoomNumber
		,s.Status_Transport StatusTransport
		,pg.eststartdate EstimatedStartDate
		,pg.estclosedate EstimatedCloseDate
		,PG.SiteContactID
		,PG.ProjectID
		,PG.TaskID
		,ct.ContactName as SiteName
	from 
		[$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK) 
		LEFT JOIN [$(SolomonApp)].dbo.cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
		LEFT JOIN [$(SolomonApp)].dbo.cftContact ct on pg.SiteContactID=ct.ContactID
		JOIN [$(SolomonApp)].dbo.cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
		and s.status_transport='A' 
		and pg.PigProdPhaseID=@ProdPhase
		and pg.EstCloseDate>@MovementDate
	where ContactID = @ContactID
	order by 
		pg.BarnNbr, pr.RoomNbr
	END
ELSE
	BEGIN
	Select 
		PG.PigGroupID
		,pg.Description
		,PG.BarnNbr BarnNumber
		,pr.RoomNbr RoomNumber
		,s.Status_Transport StatusTransport
		,pg.eststartdate EstimatedStartDate
		,pg.estclosedate EstimatedCloseDate
		,PG.SiteContactID
		,PG.ProjectID
		,PG.TaskID
		,ct.ContactName as SiteName
	from
		[$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK) 
		LEFT JOIN [$(SolomonApp)].dbo.cftPigGroupRoom pr WITH (NOLOCK) on pg.PigGroupID=pr.PigGroupID
		LEFT JOIN [$(SolomonApp)].dbo.cftContact ct on pg.SiteContactID=ct.ContactID
		JOIN [$(SolomonApp)].dbo.cftPGStatus s WITH (NOLOCK) on pg.PGStatusID=s.PGStatusID
		and EstStartDate between DateAdd(d,-1*@NumberOfDaysOutToLook,@MovementDate) and DateAdd(d,@NumberOfDaysOutToLook,@MovementDate)
		and s.status_transport='A' 
		and pg.PigProdPhaseID=@ProdPhase
	where ContactID = @ContactID
	order by 
		pg.BarnNbr, pr.RoomNbr
	END
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_BARN_BY_PROD_TYPE_GRP_SELECT] TO [db_sp_exec]
    AS [dbo];

