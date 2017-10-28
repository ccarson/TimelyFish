 CREATE Proc  [dbo].[cfp_pqaindividual] 
 @expirdate smalldatetime
 as

--declare @expirdate smalldatetime
--set @expirdate = '12/31/2013'

--drop table #stage2
--drop table #stage1

create table #stage2
(sitename varchar(50) null
, siteid varchar(6) null	-- 201411 added siteid
, facilitytypedescription varchar(50) null
, name varchar(50) null
, role varchar(10) null
, issuedate datetime null
, expirationdate datetime null
, svcmgr varchar(200) null
, prod_farmmgr varchar(200) null
, sitemgr varchar(200) null
--, pod varchar(200) null
)


Select
a.SiteName,
a.FacilityTypeDescription,
a.Name,
a.Role,
a.IssueDate,
a.ExpirationDate
into #stage1

from (

Select
'CFF' as 'SiteName',
'ProdMgmt' as 'FacilityTypeDescription',
c.ContactName as 'Name',
'ProdMgmt' as 'Role',
Permit.IssueDate,
Permit.ExpirationDate
      from (
            SELECT DISTINCT
                  SiteSvcMgrAssignment.SvcMgrContactID as 'ContactID'
            ,     SiteSvcMgrContact.ContactName SiteServiceManager

            FROM  dbo.Site Site (NOLOCK)
            LEFT JOIN  dbo.Contact SiteContact (NOLOCK) ON SiteContact.ContactID = Site.ContactID
            LEFT JOIN  dbo.FacilityType FacilityType (NOLOCK) ON FacilityType.FacilityTypeID = Site.FacilityTypeID
            LEFT JOIN  dbo.Contact SiteMgrContact (NOLOCK) ON SiteMgrContact.ContactID = Site.SiteMgrContactID
            LEFT JOIN (SELECT SiteContactID, MAX(EffectiveDate) EffectiveDate 
                  FROM  dbo.SiteSvcMgrAssignment (NOLOCK) GROUP BY SiteContactID) CurrSiteSvcMgr
                  ON CurrSiteSvcMgr.SiteContactID = Site.ContactID
            LEFT JOIN  dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment (NOLOCK) ON SiteSvcMgrAssignment.SiteContactID = CurrSiteSvcMgr.SiteContactID AND SiteSvcMgrAssignment.EffectiveDate = CurrSiteSvcMgr.EffectiveDate
            LEFT JOIN  dbo.Contact SiteSvcMgrContact (NOLOCK) ON SiteSvcMgrContact.ContactID = SiteSvcMgrAssignment.SvcMgrContactID
            LEFT JOIN (SELECT SiteContactID, MAX(EffectiveDate) EffectiveDate 
                  FROM  dbo.MarketSvcMgrAssignment (NOLOCK) GROUP BY SiteContactID) CurrSiteMktSvcMgr
                  ON CurrSiteMktSvcMgr.SiteContactID = Site.ContactID
            LEFT JOIN  dbo.MarketSvcMgrAssignment MarketSvcMgrAssignment (NOLOCK)
                  ON MarketSvcMgrAssignment.SiteContactID = CurrSiteMktSvcMgr.SiteContactID
                  AND MarketSvcMgrAssignment.EffectiveDate = CurrSiteMktSvcMgr.EffectiveDate
            LEFT JOIN  dbo.Contact SiteMktSvcMgrContact (NOLOCK) ON SiteMktSvcMgrContact.ContactID = MarketSvcMgrAssignment.MarketSvcMgrContactID
            LEFT JOIN  dbo.SrSvcMgrAssignment SrSvcMgrAssignment (NOLOCK) ON SrSvcMgrAssignment.SvcMgrContactID = SiteSvcMgrAssignment.SvcMgrContactID
            LEFT JOIN  dbo.Contact SiteSrSvcMgrContact (NOLOCK) ON SiteSrSvcMgrContact.ContactID = SrSvcMgrAssignment.SrSvcMgrContactID
                  where sitecontact.StatusTypeID = 1) SM
            LEFT JOIN [$(SolomonApp)].dbo.cftcontact c on SM.ContactID = c.ContactID
            LEFT JOIN (select distinct P.SiteContactID as SiteMgrID, Max(P.ExpirationDate) ExpDate from  dbo.Permit P
            LEFT JOIN [$(SolomonApp)].dbo.cftContact C on P.SiteContactID = C.ContactID
                  where P.PermitTypeID in (12,27,31)
                        and C.ContactTypeID = 03
                        and P.ExpirationDate is not null
                  group by
                        P.SiteContactID) PermitExp on SM.ContactID = PermitExp.SiteMgrID
            left join  dbo.Permit Permit on PermitExp.SiteMgrID = Permit.SiteContactID
                  and PermitExp.ExpDate = Permit.ExpirationDate
            Where c.StatusTypeID = 1
            --pull role of ProdMgmt
      
union
Select
'CFF' as 'SiteName',
'ProdMgmt' as 'FacilityTypeDescription',
c.ContactName as 'Name',
'ProdMgmt' as 'Role',
Permit.IssueDate,
Permit.ExpirationDate
      from (
            SELECT DISTINCT
                  SiteSrSvcMgrContact.ContactID
            ,     SiteSrSvcMgrContact.ContactName SiteSrServiceManager

            FROM  dbo.Site Site (NOLOCK)
            LEFT JOIN  dbo.Contact SiteContact (NOLOCK) ON SiteContact.ContactID = Site.ContactID
            LEFT JOIN  dbo.FacilityType FacilityType (NOLOCK) ON FacilityType.FacilityTypeID = Site.FacilityTypeID
            LEFT JOIN  dbo.Contact SiteMgrContact (NOLOCK) ON SiteMgrContact.ContactID = Site.SiteMgrContactID
            LEFT JOIN (SELECT SiteContactID, MAX(EffectiveDate) EffectiveDate 
                  FROM  dbo.SiteSvcMgrAssignment (NOLOCK) GROUP BY SiteContactID) CurrSiteSvcMgr
                  ON CurrSiteSvcMgr.SiteContactID = Site.ContactID
            LEFT JOIN  dbo.SiteSvcMgrAssignment SiteSvcMgrAssignment (NOLOCK)ON SiteSvcMgrAssignment.SiteContactID = CurrSiteSvcMgr.SiteContactID
                  AND SiteSvcMgrAssignment.EffectiveDate = CurrSiteSvcMgr.EffectiveDate
            LEFT JOIN  dbo.Contact SiteSvcMgrContact (NOLOCK) ON SiteSvcMgrContact.ContactID = SiteSvcMgrAssignment.SvcMgrContactID
            LEFT JOIN (SELECT SiteContactID, MAX(EffectiveDate) EffectiveDate 
                  FROM  dbo.MarketSvcMgrAssignment (NOLOCK) GROUP BY SiteContactID) CurrSiteMktSvcMgr
                  ON CurrSiteMktSvcMgr.SiteContactID = Site.ContactID
            LEFT JOIN  dbo.MarketSvcMgrAssignment MarketSvcMgrAssignment (NOLOCK) ON MarketSvcMgrAssignment.SiteContactID = CurrSiteMktSvcMgr.SiteContactID
                  AND MarketSvcMgrAssignment.EffectiveDate = CurrSiteMktSvcMgr.EffectiveDate
            LEFT JOIN  dbo.Contact SiteMktSvcMgrContact (NOLOCK) ON SiteMktSvcMgrContact.ContactID = MarketSvcMgrAssignment.MarketSvcMgrContactID
            LEFT JOIN    dbo.SrSvcMgrAssignment SrSvcMgrAssignment (NOLOCK) ON SrSvcMgrAssignment.SvcMgrContactID = SiteSvcMgrAssignment.SvcMgrContactID
            LEFT JOIN    dbo.Contact SiteSrSvcMgrContact (NOLOCK) ON SiteSrSvcMgrContact.ContactID = SrSvcMgrAssignment.SrSvcMgrContactID
                  where sitecontact.StatusTypeID = 1) 
      SM

      left join [$(SolomonApp)].dbo.cftcontact c on SM.ContactID = c.ContactID
      left join (select distinct P.SiteContactID as SiteMgrID, Max(P.ExpirationDate) ExpDate from  dbo.Permit P
      left join [$(SolomonApp)].dbo.cftContact C on P.SiteContactID = C.ContactID
            where P.PermitTypeID in (12,27,31)
                  and C.ContactTypeID = 03
                  and P.ExpirationDate is not null
            group by
                  P.SiteContactID) PermitExp
                  on SM.ContactID = PermitExp.SiteMgrID
      left join  dbo.Permit Permit on PermitExp.SiteMgrID = Permit.SiteContactID and PermitExp.ExpDate = Permit.ExpirationDate
            Where c.StatusTypeID = 1
            --pulling role = ProdMgmt but adding sr.svc managers(query pulls 4 results)

union
Select 
cftContact.ContactName as 'SiteName',
cftFT.Description as 'FacilityTypeDescription',
cftSiteMgr.ContactName as 'Name',
'SiteMgr' as 'Role',
Permit.IssueDate,
Permit.ExpirationDate
      from [$(SolomonApp)].dbo.cftSite cftSite

      left join [$(SolomonApp)].dbo.cftfacilitytype cftFT on cftSite.FacilityTypeID = cftFT.FacilityTypeID
      left join [$(SolomonApp)].dbo.cftContact cftContact on cftSite.ContactID = cftContact.ContactID
      join [$(SolomonApp)].dbo.cftContact cftSiteMgr on cftSite.SiteMgrContactID = cftSiteMgr.ContactID   -- was a left join... changed to exclude rows where there is no sitemgrcontactid value
      left join (select distinct P.SiteContactID as SiteMgrID, Max(P.ExpirationDate) ExpDate from  dbo.Permit P
      left join [$(SolomonApp)].dbo.cftContact C on P.SiteContactID = C.ContactID
            where P.PermitTypeID in (12,27,31)
                  and C.ContactTypeID = 03
                  and P.ExpirationDate is not null
            group by
                  P.SiteContactID) PermitExp
            on cftSiteMgr.ContactID = PermitExp.SiteMgrID
      left join  dbo.Permit Permit on PermitExp.SiteMgrID = Permit.SiteContactID
            and PermitExp.ExpDate = Permit.ExpirationDate
            where cftContact.StatusTypeID = 1
                  and cftContact.ContactTypeID = 04
                  and ((cftSite.FacilityTypeID in (001,003) and cftSiteMgr.ContactName is not null) or cftSite.FacilityTypeID in (002,004,005,006,007,010,011))
                  and cftSite.OwnershipTypeID not in (005,007,008)
                                                and cftContact.ContactID not in (4299,4000,3341,316,2687,4001,4002,2287)
                  --FacilityTypes: 1=Sow,2=Nursery,3=Gilt Iso,4=Gilt Dev,5=WF,6=Finish,7=TE,8=Non-Production,10=Breeding Proj,11=Boar Stud
                  --SiteOwnershipType:  1=Company, 2=Contract,3=Company Managed,5=Non-Cff,7=Contract/Sublet,8=Company/Sublet,9=Managed/TNL,10=Managed/DCC
                                                --excluded sites C38Nursery,ONNursery,LDCNur,C003,C069,LDCFarrowing,ONFarrowing,ONGGU
                  --pulling role = SiteMgr

union
Select Distinct
rc.ContactName as 'SiteName',
cftFT.Description as 'FacilityTypeDescription',
rc.RelatedName as 'Name',
rc.RelatedContactRelationshipDescription as 'Role',
Permit.IssueDate,
Permit.ExpirationDate
      from (select Distinct
            rc.ContactID,
            cc.ContactName,
            rc.RelatedID,
            ri.ContactName as 'RelatedName',
            rcrt.RelatedContactRelationshipDescription
      from  dbo.RelatedContact RC
      
      left join  dbo.RelatedContactDetail RCD on rc.RelatedContactID=rcd.RelatedContactID
      left join  dbo.RelatedContactRelationshipType rcrt on rcd.RelatedContactRelationshipTypeID = rcrt.RelatedContactRelationshipTypeID
      left join [$(SolomonApp)].dbo.cftContact cc on rc.ContactID = cc.ContactID
      left join [$(SolomonApp)].dbo.cftContact ri on rc.RelatedID = ri.ContactID
            where 
                  cc.StatusTypeID = 1
                  and rcrt.RelatedContactRelationshipTypeID in (50)) rc
      left join [$(SolomonApp)].dbo.cftSite cftSite on rc.ContactID = cftSite.ContactID
      left join [$(SolomonApp)].dbo.cftFacilityType cftFT on cftSite.FacilityTypeID = cftFT.FacilityTypeID 
      left join (select distinct P.SiteContactID as SiteMgrID, Max(P.ExpirationDate) ExpDate from  dbo.Permit P
      left join [$(SolomonApp)].dbo.cftContact C on P.SiteContactID = C.ContactID
            where P.PermitTypeID in (12,27,31)
                  and C.ContactTypeID = 03
                  and P.ExpirationDate is not null
            group by
                  P.SiteContactID) PermitExp
            on rc.RelatedID = PermitExp.SiteMgrID
      left join  dbo.Permit Permit on PermitExp.SiteMgrID = Permit.SiteContactID
            and PermitExp.ExpDate = Permit.ExpirationDate
            --pulling role = Pig Care 

union
Select Distinct
rc.ContactName as 'SiteName',
cftFT.Description as 'FacilityTypeDescription',
rc.RelatedName as 'Name',
rc.RelatedContactRelationshipDescription as 'Role',
Permit.IssueDate,
Permit.ExpirationDate
      from (select Distinct
            rc.ContactID,
            cc.ContactName,
            rc.RelatedID,
            ri.ContactName as 'RelatedName',
            rcrt.RelatedContactRelationshipDescription
      from  dbo.RelatedContact RC
      
      left join  dbo.RelatedContactDetail RCD on rc.RelatedContactID=rcd.RelatedContactID
      left join  dbo.RelatedContactRelationshipType rcrt on rcd.RelatedContactRelationshipTypeID = rcrt.RelatedContactRelationshipTypeID
      left join [$(SolomonApp)].dbo.cftContact cc on rc.ContactID = cc.ContactID
      left join [$(SolomonApp)].dbo.cftContact ri on rc.RelatedID = ri.ContactID
            where 
                  cc.StatusTypeID = 1
                  and rcrt.RelatedContactRelationshipTypeID in (7)
                  and rtrim(ri.ContactName) <> 'CFF'
                  ) 
      rc
      
      left join [$(SolomonApp)].dbo.cftSite cftSite on rc.ContactID = cftSite.ContactID
      left join [$(SolomonApp)].dbo.cftFacilityType cftFT on cftSite.FacilityTypeID = cftFT.FacilityTypeID 
      left join (select distinct P.SiteContactID as SiteMgrID, Max(P.ExpirationDate) ExpDate from  dbo.Permit P
      left join [$(SolomonApp)].dbo.cftContact C on P.SiteContactID = C.ContactID
      where P.PermitTypeID in (12,27,31)
            and C.ContactTypeID = 03
            and P.ExpirationDate is not null
            
      group by
            P.SiteContactID) PermitExp
      on rc.RelatedID = PermitExp.SiteMgrID
      left join  dbo.Permit Permit on PermitExp.SiteMgrID = Permit.SiteContactID 
            and PermitExp.ExpDate = Permit.ExpirationDate
            --pulling role = Employee
            
            ) a
            
            where a.ExpirationDate <= @expirdate OR a.ExpirationDate is Null
            and a.sitename not in (
            'Sleepy Eye Truck Wash',
            'Alden Truck Wash',
            'Atkinson Truck Wash',
            'Bloomfield Truck Wash',
            'Comfrey Truck Wash',
            'Kansas Commercial Wash',
            'Kansas High Health Wash',
            'Pierre Truck Wash',
            'SE Truck Wash - High Health',
            'Sleeyp Eye Truck Wash',
            'Southern Iowa Truck Wash',
            'Truck Wash Alden Manure Storage',
            'Truck Wash Bloomfield Manure Storage')



