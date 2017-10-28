



CREATE VIEW [dbo].[cfv_CRM_SL2CRM_WorkOrders]   AS 

select
sc.servicecallid
, sc.cpnyid 
-- Work Order
, sc.callstatus
--, case when sc.calltype = 'RP' then 'Repair' -- sometimes repair is maint
--       when sc.calltype = 'PM' then 'Preventative' end [Work Order Type]    -- work order type... need to translate RP to repair
, t.calltypedesc
, sc.assignempid, ltrim(rtrim(e.employeefirstname)) + ' ' + ltrim(rtrim(e.employeelastname)) as employee -- [assigned to or preferred resource?] --, 'preferred resource'
, sc.callername  as requestor-- requestor name
, '' as phone  -- look up based on callername?

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
  FROM [SolomonApp].[dbo].[smServCall] sc (nolock)
  left join solomonapp.dbo.customer c (nolock)
      on sc.customerid = c.custid
  left join solomonapp.dbo.smemp e (nolock)
      on e.employeeid = sc.assignempid
  left join [SolomonApp].[dbo].[smCallTypes] T (nolock)
      on t.calltypeid = sc.calltype
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
  where sc.lupd_datetime > getdate() - 120 and sc.callstatus not in ('cancelled','canceled', 'complete')
  





