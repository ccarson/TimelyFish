CREATE VIEW  [CFMobileFarms].[LocationComments]
AS
select 
CONVERT(nvarchar, [Source_ID]) as Id
,[Source_ID] as LocationContactID, t1.[Comment_Type] as CommentType,
  stuff((SELECT ';  ' + cast(t2.[Comments] as varchar(2000))
           FROM [dbo].[Comments] t2
           where t2.Source_ID = t1.Source_ID and t2.[Comment_Type] = t1.[Comment_Type]
                                   order by [Sort_Order]
           FOR XML PATH('')),1,1,'') as Comments
		  ,CONVERT(timestamp, null)  as Version 
		  ,CONVERT(datetimeoffset(7), null) as CreatedAt
			,CONVERT(datetimeoffset(7), null) as UpdatedAt
			,CONVERT(bit, 0) as Deleted       

from [dbo].[Comments] t1
group by [Source_ID] ,t1.[Comment_Type]









GO
GRANT SELECT
    ON OBJECT::[CFMobileFarms].[LocationComments] TO [hybridconnectionlogin_permissions]
    AS [HybridConnectionLogin];

