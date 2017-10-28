--Lookup that should be used to populate the Index
CREATE PROCEDURE WSL_AvailableQueryViews @userId varchar(47), @cpnyId varchar(10)
AS
select
 	rtrim(m.ModuleName) 'Module',
 	rtrim(s.name) 'Number',
 	rtrim(qvc.QueryViewName) 'QueryViewName',
 	rtrim(qvc.ViewDescription) 'ViewDescription'
 	 	
from vs_qvcatalog qvc
 	inner join vs_modules m on m.ModuleCode = qvc.Module
 	inner join vs_screen s on s.number = qvc.Number
 	inner join vs_accessdetrights adr on adr.ScreenNumber = qvc.Number
 	left join vs_usergrp ug on ug.GroupId = adr.UserId and adr.RecType = 'G'
 	left join vs_usergrp ug2 on ug2.GroupId = qvc.Visibility and qvc.VisibilityType = 1 and ug2.UserId = @userId
where
 	((adr.UserId = @userId and adr.RecType = 'U') or ug.UserId = @userId) and
 	(adr.CompanyID = @cpnyId or adr.CompanyID = '[ALL]') and
 	(qvc.VisibilityType = 0 or (qvc.Visibility = @userId and qvc.VisibilityType = 2) or ug2.UserId is not null or adr.InitRights = 1)
