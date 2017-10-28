



CREATE  PROCEDURE [dbo].[cfp_cube_VenInv_eb]
					@LOG char(1)='Y'
AS
BEGIN
/*
===============================================================================
Purpose: Prepare data for loading into a cube

Inputs:
Outputs:    
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

DEBUG:

exec [$(CFFDB)].dbo.cfp_PrintTs  'start 1'
exec 
exec [$(CFFDB)].dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-03-10   smr        adding the account for electricity  '62200'

===============================================================================
*/

-------------------------------------------------------------------------------
-- Standard proc settings
-------------------------------------------------------------------------------
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-------------------------------------------------------------------------------
-- Declare standard variables
-------------------------------------------------------------------------------
DECLARE @RowCount               INT
DECLARE @StepMsg                VARCHAR(255)
DECLARE @DatabaseName           NVARCHAR(128)
DECLARE @ProcessName            VARCHAR(50)
DECLARE @ProcessStatus          INT
DECLARE @StartDate              DATETIME
DECLARE @EndDate                DATETIME
DECLARE @RecordsProcessed       BIGINT
DECLARE @Comments               VARCHAR(2000)
DECLARE @Error                  INT
DECLARE @Criteria               VARCHAR(2000)


-------------------------------------------------------------------------------
-- Set standard variables
-------------------------------------------------------------------------------
SET @DatabaseName       = db_name()
SET @ProcessName        = 'cfp_cube_VenInv_eb'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 
-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
--#####################################################################################################################
-- Create a Cross Reference table for all Inventory side transactions that are in the General Ledger.
--This can be used to look up how the Inventory cube accounts are derived if there are any questions on the data found in the cube.
--Sources are INTran, APTran, POTran and GLTran tables. This table also includes the BatNbr and RefNbr for the data rows.
--The Procedure declares the @StartYear variable, which is used throughout this procedure, to pull only data for the current
--year and the past 5 full fiscal years.
--#####################################################################################################################
--drop table  dbo.cft_ESSBASE_VENINV_INV_XREF	
TRUNCATE table  dbo.cft_ESSBASE_VENINV_INV_XREF
--create table  dbo.cft_ESSBASE_VENINV_INV_XREF
--(Module char(10) not null,
--BatNbr char(10) not null,
--RefNbr char(15) not null,
--Acct char(10) not null,
--InvtId char(30) null,
--InvtIdDesc char(60) null,
--PerPost char (6) not null,
--sub char(24) not null,
--ProjectID char(16) null,
--SiteID char(10) null,
--SiteName char(60) null,
--VendID char(15) null,
--VendName char(60) null,
--qty float not null,
--cost float not null)
--Gets the last 5 full years of data plus the current year.
DECLARE @StartYear char(4) = year(getdate())-5
INSERT INTO  dbo.cft_ESSBASE_VENINV_INV_XREF
(Module,
BatNbr,
RefNbr,
Acct,
InvtId,
InvtIdDesc,
PerPost,
Sub,
ProjectID,
SiteID,
SiteName,
VendId,
VendName,
qty,
cost)

	--Inventory Transactions (from INTran)
	select
	'INTran' Module,
	it.BatNbr,it.RefNbr,
	case when it.trantype  in ('in','cm') then it.cogsacct else it.acct end acct,
	it.invtid InvtId,rtrim(iv.descr) InvtIdDesc,
	it.PerPost, 
	case when it.trantype  in ('in','cm') then it.COGSSub else it.sub end Sub,
	it.ProjectID,
	it.siteid SiteID, st.Name  SiteName,
	null as VendId, null as VendName,
	qty * InvtMult * -1 qty,
	ExtCost * InvtMult * -1 cost 
	from [$(SolomonApp)].dbo.intran it
	left join [$(SolomonApp)].dbo.site st on it.siteid=st.siteid
	left join [$(SolomonApp)].dbo.inventory iv on it.invtid=iv.invtid
	where left(it.PerPost,4) >=  @StartYear
	and it.ExtCost<>0
	and (
			(it.trantype in ('ii','ri') and it.acct in ('46100','46110','46700','46710','60100','62100','62105','66100','71200','71420','73450','62200'))
				or
			(it.trantype  in ('in','cm') and it.COGSAcct in ('46100','46110','46700','46710','60100','62100','62105','66100','71420','71200','73450','62200'))
			)
	UNION ALL
	--Accounts Payable Transactions (from APTran)		
	select
	'APTran' Module,
	ap.BatNbr,ap.RefNbr,
	ap.acct,
	ap.invtid InvtId,rtrim(iv.descr) InvtIdDesc,
	ap.PerPost,
	ap.Sub,
	ap.ProjectID,
	null as SiteID, null as SiteName,
	ap.vendid VendId, rtrim(vd.name) VendName,
	case when drcr='c' then qty*-1 else qty end qty,
	case when drcr='c' then TranAmt*-1 else TranAmt end cost
	from [$(SolomonApp)].dbo.aptran ap
	left join [$(SolomonApp)].dbo.inventory iv on ap.invtid=iv.invtid
	left join [$(SolomonApp)].dbo.vendor vd on ap.vendid=vd.vendid
	where left(ap.PerPost,4) >=  @StartYear
	and ap.acct in ('46100','46110','46700','46710','60100','62100','62105','66100','71200','71420','73450','62200')
	

	UNION ALL
	--Purchase Order Transactions (from POTran)
	select
	'POTran' Module,
	po.BatNbr,po.Refnbr,
	po.acct,
	po.invtid InvtId, rtrim(iv.descr) InvtIdDesc,
	po.PerPost,po.Sub,
	po.ProjectID,po.SiteID,st.Name SiteName,
	po.VendId,vd.name VendName,
	case when po.DrCr='C' then po.Qty * -1 else po.Qty end qty, 
	case when po.DrCr='C' then po.ExtCost * -1 else po.ExtCost end cost
	from [$(SolomonApp)].dbo.potran po
	left join [$(SolomonApp)].dbo.inventory iv on po.invtid=iv.invtid
	left join [$(SolomonApp)].dbo.vendor vd on po.vendid=vd.vendid
	left join [$(SolomonApp)].dbo.site st on po.siteid=st.siteid
	where left(po.PerPost,4) >=  @StartYear
	and po.acct in ('46100','46110','46700','46710','60100','62100','62105','66100','71200','71420','73450','62200')
	UNION ALL
	--All Other Transactions (mostly GL...)
	select
	'GLTran' Module,
	gl.BatNbr,gl.RefNbr,
	gl.acct,
	'' InvtId, '' InvtIdDesc,
	gl.PerPost,gl.sub,
	gl.ProjectID, '' SiteID, '' SiteName,
	LTRIM(gl.Id) VendId,rtrim(vd.name) VendName,
	Case when gl.DrAmt>0 then gl.Qty else gl.Qty * -1 end qty,
	Case when gl.DrAmt>0 then gl.DrAmt else gl.CrAmt * -1 end cost
	from [$(SolomonApp)].dbo.gltran gl
	left join [$(SolomonApp)].dbo.vendor vd on ltrim(gl.id)=vd.vendid
	where left(gl.PerPost,4) >=  @StartYear
	and gl.Module not in ('AP','IN','PO')
	and gl.acct in ('46100','46110','46700','46710','60100','62100','62105','66100','71200','71420','73450','62200')
    AND gl.LedgerID = 'A'
	
SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;

SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - cft_ESSBASE_VENINV_INV_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg	
-------------------------------------------------------------------------------
-- Load temp table
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load table  dbo.cft_ESSBASE_VENINV_INV_DATA'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--drop table  dbo.cft_ESSBASE_VENINV_INV_XREF
--select * from  dbo.cft_ESSBASE_VENINV_INV_XREF where InvtID is null
--#####################################################################################################################
--Now, we group the data into the VenInv cube dimensions, and make the proper transformations of Sub,Project, and Vendor.
--If a project starts with 'VH', these will go into the Location dimension under "Vehicle Rollup".  The Department will always be
--derived from the subaccount in the source data.
--If the InvtId cannot be determined, it will be classified as "A1Misc"+(1st 3 letters of the natural account Ex: A1MiscMed)
--This transformation also takes out many invalid characters out of the InvtId Descriptions.
--Source (or Vendor) will be assigned to data if it is available, otherwise V_NoVend - No Vendor will be used.
--This table IS used in the SQL interface load of the VenInv cube.
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_VENINV_INV_DATA
--create table  dbo.cft_ESSBASE_VENINV_INV_DATA
--(Department char(10) not null,
--Location char(16) not null,
--InvtId char(30) not null,
--InvtIdDesc char(60) null,
--VendID char(15) not null,
--VendName char(60) not null,
--Acct char(10) not null,
--AcctDescr char(30) not null,
--Time char(5) not null,
--Scenario char(7) not null,
--Quantity float not null,
--Cost float not null)

