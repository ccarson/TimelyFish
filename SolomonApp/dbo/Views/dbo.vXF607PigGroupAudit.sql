Create  view dbo.vXF607PigGroupAudit
AS
Select pg.*, 
OldData=Case when pg.AttributeName='Est Start Date' then
	convert(varchar(10), OldValue, 101) 
	else OldValue end ,
NewData=Case when pg.AttributeName='Est StartDate' then 
	convert(varchar(10), NewValue,101) 
	else NewValue end 
 from 
cftPigGroupAudit pg 
JOIN
(Select max(ID) as LastRecord, AttributeName, PigGroupID
	from cftPigGroupAudit
	group by AttributeName, PigGroupID) temp
on pg.ID=temp.LastRecord
