

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 11/18/2010
-- Description:	Populates table in development.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SOW_SELECTED_GILT_MOVEMENT_70_INSERT]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_SOW_SELECTED_GILT_MOVEMENT_70

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_SOW_SELECTED_GILT_MOVEMENT_70
(	SSite
	,DSite
	,DContactname
	,PigGradeCatTypeID
	,PigTypeID
	,SubTypeID
	,GroupPeriod
	,Movement
	,AvgWgt)

	Select  
	   
	SSite.SiteId SSite,
	DSite.SiteID DSite,
	DContact.ContactName as DContactname,
	GradeType.PigGradeCatTypeID,
	TranspRec.PigTypeID,
	TranspRec.SubTypeID,
	Case when dd.FiscalPeriod < 10 
	then Rtrim(CAST(dd.FiscalYear AS char)) + '0' + Rtrim(CAST(dd.FiscalPeriod AS char)) 
	else Rtrim(CAST(dd.FiscalYear AS char)) + Rtrim(CAST(dd.FiscalPeriod AS char)) end as GroupPeriod,
	Sum(GradeQty.Qty) Movement,
	Avg(TranspRec.AvgWgt) AvgWgt
	
	from [$(SolomonApp)].dbo.cftPMGradeQty GradeQty
	
	inner join [$(SolomonApp)].dbo.cftPMTranspRecord TranspRec 
	on TranspRec.RefNbr = GradeQty.RefNbr
	 
	inner join [$(SolomonApp)].dbo.cftPigGradeCatType GradeType
	on GradeType.PigGradeCatTypeID = GradeQty.PigGradeCatTypeID
	 
	left join [$(SolomonApp)].dbo.cftPMTranspRecord re
	on TranspRec.RefNbr = re.OrigRefNbr
	 
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd 
	on dd.DayDate = TranspRec.Movementdate
	 
	left join [$(SolomonApp)].dbo.cftSite SSite
	on TranspRec.SourceContactID = SSite.ContactID 
	
	left join [$(SolomonApp)].dbo.cftSite DSite
	on TranspRec.DestContactID = DSite.ContactID
	
	left join [$(SolomonApp)].dbo.cftContact DContact
	on DSite.ContactID = DContact.ContactID
	
	Where
	TranspRec.DocType <> 're' 
	and re.RefNbr IS NULL 
	and dd.FiscalYear >= '2007'
	
	Group By
	SSite.SiteID,
	DSite.SiteID,
	DContact.Contactname,
	GradeType.PigGradeCatTypeID,
	TranspRec.PigTypeID,
	TranspRec.SubTypeID,
	dd.FiscalYear,
	dd.FiscalPeriod
	
	union
	
	Select 

	S.SiteID as SSite,
	D.SiteID as DSite,
	DC.Contactname,
	Case when S.SiteID = '0511' then '' else '' end as PigGradeCatTypeID,
	TR.PigTypeID,
	TR.SubTypeID,
	Case when wd.FiscalPeriod < 10 
	then Rtrim(CAST(wd.FiscalYear AS char)) + '0' + Rtrim(CAST(wd.FiscalPeriod AS char)) 
	else Rtrim(CAST(wd.FiscalYear AS char)) + Rtrim(CAST(wd.FiscalPeriod AS char)) end as GroupPeriod,
	Case when (Case when sum(tr.recountrequired)>='1' then sum(tr.recountqty) 
	else sum(tr.destfarmqty) end) is null then sum(ps.hctot) else (
	Case when sum(tr.recountrequired)>='1' then sum(tr.recountqty) else sum(tr.destfarmqty) end) end Movement,
	Case when (Case when sum(tr.recountrequired)>='1' then sum(tr.avgwgt*tr.recountqty)/sum(tr.recountqty)
	else sum(tr.avgwgt*tr.destfarmqty)/sum(tr.destfarmqty) end) is null then sum(ps.delvlivewgt)/sum(ps.hctot)
	else (Case when sum(tr.recountrequired)>='1' then sum(tr.avgwgt*tr.recountqty)/sum(tr.recountqty)
	else sum(tr.avgwgt*tr.destfarmqty)/sum(tr.destfarmqty) end) end Avgwgt

	from [$(SolomonApp)].dbo.cftpm pm (nolock)

	left join [$(SolomonApp)].dbo.cfvpigsalerev ps (nolock)
	on pm.pmloadid=ps.pmloadid

	left join [$(SolomonApp)].dbo.cftpigtype pt (nolock)
	on pm.pigtypeid=pt.pigtypeid

	left join [$(SolomonApp)].dbo.cftpmtransprecord tr (nolock)
	on pm.pmid=tr.pmid

	left join [$(SolomonApp)].dbo.cftpmtransprecord rev (nolock)
	on tr.RefNbr=rev.OrigRefNbr

	left join [$(SolomonApp)].dbo.cftcontact sc (nolock)
	on sc.contactid=pm.sourcecontactid

	left join [$(SolomonApp)].dbo.cftsite s (nolock)
	on sc.contactid=s.contactid

	left join [$(SolomonApp)].dbo.cftcontact dc (nolock)
	on dc.contactid=pm.destcontactid

	left join [$(SolomonApp)].dbo.cftsite d (nolock)
	on dc.contactid=d.contactid

	left join [$(SolomonApp)].dbo.cftdaydefinition dd (nolock)
	on pm.movementdate=dd.daydate

	left join [$(SolomonApp)].dbo.cftweekdefinition wd (nolock)
	on dd.weekofdate=wd.weekofdate

	where (tr.DocType is null or tr.DocType<>'RE')
	and rev.RefNbr is null
	and wd.FiscalYear >= '2007'
	and ps.SaleTypeID not in ('CB','TB','CS','CT')

	group by  
	S.SiteID,
	D.SiteID,
	DC.Contactname,
	TR.PigTypeID,
	TR.SubTypeID,
	wd.fiscalperiod,
	wd.fiscalyear
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SELECTED_GILT_MOVEMENT_70_INSERT] TO [db_sp_exec]
    AS [dbo];

