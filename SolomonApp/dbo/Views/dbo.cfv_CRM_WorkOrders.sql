



CREATE VIEW [dbo].[cfv_CRM_WorkOrders]   AS 

/* ----------------------------------------------------------------------------------
11/16/15	BMD	Started a Change log
11/16/15	BMD	Updated the TaskID section to process "OJ" jobs for both billable and non-billable work orders.
				This will allow M&R to process billable work orders with customer billing amounts (1st=downpayment, 2nd=balancedue)
				The non-billable "OJ" job will contain labor and parts/services if necessary and since non-billable will not create a customer invoice.
11/17/15	BMD Updated SalesAcct and CogsAcct to handle the fact OJ jobs can now be both billable and non-billable.
11/19/15	BMD	Rewrote sections of the query to tune it
10/06/16	NJH	Added a line for "RE" projects in the case statement for selecting a task code.
----------------------------------------------------------------------------------- */
	SELECT 
	   wo.[f1_workorderId]
      ,wo.[CreatedOn]
      ,wo.[CreatedBy]
      ,wo.[ModifiedOn]
      ,wo.[ModifiedBy]
      ,wo.[CreatedOnBehalfBy]
      ,wo.[ModifiedOnBehalfBy]
      ,wo.[OwnerId]
      ,wo.[OwnerIdType]
      ,wo.[OwningBusinessUnit]
      ,wo.[statecode]
      ,wo.[statuscode]
      ,wo.[TransactionCurrencyId]
      ,wo.[ExchangeRate]
      ,wo.[f1_TimeClosed]
      ,wo.[f1_ServiceRequest]
      ,wo.[f1_Latitude]
      ,wo.[f1_EstimateSubtotalAmount]
      ,wo.[f1_ImportID]
      ,wo.[f1_ServiceOverhead]
      ,wo.[f1_PrimaryIncident]
      ,wo.[f1_totalamount_Base]
      ,wo.[f1_SubtotalAmount]
      ,wo.[f1_SalesPerson]
      ,wo.[f1_estimatesubtotalamount_Base]
      ,wo.[f1_City]
      ,wo.[f1_name]
      ,wo.[f1_PrimaryIncidentDescription]
      ,wo.[f1_Address1]
      ,wo.[f1_PrimaryIncidentType]
      ,wo.[f1_TotalSalesTax]
      ,wo.[f1_TimeWindowStart]
      ,wo.[f1_FollowUpNote]
      ,wo.[f1_Agreement]
      ,wo.[f1_subtotalamount_Base]
      ,wo.[f1_SchedulingMethod]
      ,wo.[f1_PriceList]
      ,wo.[f1_EstimatedTime]
      ,wo.[f1_Address2]
      ,wo.[f1_TimeFromPromised]
      ,wo.[f1_ServiceAccount]
      ,wo.[f1_IsFollowUp]
      ,wo.[f1_ClosedBy]
      ,wo.[f1_CampaignSource]
      ,wo.[f1_WorkOrderType]
      ,wo.[f1_WorkOrderSummary]
      ,wo.[f1_ProductOverhead]
      ,wo.[f1_systemstatusold]
      ,wo.[f1_OpportunityId]
      ,wo.[f1_TotalAmount]
      ,wo.[f1_TaxCode]
      ,wo.[f1_ParentWorkOrder]
      ,wo.[f1_SystemStatus]
      ,wo.[f1_Index]
      ,wo.[f1_Country]
      ,wo.[f1_CustomerPO]
      ,wo.[f1_Taxable]
      ,wo.[f1_Longitude]
      ,wo.[f1_TimeWindowEnd]
      ,wo.[f1_IsGeneratedByMethod]
      ,wo.[f1_PreferredResource]
      ,wo.[f1_Instructions]
      ,wo.[f1_TimeToPromised]
      ,wo.[f1_ServiceTerritory]
      ,wo.[f1_Status]
      ,wo.[f1_Zip]
      ,wo.[f1_ScheduleSummary]
      ,wo.[f1_CustomerEquipment]
      ,wo.[f1_AddressName]
      ,wo.[f1_DateWindowEnd]
      ,wo.[f1_PrimaryResourceSchedule]
      ,wo.[f1_WorkLocation]
      ,wo.[f1_FollowUpRequired]
      ,wo.[f1_Address3]
      ,wo.[f1_DateWindowStart]
      ,wo.[f1_DispatchedTime]
      ,wo.[f1_totalsalestax_Base]
      ,wo.[f1_ChildIndex]
      ,wo.[f1_DispatchedBy]
      ,wo.[f1_IsMobile]
      ,wo.[f1_ReportedByContact]
      ,wo.[f1_Priority]
      ,wo.[f1_BillingAccount]
      ,wo.[f1_State]
      ,wo.[processid]
      ,wo.[stageid]
      ,wo.[f1_RoutingOptimization]
      ,wo.[cf_ApplyCredit]
      ,wo.[cf_ApproversPhone]
      ,wo.[cf_Billable]
      ,wo.[cf_BioSecurity]
      ,wo.[cf_BSCall]
      ,wo.[cf_InvoiceComments]
      ,wo.[cf_NeedsApproval]
      ,wo.[cf_PigSizePigDaysPigHealth]
      ,wo.[cf_ProjectID]
      ,wo.[cf_RequestorName]
      ,wo.[cf_RequestorPhone]
      ,wo.[cf_SLAEndTime]
      ,wo.[cf_SLAStartTime]
      ,wo.[cf_SLAStatus]
      ,wo.[cf_TechnicianComments]
      ,wo.[cf_Account_WorkOrder_ProjectId]
      ,wo.[cf_Barn]
      ,wo.[cf_Bin]
      ,wo.[cf_PigGroup]
      ,wo.[cf_Project]
      ,wo.[cf_Room]
      ,wo.[cf_Approver]
      ,wo.[cf_AssociatedInvoice]
      ,wo.[SyncStatus]
      ,wo.[SyncDate]
      ,wo.[CustID]
      ,wo.[ProjectNumber]
      ,wo.[ServiceTerritory]
	,CASE WHEN ISNULL(wo.cf_invoicecomments,'') = '' THEN 'SKIP' ELSE CAST(wo.cf_invoicecomments as varchar(2000)) END AS InvoiceComments
	,CASE WHEN ISNULL(wo.cf_invoicecomments,'') = '' THEN 'SKIP' ELSE CAST(wo.cf_invoicecomments as varchar(2000)) END AS InvoiceComments2
	,ac.FYCreditAmt 
	,ac.ConsumedCredit * -1 ConsumedCredit
	,terms.DiscIntrv
	,terms.DueIntrv
	,terms.TermsId
	,LineCount.NbrOfLines
	,CONVERT(VARCHAR(10), wo.f1_TimeClosed, 111) 'Converted_f1_TimeClosed'
	,Line.f1_WorkOrder AS WOID
	,Line.LineGUID
	,Line.LineNbr
	,Line.[f1_TotalCost]
	,Line.[f1_unitamount_Base]
	,Line.[f1_Quantity]
	,Line.[f1_LineStatus]
	,Line.[f1_Warehouse]
	,Line.[f1_WorkOrderIncident]
	,Line.[f1_UnitAmount]
	,Line.[f1_unitcost_Base]
	,Line.[f1_subtotal_Base]
	,Line.[f1_TotalAmount] AS LineTotalAmount
	,Line.[f1_Subtotal]
	,Line.[f1_Product]
	,CASE WHEN Line.[f1_Description] IS NULL THEN line.f1_name ELSE Line.[f1_Description] END AS f1_description 
	,Line.[f1_name] AS LineName
	,Line.[f1_UnitCost]
	,Line.[f1_QtyToBill]
	,Line.[f1_Allocated]
	,Line.[f1_totalcost_Base]
	,Line.LineType
	,Line.InvtID
	,case when (CASE WHEN LEFT(wo.cf_projectID,2) = 'OJ' THEN '66050' 
					 WHEN wo.cf_billable = 1 THEN ItemSite.COGSAcct 
					 WHEN LEFT(wo.cf_ProjectID,2)='CP' THEN '17200' 
					 ELSE ItemSite.COGSAcct 
					 END) IS null then Inventory.COGSAcct 
		  else (CASE WHEN LEFT(wo.cf_projectID,2) = 'OJ' THEN '66050' 
					 WHEN wo.cf_billable = 1 THEN ItemSite.COGSAcct 
					 WHEN LEFT(wo.cf_ProjectID,2)='CP' THEN '17200' 
					 ELSE ItemSite.COGSAcct 
					 END) 
		  End AS COGSAcct
	,CASE when wo.cf_billable = 1 THEN branch.user1 ELSE project.gl_subacct END COGSSub 
	,case when ItemSite.InvtAcct IS null then Inventory.InvtAcct else ItemSite.InvtAcct end as InvtAcct
	,case when ItemSite.InvtSub IS NULL then Inventory.InvtSub else ItemSite.InvtSub end as InvtSub
	,case when (CASE WHEN wo.cf_billable = 1 THEN itemsite.SalesAcct 
					 WHEN LEFT(wo.cf_ProjectID,2)='CP' THEN '17200' 
					 WHEN LEFT(wo.cf_ProjectID,2)='OJ' THEN '66050'
					 ELSE ItemSite.COGSAcct END) is NULL 
		  then Inventory.DfltSalesAcct 
		  else (CASE WHEN wo.cf_billable = 1 THEN (CASE WHEN LEFT(wo.cf_ProjectID,2)='OJ' THEN '66050' ELSE itemsite.SalesAcct END)
	  				 WHEN LEFT(wo.cf_ProjectID,2)='CP' THEN '17200' 
	  				 WHEN LEFT(wo.cf_ProjectID,2)='OJ' THEN '66050'
					 ELSE ItemSite.COGSAcct END) 
		  end AS SalesAcct
	,CASE WHEN wo.cf_billable = 1 
		THEN (CASE WHEN LEFT(wo.cf_ProjectID,2)='OJ' THEN project.gl_subacct ELSE branch.user1 END)
		ELSE project.gl_subacct 
		End as user1
	,wo.cf_projectid AS CRM_PRoject
	,project.gl_subacct
	,-32768 + (Line.LineNbr-1)*256 AS LineID
	,line.WarehouseName
	, terms.ArAcct, terms.ArSub, dateadd(d,terms.DueIntrv,wo.f1_TimeClosed) DueDate
	,cast(case when cast(ISNULL(wo.cf_ApplyCredit,0) as int) = 1  THEN 'Y' Else 'N' End as nchar(1)) ApplyCredittxt
	,cast(datepart(yyyy,wo.f1_TimeClosed) as varchar(4)) F1_TimeClosedYear
	,TotalMod.InventoryNotUsedFromSiteTotalAmount
	,CASE WHEN LEFT(wo.cf_ProjectID,2)='OJ' AND Line.InvtID LIKE '1MISC%' THEN 'RV10000' -- BMD 11/16/2015 Updated to work for both billable and non-billable
		  WHEN LEFT(wo.cf_ProjectID,2)='OJ' AND Line.InvtID LIKE '%LABOR' THEN 'GC44100' -- BMD 11/16/2015 Updated to work for both billable and non-billable
		  WHEN LEFT(wo.cf_ProjectID,2)='CP' AND Line.InvtID LIKE '%LABOR' THEN 'GC44100'
		  WHEN LEFT(wo.cf_ProjectID,2)='RE' AND Line.InvtID LIKE '%LABOR' THEN 'GC44100' -- NJH 10/6/2016  Updated to include "RE" projects
		  WHEN LEFT(wo.cf_ProjectID,2)='VH' THEN 'VH00000'
		  WHEN LEFT(wo.cf_ProjectID,2)='HS' THEN 'SC00000'
		  WHEN LEFT(wo.cf_ProjectID,2)='PS' THEN 'SC00000'
		  ELSE 'SC00000'
		  END AS TASK
	,Inventory.ClassID  -- BMD 9/16/2015 Added ClassID to enable exclusion of expense items from inventory batches when project is like "OJ%"

