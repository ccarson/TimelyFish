CREATE view cfv_MaintenanceCreditUsage as
-- -------------------------------------------------
-- Created 12/23/2014
--
-- This view is used by the Dynamics SL Crystal Report 08.830.00
-- --------------------------------------------------
select pj.customer, ps.project, pj.project_desc,
	ad.batnbr as BatchNumber, ar.OrdNbr as SkyWO, case ar.Rlsed when 0 then 'Not Released' else 'Released' end as InvoiceStatus, 
	b.status as batchStatus,
	ad.CuryDocBal as InvoiceAmount,
    CAST(datepart(yyyy,getdate()) as varchar(4)) as FY, ps.total_budget_amount as FYCreditAmt, SUM(abs(isnull(ar.TranAmt,0))) as ConsumedCreditOnInvoice,
    max(ccm.ConsumedCredit) as TotalCreditConsumed
from pjptdsum ps
inner join PJPROJ pj on pj.project=ps.project  and ps.acct = 'R&M CREDIT'
inner join ARDoc ad on ad.ProjectID=ps.project
inner join batch b on b.batnbr=ad.batnbr and b.module='AR'
inner join ARTran ar on ad.BatNbr=ar.BatNbr and ad.RefNbr=ar.RefNbr and ar.User5='MC' --and ar.Rlsed=1 
left join cfv_crm_maintcredit ccm on ccm.customer=pj.customer and ccm.project=ps.project and ccm.fy=ar.fiscYr
where pjt_entity='MC'+CAST(ar.fiscYr as varchar(4))
Group BY pj.customer, ps.project, pj.project_desc,
	ad.batnbr, ar.OrdNbr, ar.Rlsed, b.status, ad.CuryDocBal,
	ps.total_budget_amount
