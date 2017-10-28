

/****** Object:  Stored Procedure dbo.CF522p_GenPGListGrp    Script Date: 6/1/2005 5:00:58 PM ******/

/****** Object:  Stored Procedure dbo.CF522p_GenPGListGrp    Script Date: 4/12/2005 2:24:21 PM ******/


CREATE        Procedure CF522p_GenPGListGrp @parm1 varchar (32) as 
Select dbo.PgGetCapacity(p.PigGroupID)
-- Select CONVERT(INT, Case When r.RoomNbr is Null Then 
--		Coalesce((Select Sum(MaxCap) from cftBarn Where BarnNbr = p.BarnNbr and ContactId = p.SiteContactId), 0) 
--	Else 
--		Coalesce((Select Sum(b.MaxCap * m.BrnCapPrct) From cftBarn b Join cftRoom m on b.ContactId = m.ContactId and b.BarnNbr = m.BarnNbr Where b.ContactId = p.SiteContactId and b.BarnNbr = p.BarnNbr and m.RoomNbr = r.RoomNbr and b.StatusTypeID='1'), 0) 
--	End)
	from cftPigGroup p 
--	Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId
	Where p.TaskID = @parm1 






 