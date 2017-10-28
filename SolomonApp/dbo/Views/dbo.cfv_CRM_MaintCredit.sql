

CREATE VIEW [dbo].[cfv_CRM_MaintCredit]   AS 

select customer, ps.project
     , RIGHT(rtrim(pjt_entity),4) AS FY --CAST(datepart(yyyy,getdate()) as varchar(4)) as FY
     , total_budget_amount as FYCreditAmt
     , SUM(abs(isnull(ar.TranAmt,0))) as ConsumedCredit
from [solomonapp].[dbo].[pjptdsum] as ps
inner join PJPROJ pj on pj.project=ps.project and ps.acct = 'R&M Credit'
left join ARDoc ad on ad.ProjectID=ps.project
left join ARTran ar on ad.BatNbr=ar.BatNbr and ad.RefNbr=ar.RefNbr 
and ar.User5='MC' and ar.FiscYr = RIGHT(rtrim(pjt_entity),4) --CAST(datepart(yyyy,getdate()) as varchar(4))
where pjt_entity like 'MC%' --pjt_entity='MC'+CAST(datepart(yyyy,getdate()) as varchar(4))
Group BY ps.project,RIGHT(rtrim(pjt_entity),4),total_budget_amount, customer