INSERT INTO  dbo.cft_ESSBASE_VENINV_INV_DATA
(Department,
Location,
InvtId,
InvtIdDesc,
VendID,
VendName,
Acct,
AcctDescr,
Time,
Scenario,
Quantity,
Cost)

select
'DEP'+substring(sub,3,2) Department,
case when ProjectID like 'VH%' then ProjectID else 'LOC'+right(rtrim(sub),4) end Location,
Case when InvtId = '' or InvtId like '1MISC%' or InvtId is NULL then rtrim('A1Misc'+left(ac.descr,3))
	else 'A'+rtrim(InvtId) end InvtId , 
Case when InvtId = '' or InvtId like '1MISC%' or InvtId is NULL then rtrim('Misc'+ac.descr)
	when InvtIdDesc is null then ''
	else rtrim(replace(replace(InvtIdDesc,'"',''),'@','at')) end InvtIdDesc, 
Case when VendID = '' or VendID is NULL then 'V_NoVend'
	else 'V_'+VendID end vend,
Case when VendID = '' or VendID is NULL then 'No Vendor'
	when VendName is NULL then ''	
	else VendName end VendName,
'AC'+rtrim(gl.acct) as Acct,rtrim(ac.descr) as AcctDescr,
'Per'+right(RTRIM(PerPost),2) Time,'FY '+left(RTRIM(PerPost),4) Scenario,
round(SUM(qty),2) Quantity,round(SUM(cost),2) Cost
from  dbo.cft_ESSBASE_VENINV_INV_XREF as gl WITH (NOLOCK)
left join [$(SolomonApp)].dbo.account ac on gl.acct=ac.acct
group by
'DEP'+substring(sub,3,2),
case when ProjectID like 'VH%' then ProjectID else 'LOC'+right(rtrim(sub),4) end,
Case when InvtId = '' or InvtId like '1MISC%' or InvtId is NULL then rtrim('A1Misc'+left(ac.descr,3))
	else 'A'+rtrim(InvtId) end, 
Case when InvtId = '' or InvtId like '1MISC%' or InvtId is NULL then rtrim('Misc'+ac.descr)
	when InvtIdDesc is null then ''
	else rtrim(replace(replace(InvtIdDesc,'"',''),'@','at')) end, 
Case when VendID = '' or VendID is NULL then 'V_NoVend'
	else 'V_'+VendID end,
Case when VendID = '' or VendID is NULL then 'No Vendor'
	when VendName is NULL then ''	
	else VendName end,
'AC'+rtrim(gl.acct),rtrim(ac.descr),
'Per'+right(RTRIM(PerPost),2),'FY '+left(RTRIM(PerPost),4)
order by
'DEP'+substring(sub,3,2),
case when ProjectID like 'VH%' then ProjectID else 'LOC'+right(rtrim(sub),4) end,
Case when InvtId = '' or InvtId like '1MISC%' or InvtId is NULL then rtrim('A1Misc'+left(ac.descr,3))
	else 'A'+rtrim(InvtId) end,