--select * from #stage1

insert into #stage2
(SiteName,siteid,FacilityTypeDescription,Name,Role,IssueDate,ExpirationDate)	-- 201411 added siteid
select SiteName,siteid,FacilityTypeDescription,Name,Role,IssueDate,ExpirationDate 
from 
	(select SiteName, siteid,FacilityTypeDescription,Name,Role,IssueDate,ExpirationDate, row_number() over (Partition by name Order by sitename) as rownbr	-- 201411 added siteid
            from  #stage1 (nolock)
            join  dbo.contact c (nolock)	-- 201411 added for siteid
				on c.contactname = sitename	-- 201411 added for siteid
			join  dbo.site s (nolock)	-- 201411 added for siteid
				on s.contactid = c.contactid	-- 201411 added for siteid
     ) xx
where rownbr = 1
order by sitename


      



-- =============================================
-- Update #stage2 regions with svc manger
-- =============================================
DECLARE mgr CURSOR
FOR select sitename from #stage1

DECLARE @name varchar(50)
OPEN mgr

FETCH NEXT FROM mgr INTO @name
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN

DECLARE @Concat as varchar(8000)
declare @regioncontactid as varchar(6)

select @regioncontactid = contactid from  dbo.contact where contactname = @name



SELECT @Concat = isnull(@Concat + '; ', '') + ltrim(rtrim(SourceTable.mgrname))
from (select distinct  c.contactname mgrname
	from 
	(select c.contactid sitecontactid, c.contactname sitename, rcx.relatedid regioncontactid, rcx.contactid, regionc.contactname regionname
	 from  dbo.Contact C (nolock)
		LEFT JOIN  dbo.RelatedContact rcx (nolock) on rcx.ContactID = c.ContactID and rcx.SummaryOfDetail = 'Region'
		LEFT JOIN  dbo.Contact regionc (NOLOCK) on regionc.ContactID = rcx.RelatedID
	 where c.contacttypeid = 4 and rcx.SummaryOfDetail = 'Region' and rcx.relatedid = @regioncontactid) rel
	inner join (SELECT [SiteContactID]  ,max([EffectiveDate]) effectivedate  FROM [dbo].[SiteSvcMgrAssignment] (nolock) group by sitecontactid) base
		on base.sitecontactid = rel.sitecontactid
	inner join [dbo].[SiteSvcMgrAssignment] last (nolock)
		on last.sitecontactid = base.sitecontactid and last.effectivedate = base.effectivedate
	inner join  dbo.Contact c (nolock)
		on c.contactid = last.svcmgrcontactid) SourceTable