FROM [solomonapp].[dbo].[cft_scribe_CRM_Staging_WorkOrder] AS wo (NOLOCK)
LEFT JOIN [SolomonApp].[dbo].[PJPROJ] AS project (NOLOCK) ON project.project = cf_projectid
LEFT JOIN [SolomonApp].[dbo].[smBranch] AS branch on branch.BranchId = wo.ServiceTerritory
LEFT JOIN  
	--Maintenance Credit Logic.
	(select customer, ps.project, substring(ps.pjt_entity,3,4) as FY, total_budget_amount as FYCreditAmt, SUM(isnull(ar.TranAmt,0)) as ConsumedCredit
		from [solomonapp].[dbo].[pjptdsum] as ps (NOLOCK)
		inner join PJPROJ pj on pj.project=ps.project and ps.acct = 'R&M Credit'
		left join ARDoc ad (NOLOCK) on ad.ProjectID=ps.project
		left join batch b (NOLOCK) on b.batnbr=ad.batnbr and b.module='AR' and b.Status in ('P', 'B', 'H')
		left join ARTran ar (NOLOCK) on ad.BatNbr=ar.BatNbr and ad.RefNbr=ar.RefNbr 
		and ar.User5='MC' and cast(substring(ps.pjt_entity,3,4) as int) = ar.FiscYr	--'MC'+CAST(ar.FiscYr as varchar(4))
		where pjt_entity like 'MC20%'
		Group BY ps.project,ps.pjt_entity,total_budget_amount, customer
	) AS AC
	ON AC.Customer = wo.Custid 
	AND ac.Project = wo.cf_ProjectID
	AND ac.FY = cast(datepart(yyyy,wo.f1_TimeClosed) as varchar(4))