Case when VendID = '' or VendID is NULL then 'V_NoVend' else 'V_'+VendID end
--select * from  dbo.cft_ESSBASE_VENINV_INV_DATA

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - cft_ESSBASE_VENINV_INV_DATA, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- Load  dbo.cft_ESSBASE_VENINV_VEN_XREF
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load  dbo.cft_ESSBASE_VENINV_VEN_XREF'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
-- Create a Cross Reference table for all Vendor side transactions that are found in the POTran and APTran tables.
--This can be used to look up how the Vendor cube accounts (Vend_Cost and Vedn_Quantity) are derived if there are any 
--questions on the data found in the cube.
--Sources(Modules) are POTran and APTran tables. This table also includes the BatNbr and RefNbr for the data rows.
--#####################################################################################################################
--drop table  dbo.cft_ESSBASE_VENINV_VEN_XREF
TRUNCATE TABLE  dbo.cft_ESSBASE_VENINV_VEN_XREF	
--create table  dbo.cft_ESSBASE_VENINV_VEN_XREF
--(Module char(10) not null,
--BatNbr char(10) not null,
--RefNbr char(15) not null,
--Acct char(10) not null,
--InvtId char(30) null,
--InvtIdDesc char(60) null,
--PerPost char (6) not null,
--sub char(24) not null,
--ProjectID char(16) null,
--SiteID char(10) null,
--SiteName char(60) null,
--VendID char(15) null,
--VendName char(60) null,
--qty float not null,
--cost float not null)	
Insert into  dbo.cft_ESSBASE_VENINV_VEN_XREF
(Module,
BatNbr,
RefNbr,
Acct,
InvtId,
InvtIdDesc,
PerPost,
Sub,
ProjectID,
SiteID,
SiteName,
VendId,
VendName,
qty,
cost)
--#####################################################################################################################
--This is the data from the POTran table for the Vendor side accounts.
--#####################################################################################################################
select
'POTran' Module,
po.BatNbr,po.Refnbr,
 po.acct account,
po.invtid InvtId, iv.descr InvtIdDescr,
po.perpost,po.sub, po.ProjectID,
rtrim(po.siteid) SiteID, st.name SiteName,po.vendid Vend, vd.name VendDescr,
case when drcr='c' then po.qty*-1 else po.qty end qty, 
case when po.costvouched=0 and pp.ppcost is not null then pp.ppcost
				when drcr='c' then po.costvouched*-1 else po.costvouched end cost 
from [$(SolomonApp)].dbo.POTran po
left join [$(SolomonApp)].dbo.inventory iv on po.invtid=iv.invtid
left join [$(SolomonApp)].dbo.vendor vd on po.vendid=vd.vendid
left join [$(SolomonApp)].dbo.site st on rtrim(po.siteid)=rtrim(st.siteid)
--joins to the Prepayments to bring in those costs.
left join  (
	--This part find the PrePaid payments AC12450 Prepaid - Other
	select acct, batnbr, ponbr, costvouched, extcost*-1 ppcost, invtid, qty, purchasetype, trandate, trandesc, vendid, perpost
	from [$(SolomonApp)].dbo.potran
	where acct='12450'
) pp on po.batnbr=pp.batnbr and po.ponbr=pp.ponbr
where left(po.PerPost,4) >=  @StartYear
and po.acct in ('14000','14100','14500','46100','46110','46700','46710','60100','66100','71200','73450','62100','62105','71420')
and (po.costvouched<>0 or pp.ppcost<>0)
--#####################################################################################################################
--This is the data from the APTran table for the Vendor side accounts.
--#####################################################################################################################
UNION ALL
select
'APTran' Module,
ap.BatNbr,ap.RefNbr,
ap.Acct,
ap.Invtid InvtId, iv.descr InvtIdDescr,
ap.PerPost,ap.sub,
ap.ProjectID,
rtrim(ap.SiteID) SiteID, st.Name  SiteName,
ap.vendid Vend, vd.name VendDescr,
case when drcr='c' then qty*-1 else qty end qty,
case when drcr='c' then curytranamt*-1 else curytranamt end cost
from [$(SolomonApp)].dbo.aptran ap
left join [$(SolomonApp)].dbo.site st on rtrim(ap.siteid)=rtrim(st.siteid)
left join [$(SolomonApp)].dbo.inventory iv on ap.invtid=iv.invtid
left join [$(SolomonApp)].dbo.vendor vd on ap.vendid=vd.vendid
where left(ap.PerPost,4) >=  @StartYear
and ap.acct in ('14500','46100','46110','46700','46710','60100','66100','71200','73450','62100','62105','71420')
and ap.perpost<>''
and ap.curytranamt<>0

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - cft_ESSBASE_VENINV_VEN_XREF, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg



