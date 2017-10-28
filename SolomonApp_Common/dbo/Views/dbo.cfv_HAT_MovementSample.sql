


CREATE VIEW [dbo].[cfv_HAT_MovementSample]
AS
select SPID, t1.[Timing],t1.[Days],
  stuff((SELECT distinct ', ' + cast(t2.[TranTypeID] as varchar(50))
           FROM [dbo].[cft_HAT_MovementSample] t2
           where t2.SPID = t1.SPID  and t2.[Expire_DT] is null
           FOR XML PATH('')),1,1,'') as MovementID
from [dbo].[cft_HAT_MovementSample] t1
where t1.[Expire_DT] is null
group by SPID ,t1.[Timing],t1.[Days]