--Batch total logic
LEFT Join (
	select [f1_WorkOrder], SUM([f1_TotalAmount]) as InventoryNotUsedFromSiteTotalAmount
	from (	SELECT [f1_WorkOrder], [f1_TotalAmount] FROM [SolomonApp].[dbo].[cft_scribe_CRM_Staging_WorkOrderProduct]   
			where (cf_InventoryUsedFromSite is null or cf_InventoryUsedFromSite = 'F') and statecode=0
			union ALL
			select [f1_WorkOrder], [f1_TotalAmount]	from [SolomonApp].[dbo].[cft_scribe_CRM_Staging_WorkOrderService]  
			where statecode=0
			) Lines
	group by f1_WorkOrder
	) as TotalMod on TotalMod.f1_WorkOrder=wo.f1_workorderId
LEFT JOIN
	(	SELECT Custid, t.termsid, t.DiscIntrv, t.DueIntrv, c.ArAcct, c.ArSub
		FROM [solomonapp].[dbo].[Customer] as C (NOLOCK) 
		LEFT JOIN Terms T (NOLOCK) ON t.termsid = c.Terms
	) AS Terms ON Terms.CustID = wo.Custid

INNER JOIN 
	(
select [f1_WorkOrder]
        ,ROW_NUMBER () over (PARTITION by [f1_WorkOrder] order by [f1_LineOrder_]) as LineNbr
        ,LineGUID
        --,[CreatedOn]
        --,[ModifiedOn]
        --,[statuscode]
        ,[f1_TotalCost]
        ,[f1_unitamount_Base]
        ,[f1_Quantity]
        ,[f1_Taxable]
        ,[f1_LineStatus]
        ,[f1_Warehouse]
        ,[f1_WorkOrderIncident]
        ,[f1_UnitAmount]
        ,[f1_unitcost_Base]
        ,[f1_subtotal_Base]
        ,[f1_totalamount_Base]
        ,[f1_TotalAmount]
        ,[f1_Subtotal]
        ,[f1_Product]
        ,[f1_Description]
        ,[f1_name]
        ,[f1_UnitCost]
        ,[f1_QtyToBill]
        ,[f1_Allocated]
        ,[f1_totalcost_Base]
		,LineType
		,InvtID
		,warehousename
from (
		SELECT [f1_WorkOrder]
				,[f1_LineOrder_]
				,[f1_workorderproductId] as LineGUID
				,[f1_TotalCost]
				,[f1_unitamount_Base]
				,[f1_Quantity]
				,[f1_Taxable]
				,[f1_LineStatus]
				,[f1_Warehouse]
				,[f1_WorkOrderIncident]
				,[f1_UnitAmount]
				,[f1_unitcost_Base]
				,[f1_subtotal_Base]
				,[f1_totalamount_Base]
				,[f1_TotalAmount]
				,[f1_Subtotal]
				,[f1_Product]
				,[f1_Description]
				,[f1_name]
				,[f1_UnitCost]
				,[f1_QtyToBill]
				,[f1_Allocated]
				,[f1_totalcost_Base]
				,'Product' AS LineType
				,InvtID
				,warehousename
		FROM [SolomonApp].[dbo].[cft_scribe_CRM_Staging_WorkOrderProduct]   
		where (cf_InventoryUsedFromSite is null or cf_InventoryUsedFromSite = 'F') and statecode=0 
        
		union
        
		select [f1_WorkOrder]
				,[f1_LineOrder]
				,[f1_workorderServiceId] as LineGUID
				,[f1_TotalCost]
				,[f1_unitamount_Base]
				,f1_duration/60.0 as [f1_Quantity]
				,[f1_Taxable]
				,[f1_LineStatus]
				,NULL as [f1_Warehouse]
				,[f1_WorkOrderIncident]
				,[f1_UnitAmount]
				,[f1_unitcost_Base]
				,[f1_subtotal_Base]
				,[f1_totalamount_Base]
				,[f1_TotalAmount]
				,[f1_Subtotal]
				,[f1_Service]
				,[f1_Description]
				,[f1_name]
				,[f1_UnitCost]
				,NULL as [f1_QtyToBill]
				,NULL as [f1_Allocated]
				,[f1_totalcost_Base]
				,'Service' AS LineType
				,InvtID

				--Warehouse line may require a change if the issue where Labor Items are inconsistent in the ItemSite table is resolved.  
				,CASE invtid 
                        WHEN '1LABOR'               THEN '101' 
						WHEN '2LABOR'               THEN '100' 
						WHEN '1TRIP'                THEN '100' 
						WHEN '1IATX7'               THEN '100' 
						WHEN '1LABOR-WATER'         THEN '100'
						WHEN '1LABOR-WOOD CHIPS'    THEN '100'
						WHEN '1LABOR-SITE CARE'     THEN '100'
                        WHEN '1PROJTRIP'            THEN '100'
				        ELSE warehousename 
				  END AS warehousename
				--*/
				--,'101' AS warehousename
			  from [SolomonApp].[dbo].[cft_scribe_CRM_Staging_WorkOrderService] 
			  where statecode=0
		) Lines
) As Line on Line.f1_WorkOrder = wo.f1_workorderId

LEFT JOIN [solomonapp].[dbo].[ItemSite] (NOLOCK) on ItemSite.invtID = Line.InvtID 
										AND ItemSite.SiteID = warehousename		
LEFT JOIN [solomonapp].[dbo].[Inventory] (NOLOCK) on Inventory.invtID = Line.InvtID 

INNER JOIN 
	(
	SELECT f1_WorkOrder, MAX(LineNbr) AS NbrOfLines
	FROM (
		select [f1_WorkOrder]
				,ROW_NUMBER () over (PARTITION by [f1_WorkOrder] order by [f1_WorkOrder]) as LineNbr
		from (
				SELECT [f1_WorkOrder]
				  FROM [SolomonApp].[dbo].[cft_scribe_CRM_Staging_WorkOrderProduct]  
				 where (cf_InventoryUsedFromSite is null or cf_InventoryUsedFromSite = 'F')
				   and statecode = 0
        
				union ALL
				select [f1_WorkOrder]
				  from [SolomonApp].[dbo].[cft_scribe_CRM_Staging_WorkOrderService]  
				 where statecode = 0
				) Lines
			) AS Q1
	GROUP BY f1_WorkOrder
	) AS LineCount ON LineCount.f1_WorkOrder = wo.f1_workorderId