-------------------------------------------------------------------------------
-- load  dbo.cft_ESSBASE_VENINV_VEN_DATA
-------------------------------------------------------------------------------
SET  @StepMsg = ' load  dbo.cft_ESSBASE_VENINV_VEN_DATA'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--Now, we group the data into the VenInv cube dimensions, and make the proper transformations of Sub,Project,Location and Vendor.
--If a project starts with 'VH', these will go into the Location dimension under "Vehicle Rollup".
--If a project starts with 'PS', these will go into the Location dimension under "Actual Locations".
--If the project is not 'VH' or 'PS' and has a vaild SiteID (Warehouse number), these will go into the Location dimension under "Warehouse Rollup".
--If none of the above criteria apply, the Location will be derived from the subaccount (last 4 digits).
--The Department will always be derived from the subaccount in the source data.
--If the InvtId cannot be determined, it will be classified as "A1Misc"+(1st 3 letters of the natural account Ex: A1MiscMed)
--This transformation also takes out many invalid characters out of the InvtId Descriptions.
--Source (or Vendor) will be assigned to data if it is available, otherwise V_NoVend - No Vendor will be used.
--This table IS used in the SQL interface load of the VenInv cube.
--#####################################################################################################################
TRUNCATE table  dbo.cft_ESSBASE_VENINV_VEN_DATA
--create table  dbo.cft_ESSBASE_VENINV_VEN_DATA
--(Department char(10) not null,
--Location char(16) not null,
--WH_Name char(32) null,
--InvtId char(30) not null,
--InvtIdDesc char(60) null,
--VendID char(15) not null,
--VendName char(60) not null,
--Acct char(10) not null,
--AcctDescr char(30) not null,
--Time char(5) not null,
--Scenario char(7) not null,
--Vend_Quantity float not null,
--Vend_Cost float not null)

INSERT INTO  dbo.cft_ESSBASE_VENINV_VEN_DATA
(Department,
Location,
WH_Name,
InvtId,
InvtIdDesc,
VendID,
VendName,
Acct,
AcctDescr,
Time,
Scenario,
Vend_Quantity,
Vend_Cost)


select
'DEP'+substring(sub,3,2) Department,
case
when ProjectID like 'PS%' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID like 'VH%' then ProjectID
when ProjectID not like 'PS%' and ProjectID not like 'VH%' and ProjectID not in ('','0') and SiteID='' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID not like 'PS%' and ProjectID not like 'VH%' and ProjectID not in ('','0') and SiteID<>'' then 'WH'+RTRIM(SiteID)
when ProjectID in ('','0') and SiteID='' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID in ('','0') and SiteID<>'' then 'WH'+RTRIM(SiteID)
else 'LOC'+RIGHT(rtrim(sub),4)
end Location,
case when (ProjectID not like 'PS%' and ProjectID not like 'VH%' and ProjectID not in ('','0') and SiteID<>'')
	OR (ProjectID in ('','0') and SiteID<>'')
 then SiteName else '' end WH_Name,
Case when (Invtid in (null,'') or Invtid like '1MISC%') then rtrim('A1Misc'+left(ac.descr,3))
	else 'A'+rtrim(Invtid) end Invtid,
Case when (Invtid in (null,'') or Invtid like '1MISC%') then rtrim('Misc'+ac.descr)
	when InvtIdDesc is NULL then ''
	else rtrim(replace(replace(InvtIdDesc,'"',''),'@','at')) end InvtIdDescr,	
Case when VendID in (null,'') then 'V_NoVend' else 'V_'+VendID end VendID, 
Case when VendID in (null,'') then 'No Vendor' else VendName end VendName,
'AC'+rtrim(vnd.acct) as Acct,rtrim(ac.descr) as AcctDescr,
'Per'+right(RTRIM(PerPost),2) Time,'FY '+left(RTRIM(PerPost),4) Scenario,
round(SUM(qty),2) Vend_Quantity,round(SUM(cost),2) Vend_Cost
from  dbo.cft_ESSBASE_VENINV_VEN_XREF as vnd WITH (NOLOCK)
left join [$(SolomonApp)].dbo.account ac on vnd.acct=ac.acct
where sub<>'0' --Takes out data that does not have a subaccount yet.
group by
'DEP'+substring(sub,3,2),
case
when ProjectID like 'PS%' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID like 'VH%' then ProjectID
when ProjectID not like 'PS%' and ProjectID not like 'VH%' and ProjectID not in ('','0') and SiteID='' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID not like 'PS%' and ProjectID not like 'VH%' and ProjectID not in ('','0') and SiteID<>'' then 'WH'+RTRIM(SiteID)
when ProjectID in ('','0') and SiteID='' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID in ('','0') and SiteID<>'' then 'WH'+RTRIM(SiteID)
else 'LOC'+RIGHT(rtrim(sub),4)
end,
case when (ProjectID not like 'PS%' and ProjectID not like 'VH%' and ProjectID not in ('','0') and SiteID<>'')
	OR (ProjectID in ('','0') and SiteID<>'')
 then SiteName else '' end,
