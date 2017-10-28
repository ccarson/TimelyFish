/****** Object:  Stored Procedure dbo.CF522p_GenPGListSCN    Script Date: 6/27/2005 9:49:50 AM ******/

/****** Object:  Stored Procedure dbo.CF522p_GenPGListSC    Script Date: 2/4/2005 9:12:57 AM ******/
CREATE       Procedure CF522p_GenPGListSCN @parm1 varchar (16) as 
    Create Table #PGCap (PGCnt Int, Task Char (32))
    Insert Into #PGCap (Task, PGCnt)
	Select p.TaskId, dbo.PgGetCapacity(p.PigGroupID)
	From cftPigGroup p
	Where p.ProjectID = @parm1 and p.CostFlag='1'
--    Select p.TaskId, Convert(Int, Case When r.RoomNbr is Null Then 
--	Coalesce((Select Sum(MaxCap) from cftBarn Where BarnNbr = p.BarnNbr and ContactId = p.SiteContactId), 0) 
--	Else Coalesce((Select Sum(b.MaxCap * m.BrnCapPrct) From cftBarn b Join cftRoom m on b.ContactId = m.ContactId 
--	and b.BarnNbr = m.BarnNbr Where b.ContactId = p.SiteContactId and b.BarnNbr = p.BarnNbr 
--	and m.RoomNbr = r.RoomNbr and b.StatusTypeID='1'), 0) End)
--	from cftPigGroup p 
--	Left Join cftPigGroupRoom r on p.PigGroupId = r.PigGroupId
--	Where p.ProjectID = @parm1 and p.CostFlag='1'
    Select Task, Sum(PGCnt)from #PGCap Where PGCnt > 0 Group by Task 




 