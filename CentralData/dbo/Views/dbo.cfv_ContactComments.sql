CREATE VIEW [dbo].[cfv_ContactComments]
AS
select [Source_ID] as ContactID, t1.[Comment_Type] as CommentType,
  stuff((SELECT ';  ' + cast(t2.[Comments] as varchar(2000))
           FROM [dbo].[Comments] t2
           where t2.Source_ID = t1.Source_ID and t2.[Comment_Type] = t1.[Comment_Type]
                                   order by [Sort_Order]
           FOR XML PATH('')),1,1,'') as Comments
from [dbo].[Comments] t1
group by [Source_ID] ,t1.[Comment_Type]