Case when (Invtid in (null,'') or Invtid like '1MISC%') then rtrim('A1Misc'+left(ac.descr,3))
	else 'A'+rtrim(Invtid) end,
Case when (Invtid in (null,'') or Invtid like '1MISC%') then rtrim('Misc'+ac.descr)
	when InvtIdDesc is NULL then ''
	else rtrim(replace(replace(InvtIdDesc,'"',''),'@','at')) end,	
Case when VendID in (null,'') then 'V_NoVend' else 'V_'+VendID end, 
Case when VendID in (null,'') then 'No Vendor' else VendName end,
'AC'+rtrim(vnd.acct),rtrim(ac.descr),
'Per'+right(RTRIM(PerPost),2),'FY '+left(RTRIM(PerPost),4)
order by
'DEP'+substring(sub,3,2),
case
when ProjectID like 'PS%' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID like 'VH%' then ProjectID
when ProjectID not like 'PS%' and ProjectID not like 'VH%' and ProjectID not in ('','0') and SiteID='' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID not like 'PS%' and ProjectID not like 'VH%' and ProjectID not in ('','0') and SiteID<>'' then 'WH'+RTRIM(SiteID)
when ProjectID in ('','0') and SiteID='' then 'LOC'+RIGHT(rtrim(sub),4)
when ProjectID in ('','0') and SiteID<>'' then 'WH'+RTRIM(SiteID)
else 'LOC'+RIGHT(rtrim(sub),4)
end,
Case when (Invtid in (null,'') or Invtid like '1MISC%') then rtrim('A1Misc'+left(ac.descr,3))
	else 'A'+rtrim(Invtid) end,
Case when VendID in (null,'') then 'V_NoVend' else 'V_'+VendID end
--select * from  dbo.cft_ESSBASE_VENINV_VEN_XREF

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - cft_ESSBASE_VENINV_VEN_DATA, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

-------------------------------------------------------------------------------
-- Load  dbo.cft_ESSBASE_VENINV_WAREHOUSES
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load  dbo.cft_ESSBASE_VENINV_WAREHOUSES'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--*********WAREHOUSES***************************************************************************************
--#####################################################################################################################
--This will build the Warehouses table so that we can add new warehouses to the outline before we load the data.
--#####################################################################################################################
truncate table  dbo.cft_ESSBASE_VENINV_WAREHOUSES 
--drop table  dbo.cft_ESSBASE_VENINV_WAREHOUSES
--create table  dbo.cft_ESSBASE_VENINV_WAREHOUSES
--(WarehouseRollup char(24),
--Warehouse char(16) not null,
--WH_Name char(32) null)
insert into  dbo.cft_ESSBASE_VENINV_WAREHOUSES
(WarehouseRollup,
Warehouse,
WH_Name)

select distinct 'Warehouse Rollup' as 'WarehouseRollup',Location as Warehouse,WH_Name from  dbo.cft_ESSBASE_VENINV_VEN_DATA
where Location like 'WH%'
order by Location

--select * from  dbo.cft_ESSBASE_VENINV_WAREHOUSES

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_VENINV_WAREHOUSES, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

	
-------------------------------------------------------------------------------
-- Load  dbo.cft_ESSBASE_VENINV_VEHICLES
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load  dbo.cft_ESSBASE_VENINV_VEHICLES'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--***********VEHICLES***************************************************************************************
--#####################################################################################################################
--This will build the Vehicles table so that we can add new vehicles to the outline before we load the data.
--#####################################################################################################################
truncate table  dbo.cft_ESSBASE_VENINV_VEHICLES 
--drop table  dbo.cft_ESSBASE_VENINV_VEHICLES
--create table  dbo.cft_ESSBASE_VENINV_VEHICLES
--(VehicleRollup char(24) not null,
--Location char(16) not null)
insert into  dbo.cft_ESSBASE_VENINV_VEHICLES
(VehicleRollup,
Location)

