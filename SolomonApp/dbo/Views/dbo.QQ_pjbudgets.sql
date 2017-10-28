
CREATE VIEW [dbo].[QQ_pjbudgets]
AS
WITH [Project Budget] As ( 

  select  'Direct' [Budget Type],PJPTDSUM.project, PJPTDSUM.pjt_entity [Task], PJPTDSUM.acct [Acct Cat], PJACCT.acct_desc [Description], total_budget_units [Original Budget Units], 
       rate [Rate], total_budget_amount [Original Budget Amount], eac_units [EAC Units], eac_amount [EAC Amount], 
       fac_units [FAC Units], fac_amount [FAC Amount], PJPTDSUM.Noteid, PJPENT.pjt_entity_desc [Task Description],
          ' ' [Revision], ' ' [status], ' ' [update type], ' ' [Revision Type], ' ' [Revision Description], ' ' [Amount], ' ' [Units]
    from pjptdsum (nolock) inner join PJPROJ (nolock) on PJPROJ.project = pjptdsum.project AND PJPROJ.budget_type = 'D'
	inner join PJPENT (nolock) on PJPENT.pjt_entity = PJPTDSUM.pjt_entity AND PJPENT.project = PJPTDSUM.project
	inner join PJACCT (nolock) on PJACCT.acct = PJPTDSUM.acct

UNION

  select 'Revision' [Budget Type],PJREVHDR.project, PJREVCAT.pjt_entity [Task], PJREVCAT.Acct [Acct Cat], PJACCT.acct_desc [Description], '' [Original Budget Units], 
       PJREVCAT.ProjCury_rate [Rate], '' [Original Budget Amount], '' [EAC Units], '' [EAC Amount], 
       '' [FAC Units], '' [FAC Amount], PJREVHDR.Noteid, PJREVTSK.pjt_entity_desc [Task Description],
          PJREVHDR.Revid [Revision], PJREVHDR.status [status], PJREVHDR.update_type [update type], PJREVHDR.RevisionType [Revision Type], PJREVHDR.Revision_Desc [Revision Description], PJREVCAT.Amount [Amount], PJREVCAT.Units [Units]
                from PJREVHDR (nolock) 
				inner join PJPROJ (nolock) on PJPROJ.project = pjrevhdr.project AND PJPROJ.budget_type = 'R'
				inner join PJREVCAT (nolock) on PJREVHDR.project = PJREVCAT.project AND PJREVHDR.Revid = PJREVCAT.Revid
				inner join PJREVTSK (nolock) on PJREVTSK.pjt_entity = PJREVCAT.pjt_entity AND PJREVTSK.project = PJREVHDR.project AND PJREVTSK.revid = PJREVHDR.RevId
				inner join PJACCT (nolock) on PJACCT.acct = PJREVCAT.Acct
				
) SELECT * from [Project Budget]
