



--CREATE VIEW [dbo].[cfv_HAT_LabTests]
--AS
--select SPID, 
--  stuff((SELECT distinct ', ' + cast(s1.[Name] +' - ' + s1.method as varchar(50))
--           FROM [SolomonApp].[dbo].[cft_HAT_SampleTest] t2
--           join [SolomonApp].[dbo].[cft_HAT_Test] s1 on t2.TestID = s1.TestID
--           where t2.SPID = t1.SPID and s1.[Active_cde] like 'A' 
--           FOR XML PATH('')),1,1,'') as Lab
--from [SolomonApp].[dbo].[cft_HAT_SampleTest] t1
--where t1.[Expire_DT] is null
--group by SPID
-- replaced 20130820

CREATE VIEW [dbo].[cfv_HAT_LabTests]
AS
select SPID, 
  stuff((SELECT distinct ', ' + cast(s1.[Name] +' - ' + s1.method as varchar(50))
           FROM [dbo].[cft_HAT_SampleTest] t2
           join [dbo].[cft_HAT_Test] s1 on t2.TestID = s1.TestID
           where t2.SPID = t1.SPID and s1.[Active_cde] like 'A' and  t2.[Expire_DT] is null
           FOR XML PATH('')),1,1,'') as Lab
from [dbo].[cft_HAT_SampleTest] t1
where t1.[Expire_DT] is null
group by SPID



