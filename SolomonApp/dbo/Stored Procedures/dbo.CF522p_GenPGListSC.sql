
Create Procedure CF522p_GenPGListSC @parm1 varchar (16) as 
    Create Table #PGCap (PGCnt Int, Task Char (32))
    Insert Into #PGCap (Task, PGCnt)
    Select p.TaskId, Convert(Int, Case When r.RoomNbr is Null Then 
	Coalesce((Select Sum(MaxCap) from cftBarn Where BarnNbr = p.BarnNbr and ContactId = p.SiteContactId), 0) 
	Else Coalesce((Select Sum(b.MaxCap * m.BrnCapPrct) From cftBarn b Join cftRoom m on b.ContactId = m.ContactId 
	and b.BarnNbr = m.BarnNbr Where b.ContactId = p.SiteContactId and b.BarnNbr = p.BarnNbr 
	and m.RoomNbr = r.RoomNbr), 0) End)
	from cftPigGroup p Join cftPGStatus s on p.PgStatusId = s.PGStatusId 
	Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId
	Where p.ProjectID = @parm1 and s.Status_PA <> 'I'
    Select Task, Sum(PGCnt) from #PGCap Where PGCnt > 0 Group by Task



 