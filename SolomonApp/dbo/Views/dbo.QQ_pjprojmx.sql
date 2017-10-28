
CREATE VIEW [dbo].[QQ_pjprojmx]
AS
SELECT     PJPROJMX.Project, PJPROJMX.pjt_entity [Task], PJPROJMX.noteid [noteid], PJPROJMX.ACCT [Account Category], PJPROJMX.mx_id03 [Additonal Acct], PJPROJMX.ProjCury_Max_amount [Max Amount],
			CASE WHEN LOWER(RTRIM(PJPROJMX.pjt_entity)) = 'na' THEN sum(PJPTDROL.ProjCury_act_amount) 
			ELSE
				sum(PJPTDSUM.ProjCury_act_amount)
			END [Total]
			 FROM PJPROJMX (nolock)
			 left outer join PJPTDROL (nolock) 
			 on PJPROJMX.project = PJPTDROL.Project And (PJPROJMX.acct = PJPTDROL.acct or PJPROJMX.mx_id03 = PJPTDROL.acct)
			 left outer join PJPTDSUM (nolock) 
			 on PJPROJMX.project = PJPTDSUM.Project And	PJPROJMX.pjt_entity = PJPTDSUM.pjt_entity And (PJPROJMX.acct = PJPTDSUM.acct or PJPROJMX.mx_id03 = PJPTDSUM.acct)
			Group by PJPROJMX.Project, PJPROJMX.pjt_entity, PJPROJMX.noteid, PJPROJMX.ACCT, PJPROJMX.mx_id03, PJPROJMX.ProjCury_Max_amount
