

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 11/17/2010
-- Description:	Populates table in development.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SOW_SELECTED_GILT_GL_INSERT]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_SOW_SELECTED_GILT_GL

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_SOW_SELECTED_GILT_GL
(	Sub
	,PerPost
	,Id
	,Acct
	,Descr
	,TranDesc
	,Amt)

	Select 
	
	GL.Sub, 
	GL.perpost,
	GL.id,
	GL.acct,
	AC.descr,
	GL.TranDesc,
	Case when right(rtrim(GL.Sub),4) in (6525,2280) and GL.acct not in (46330,46340,46350)
	then Sum(GL.DrAmt - GL.CrAmt)*(8854/(22256*1.0)) else Sum(GL.DrAmt - GL.CrAmt) end AS 'Amt'
	
	from (Select Distinct SiteID from  dbo.cft_SOW_SELECTED_GILT_FLOW) GF
	
	left join [$(SolomonApp)].dbo.GLTran GL (nolock)
	on GF.SiteID = right(rtrim(Gl.Sub),4)  
	
	left join [$(SolomonApp)].dbo.Account AC (nolock)
	on GL.Acct=AC.Acct
	
	where 
	GL.perpost >= '200901'
	and GL.rlsed='1'
	and AC.accttype in ('3I','3E')
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and (GL.Acct <> 46750 
	or (GL.Acct = 46750 and GL.Id <> 'NORUSA'))))
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and (GL.Acct not in (46700,46360) 
	or (GL.Acct in (46700,46360) and GL.Id = 'PORSTOS'))))
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and (GL.Acct not in (70303,47300) 
	or (GL.Acct in (70303,47300) and GL.Id not in ('NORSAF','PIC')))))
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and (GL.Acct <> 60100
	or (GL.Acct = 60100 and GL.trandesc not like '%Tag%'))))
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and GL.Acct <> 76350))
	and (right(rtrim(GL.sub),4) not in (8102,8101)
	or (right(rtrim(GL.sub),4) in (8102,8101) and GL.Acct <> 45500)
	or (right(rtrim(GL.sub),4) in (8102,8101) and GL.Acct = 45500 
	and GL.TranDesc not like '%21%'))
	and (right(rtrim(GL.sub),4) not in (8102,8101)
	or (right(rtrim(GL.sub),4) in (8102,8101) and GL.Acct <> 45500)
	or (right(rtrim(GL.sub),4) in (8102,8101) and GL.Acct = 45500 
	and GL.TranDesc not like '%31%'))
	and (right(rtrim(GL.sub),4) not in (8102,8101)
	or (right(rtrim(GL.sub),4) in (8102,8101) and GL.Acct <> 45500)
	or (right(rtrim(GL.sub),4) in (8102,8101) and GL.Acct = 45500 
	and GL.TranDesc not like '%GEST%'))
	and GF.SiteID not in (0001,0002,0003)
	and GL.Acct not in (41100,41150,41200,41250,40100,40120,40130,40140,40150,40155,40160,40170,40180,40200,40190,40110,41310,41300,41900,40900,81600)
	group by
	GL.sub,
	GL.perpost,
	GL.id,
	GL.acct,
	AC.descr,
	GL.trandesc
	
	union
	
	Select 
	
	Case when right(rtrim(GL.Sub),4) = 8050 then 20420001 else '' end as Sub, 
	GL.perpost,
	GL.id,
	GL.acct,
	AC.descr,
	GL.TranDesc,
	Sum(GL.DrAmt - GL.CrAmt) AS 'Amt'
	
	from [$(SolomonApp)].dbo.GLTran GL (nolock)
	
	left join [$(SolomonApp)].dbo.Account AC (nolock)
	on GL.Acct=AC.Acct
	
	where 
	GL.perpost >= '200901'
	and GL.rlsed='1'
	and AC.accttype in ('3I','3E')
	and right(rtrim(GL.sub),4) = 8050
	and ((GL.Acct in (46700,46360) and GL.Id <> 'PORSTOS')
	or (GL.Acct in (70303,47300) and GL.Id in ('NORSAF','PIC'))
	or (GL.Acct = 60100 and GL.trandesc like '%Tag%')
	or GL.Acct = 76350)
	
	group by
	GL.sub,
	GL.perpost,
	GL.id,
	GL.acct,
	AC.descr,
	GL.trandesc
	
	union
	
	Select 
	
	Case when right(rtrim(GL.Sub),4) = 8050 then 20420002 else '' end as Sub, 
	GL.perpost,
	GL.id,
	GL.acct,
	AC.descr,
	GL.TranDesc,
	Sum(GL.DrAmt - GL.CrAmt) AS 'Amt'
	
	from [$(SolomonApp)].dbo.GLTran GL (nolock)
	
	left join [$(SolomonApp)].dbo.Account AC (nolock)
	on GL.Acct=AC.Acct
	
	where 
	GL.perpost >= '200901'
	and GL.rlsed='1'
	and AC.accttype in ('3I','3E')
	and right(rtrim(GL.sub),4) = 8050
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and (GL.Acct <> 46750 
	or (GL.Acct = 46750 and GL.Id <> 'NORUSA'))))
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and (GL.Acct not in (46700,46360) 
	or (GL.Acct in (46700,46360) and GL.Id = 'PORSTOS'))))
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and (GL.Acct not in (70303,47300) 
	or (GL.Acct in (70303,47300) and GL.Id not in ('NORSAF','PIC')))))
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and (GL.Acct <> 60100
	or (GL.Acct = 60100 and GL.trandesc not like '%Tag%'))))
	and (right(rtrim(GL.sub),4) <> 8050
	or (right(rtrim(GL.sub),4) = 8050 and GL.Acct <> 76350))
	and GL.Acct not in (41100,41150,41200,41250,40100,40120,40130,40140,40150,40155,40160,40170,40180,40200,40190,40110,41310,41300,41900,40900,81600)
	
	group by
	GL.sub,
	GL.perpost,
	GL.id,
	GL.acct,
	AC.descr,
	GL.trandesc
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_SELECTED_GILT_GL_INSERT] TO [db_sp_exec]
    AS [dbo];