select distinct 'Vehicle Rollup' as VehicleRollup,v.Location from (
	select Location from  dbo.cft_ESSBASE_VENINV_INV_DATA
	where Location like 'VH%'
	union all
	select Location from  dbo.cft_ESSBASE_VENINV_VEN_DATA
	where Location like 'VH%'
	) v
order by v.Location
--select * from  dbo.cft_ESSBASE_VENINV_VEHICLES

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_VENINV_VEHICLES, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- Load  dbo.cft_ESSBASE_VENINV_PRODUCTS
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load  dbo.cft_ESSBASE_VENINV_PRODUCTS'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--***********PRODUCTS***************************************************************************************
--#####################################################################################################################
--This will build the Products table so that we can add new Products to the outline before we load the data.
--#####################################################################################################################
--drop table  dbo.cft_ESSBASE_VENINV_PRODUCTS
truncate table  dbo.cft_ESSBASE_VENINV_PRODUCTS

--create table  dbo.cft_ESSBASE_VENINV_PRODUCTS
--(InvtId char(30) not null,
--InvtIdDesc char(60) null)
insert into  dbo.cft_ESSBASE_VENINV_PRODUCTS
(InvtId,
InvtIdDesc)

select distinct i.InvtId,i.InvtIdDesc from (
	select InvtId,InvtIdDesc from  dbo.cft_ESSBASE_VENINV_INV_DATA
	union all
	select InvtId,InvtIdDesc from  dbo.cft_ESSBASE_VENINV_VEN_DATA
	) i
order by i.InvtId
--select * from  dbo.cft_ESSBASE_VENINV_PRODUCTS
--order by InvtIdDesc


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_VENINV_PRODUCTS, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


-------------------------------------------------------------------------------
-- Load  dbo.cft_ESSBASE_VENINV_VENDORS
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load  dbo.cft_ESSBASE_VENINV_VENDORS'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

--#####################################################################################################################
--***********VENDORS****************************************************************************************
--#####################################################################################################################
--This will build the Vendors table so that we can add new Vendors to the outline before we load the data.
--#####################################################################################################################
--drop table  dbo.cft_ESSBASE_VENINV_VENDORS
truncate table  dbo.cft_ESSBASE_VENINV_VENDORS

--create table  dbo.cft_ESSBASE_VENINV_VENDORS
--(VendID char(15) not null,
--VendName char(60) not null)
insert into  dbo.cft_ESSBASE_VENINV_VENDORS
(VendID,
VendName)

select distinct v.VendID,v.VendName from (
	select VendID,VendName from  dbo.cft_ESSBASE_VENINV_INV_DATA
	union all
	select VendID,VendName from  dbo.cft_ESSBASE_VENINV_VEN_DATA
	) v
order by v.VendID
--select * from  dbo.cft_ESSBASE_VENINV_VENDORS

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common


SET @RecordsProcessed = @RowCount
SET @Comments = 'Loaded cft_ESSBASE_VENINV_VENDORS, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END               
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

----------- end of process
               
END
-------------------------------------------------------------------------------
-- If the procedure gets to here, it is a successful run
-- NOTE: Make sure to capture @RecordsProcessed from your main query
-------------------------------------------------------------------------------
SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'

-------------------------------------------------------------------------------
-- Log the end of the procedure
-------------------------------------------------------------------------------


TheEnd:
SET @EndDate = GETDATE()
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
EXEC [$(CFFDB)].dbo.cfp_PrintTs 'End'
RAISERROR (@Comments, @ProcessStatus, 1)

RETURN @ProcessStatus

-------------------------------------------------------------------------------
-- Error handling
-------------------------------------------------------------------------------
ERR_Common:
    SET @Comments         = 'Error in step: ' + @StepMsg

    SET @ProcessStatus    = 16
    SET @RecordsProcessed = 0
    GOTO TheEnd					

	  

















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_VenInv_eb] TO [SE\ssis_datareader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_VenInv_eb] TO [SSRS_operator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_VenInv_eb] TO [SE\ssis_datawriter]
    AS [dbo];