update #stage2 
set svcmgr = case when substring(@concat,1,1) = ';' then substring(@concat,2,7999) else @concat end
where #stage2.sitename = @name and svcmgr is null




	END
	FETCH NEXT FROM mgr INTO @name
	set @concat = ''
END

--select * from #stage2

CLOSE mgr
DEALLOCATE mgr


set @concat = ''
-- =============================================
-- Update #stage2 sites with other mangers
-- =============================================
DECLARE smgr CURSOR
FOR select sitename from #stage1

--DECLARE @name varchar(50)
OPEN smgr

FETCH NEXT FROM smgr INTO @name
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN

--DECLARE @Concat as varchar(8000)
declare @sitecontactid as varchar(6)

select @sitecontactid = contactid from  dbo.contact where contactname = @name

-- set service manager name(s)

SELECT @Concat = isnull(@Concat + '; ', '') + ltrim(rtrim(SourceTable.mgrname))
from (select distinct  SSM.SrSvcName mgrname
	from 
	(SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.ProdSvcMgrContactID,sm2.EffectiveDate,c.ContactID SrSvcContactID,c.ContactName SrSvcName
            FROM (
                        SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                        FROM  dbo.ProdSvcMgrAssignment 
                              GROUP BY SiteContactID) sm1
      LEFT JOIN  dbo.ProdSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN  dbo.Contact c ON c.ContactID=sm2.ProdSvcMgrContactID
      LEFT JOIN  dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SSM
      where  SSM.SiteContactID=@sitecontactid
) SourceTable
		


update #stage2 
set svcmgr = case when substring(@concat,1,1) = ';' then substring(@concat,2,7999) else @concat end
where #stage2.sitename = @name and isnull(svcmgr,'') = ''


set @concat = ''

---- get production/farm manager name
	
SELECT @Concat = isnull(@Concat + '; ', '') + ltrim(rtrim(SourceTable.mgrname))
from (select distinct  SSM.svcmgrName mgrname
	from 
	(SELECT sm1.SiteContactID,c2.ContactName SiteName,sm2.SvcMgrContactID,sm2.EffectiveDate,c.ContactID SvcContactID,c.ContactName svcmgrName
            FROM (
                        SELECT SiteContactID,Max(EffectiveDate) EffectiveDate 
                        FROM  dbo.SiteSvcMgrAssignment 
                              GROUP BY SiteContactID) sm1
      LEFT JOIN  dbo.SiteSvcMgrAssignment sm2 ON sm2.SiteContactID=sm1.SiteContactID and sm2.EffectiveDate=sm1.EffectiveDate
      LEFT JOIN  dbo.Contact c ON c.ContactID=sm2.SvcMgrContactID
      LEFT JOIN  dbo.Contact c2 ON c2.ContactID=sm1.SiteContactID) SSM
      where  SSM.SiteContactID=@sitecontactid
) SourceTable
		

update #stage2 
set prod_farmmgr = case when substring(@concat,1,1) = ';' then substring(@concat,2,7999) else @concat end
where #stage2.sitename = @name and isnull(prod_farmmgr,'') = ''


set @concat = ''
	
-- get sitemanger name
	
SELECT @Concat = isnull(@Concat + '; ', '') + ltrim(rtrim(c.contactname))
from [$(SolomonApp)].dbo.cftSite site (nolock)
LEFT JOIN  dbo.Contact c (nolock) ON c.ContactID=site.sitemgrcontactid
where site.ContactID=cast(@sitecontactid as int)
		

update #stage2 
set sitemgr = case when substring(@concat,1,1) = ';' then substring(@concat,2,7999) else @concat end
where #stage2.sitename = @name and isnull(sitemgr,'') = ''

set @concat = ''

---- pod
--set @concat = ''

--SELECT @concat = podc.contactname
--from  dbo.RelatedContact rcp  
--  LEFT JOIN  dbo.Contact podc (NOLOCK) on podc.ContactID = rcp.RelatedID
--where rcp.contactID = @sitecontactid and rcp.SummaryOfDetail = 'Pod'

--update #stage2 
--set pod = @concat 
--where #stage2.sitename = @name and pod is null


--set @concat = ''


	END
	FETCH NEXT FROM smgr INTO @name

END

select sitename  as Site
, siteid	-- added 201411 sripley for amy
, facilitytypedescription  as Phase
, name as Name
, role as Role
, issuedate as Issued
, expirationdate as [Expires On]
, svcmgr as SM
, prod_farmmgr as [Prod/Farm Mgr]
, sitemgr as [Site Mgr]
from #stage2

CLOSE smgr
DEALLOCATE smgr

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_pqaindividual] TO [SE\PQA Individuals]
    AS [dbo];

