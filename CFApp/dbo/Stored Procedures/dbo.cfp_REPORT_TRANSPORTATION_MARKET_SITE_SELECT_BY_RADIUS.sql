

-- ==================================================================
-- Author:		Doran Dahle
-- Create date: 01/09/2012
-- Description:	CENTRAL DATA - Returns all addresses inside a radius
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_MARKET_SITE_SELECT_BY_RADIUS]
(
	@AddressID	int,  -- Address ID of the center popint of the Radius
	@radius		int,  -- Size of the Radius in Meters	
	@MovementDate as smalldatetime   -- Movement date
)
AS
BEGIN
	SET NOCOUNT ON;
	
	CREATE TABLE #AllSites (AddressID int, GeoRef geography, Miles float
		, bearing float
		, Address1 varchar(30)
		, City varchar(30)
		, State  varchar(3)
		, Zip varchar(10)
		, County varchar(30)
		, ContactID int 
		, ContactName varchar(50)
		, ContactDescription varchar(50))
		insert into #AllSites (AddressID 
		, GeoRef 
		, Miles 
		, bearing 
		, Address1 
		, City 
		, State  
		, Zip 
		, County 
		, ContactID 
		, ContactName 
		, ContactDescription )
		EXEC cfp_CD_MAP_ADDRESS_SELECT_BY_RADIUS @AddressID,@radius, 18
		Select sites.AddressID 
		, GeoRef 
		, Miles 
		, bearing 
		, Address1 
		, City 
		, State  
		, Zip 
		, County 
		, sites.ContactID 
		, ContactName 
		, ContactDescription 
		from #AllSites sites
		INNER JOIN ( Select distinct SourceContactID,MovementDate From [$(SolomonApp)].dbo.cftPM (NOLOCK) ) pm ON sites.ContactID = pm.SourceContactID
		LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition w (NOLOCK) on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
		LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus ws (NOLOCK) on w.WeekOfDate=ws.WeekOfDate and ws.PMTypeID='02' 
		and ws.PigSystemID='01' and ws.CpnyID='CFF'
		LEFT JOIN [$(SolomonApp)].dbo.cftPMStatus st (NOLOCK) on ws.PMStatusID=st.PMStatusID and st.PMTypeID='02'
		where pm.MovementDate = @MovementDate
		order by Miles,ContactName
				
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_MARKET_SITE_SELECT_BY_RADIUS] TO [db_sp_exec]
    AS [dbo];

