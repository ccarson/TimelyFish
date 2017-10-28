

















-- ===================================================================
-- Author:  S ripley
-- Create date: 2014
-- Description: Selects data for CRM project service accounts extract
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CRM_work_order_extract]

AS
BEGIN
SET NOCOUNT ON;


truncate table solomonapp.dbo.cft_scribe_crm_workorder

insert into solomonapp.dbo.cft_scribe_crm_workorder
select
sc.servicecallid
, sc.cpnyid 
, sc.callstatus
, sc.calltype 
, t.calltypedesc


--, sc.assignempid, ltrim(rtrim(e.employeefirstname)) + ' ' + ltrim(rtrim(e.employeelastname))  [assigned to or preferred resource?] --, 'preferred resource'
, case when sc.calltype = 'rp' then RIGHT('000000'+CAST(crp.childcontactid AS VARCHAR(6)),6)
       when sc.calltype = 'pm' then RIGHT('000000'+CAST(cpm.childcontactid AS VARCHAR(6)),6) end preferredtech


, sc.callername   requestor-- requestor name
, sc.user2  

-- Farm
, sc.projectid    -- Project
, sc.customerid as billing_acct     -- link to billing account ??
, c.name
, case when substring(sc.projectid,1,2) = 'ps' then substring(sc.projectid,3,4) 
       when substring(sc.projectid,1,2) = 'cf' then substring(sc.projectid,3,4) else null end service_acct_siteid  --siteid    -- service account
, s.contactid service_acct_contactid
, case when cf.contactid is null and substring(sc.projectid,3,4) = s.contactid then  cf.contactname
       when cf.contactid is not null then cf.contactname
      else ct.contactname end service_acct_name
, sc.servicecallpriority      -- priority
, sc.servicecalldate    [SLA Start date]
, sc.servicecalltime    [SLA start time]
, sc.servicecallstatus  --'sla status'  -- inprogress??
, sc.servicecalldateprom as [Due Date]    -- sla date  yes the derived date value in CRM based on create date and priority
, sc.promtimeto         as [Due Time]           -- sla time
, DATEDIFF(dd, 0,sc.servicecalldate) + convert(datetime,replace(substring(sc.servicecalltime,1,2)+':'+substring(sc.servicecalltime,3,2)+':00.000',' ','')) sla_datetime
, DATEDIFF(dd, 0,sc.servicecalldateprom) + convert(datetime,replace(substring(sc.promtimeto,1,2)+':'+substring(sc.promtimeto,3,2)+':00.000',' ','')) due_datetime
, sc.crtd_datetime
, replace(sc.crtd_user+'@christensenfarms.com',' ','')
, null                                                                                                                                    
FROM [SolomonApp].[dbo].[smServCall] sc (nolock)
  left join solomonapp.dbo.customer c (nolock)
      on sc.customerid = c.custid
  left join solomonapp.dbo.smemp e (nolock)
      on e.employeeid = sc.assignempid
  left join [SolomonApp].[dbo].[smCallTypes] T (nolock)
      on t.calltypeid = sc.calltype and t.calltypeid in ('gr','pm','rp','sp')
  left join solomonapp.dbo.cftsite s (nolock)
      on s.siteid = case when substring(sc.projectid,1,2) = 'ps' then substring(sc.projectid,3,4) end
  left join solomonapp.dbo.cftcontact ct (nolock)
    on ct.contactid = s.contactid
  left join (select contactname, contactid, project, project_desc
            from (select project, project_desc, substring(project,3,4) contact from solomonapp.dbo.pjproj where substring(project,1,2) = 'cf' ) p
            left join centraldata.dbo.contact c
                  on c.contactid = substring(p.project,3,4)) cf
                        on cf.project = sc.projectid
  left join 
      (select servicecallid, siteid,sum(tranamt) tranamt, sum(quantity) quantity, count(1) as detaillines
        from [SolomonApp].[dbo].SMServDetail (nolock)
        group by servicecallid, siteid) det
            on det.servicecallid = sc.servicecallid
            
  left join
	( select ra.parentcontactid, ra.childcontactid
	  from centraldata.dbo.cftrelationshipassignment ra (nolock)
	  join (  select parentcontactid, childcontactid
	          , ROW_NUMBER() OVER(PARTITION BY parentcontactid 
	          ORDER BY case when cftrelationshipid = 1 then 3
	                        when cftrelationshipid = 2 then 1
	                        when cftrelationshipid = 3 then 2 
	                        when cftrelationshipid = 4 then 4 
	                        when cftrelationshipid = 5 then 5 end) rkey
	          from centraldata.dbo.cftrelationshipassignment (nolock)
	        ) rp1
				on rp1.parentcontactid = ra.parentcontactid and rp1.childcontactid = ra.childcontactid and rp1.rkey = 1
	 ) crp
		on crp.parentcontactid = s.contactid
		
	 
  left join
	( select ra.parentcontactid, ra.childcontactid
	  from centraldata.dbo.cftrelationshipassignment ra (nolock)
	  join (  select parentcontactid, childcontactid
	          , ROW_NUMBER() OVER(PARTITION BY parentcontactid 
	          ORDER BY case when cftrelationshipid = 1 then 1
	                        when cftrelationshipid = 2 then 3
	                        when cftrelationshipid = 3 then 2 
							when cftrelationshipid = 4 then 4 
	                        when cftrelationshipid = 5 then 5 end) rkey
	          from centraldata.dbo.cftrelationshipassignment (nolock)
	        ) rp1
				on rp1.parentcontactid = ra.parentcontactid and rp1.childcontactid = ra.childcontactid and rp1.rkey = 1
	 ) cpm
		on cpm.parentcontactid = s.contactid
		
	--left join (SELECT servicecallid, ltrim(rtrim(notes)) as [work order summary]
	--			FROM [SolomonApp].[dbo].smServFault (nolock)) f
	--	on f.servicecallid = sc.servicecallid and f.[work order summary] is not null
  where sc.callstatus not in ('cancelled','canceled', 'complete')
    and sc.callstatus > ''
  order by sc.servicecallid desc
  
declare @callid varchar(10) 

DECLARE	updt_wo CURSOR 
FOR SELECT servicecallid FROM [SolomonApp].[dbo].[cft_scribe_CRM_workorder]
FOR UPDATE of [work_order_summary]
--- loop through the table, update work order summary with concat data

open updt_wo
fetch next from updt_wo INTO @callid

while (@@fetch_status <> -1 )
begin


DECLARE @Concat as varchar(8000)

set @concat = ''

SELECT @Concat = isnull(@Concat + ', ', '') + 'Barnnbr: '+ ltrim(rtrim(user5))+' FaultcodeId:'+ltrim(rtrim(faultcodeid))+' Notes:' +ltrim(rtrim(f.notes))
FROM [SolomonApp].[dbo].smServFault f (nolock)
join [SolomonApp].[dbo].[cft_scribe_CRM_workorder] wo
	on wo.servicecallid = f.servicecallid and wo.servicecallid = @callid
	
update [SolomonApp].[dbo].[cft_scribe_CRM_workorder]
set [work_order_summary] = @concat
where servicecallid = @callid


fetch next from updt_wo INTO @callid

end

END


















GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_CRM_work_order_extract] TO [MSDSL]
    AS [dbo];

