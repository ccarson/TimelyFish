



-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 5/16/2012
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SOW_REMOVAL_INSERT_remove]
AS
BEGIN

--clear table for new data
TRUNCATE TABLE  dbo.cft_SOW_REMOVAL

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_SOW_REMOVAL
(	PICYear_Week,
	FiscalPeriod,
	FiscalYear,
	ContactName,
	ContactID,
	SiteID,
	RemovalType,
	PrimaryReason,
	GeneticLine,
	Parity,
	HeadCount)

	Select
	d.PICYear_Week,
	d.FiscalPeriod,
	d.FiscalYear,
	c.ContactName,
	c.ContactID,
	si.SiteID,
	r.RemovalType,
	r.PrimaryReason,
	convert(char,s.Genetics) as GeneticLine,
	r.SowParity as 'Parity',
	Count(r.SowID) as Headcount

	from earth.sowdata.dbo.SowRemoveEvent r
	LEFT JOIN earth.sowdata.dbo.Sow s on r.SowID=s.SowID and r.FarmID=s.FarmID
	LEFT JOIN earth.sowdata.dbo.FarmSetup f on r.FarmID = f.FarmID
	LEFT JOIN [$(SolomonApp)].dbo.cftContact c on f.ContactID = c.ContactID 
	LEFT JOIN [$(SolomonApp)].dbo.cftSite si on c.ContactID = si.ContactID 
	Join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo d on r.EventDate=d.DayDate
	where r.RemovalType<>'TRANSFER' 
	and r.EventDate between '1/1/2008' and getDate()
	and f.ContactID is not null

	Group by
	d.PICYear_Week,
	d.FiscalPeriod,
	d.FiscalYear,
	c.ContactName,
	c.ContactID,
	si.SiteID,
	r.RemovalType,
	r.PrimaryReason,
	convert(char,s.Genetics),
	r.SowParity
	
	Order by
	d.PICYear_Week,
	c.ContactName
	
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_REMOVAL_INSERT_remove] TO [db_sp_exec]
    AS [dbo];

