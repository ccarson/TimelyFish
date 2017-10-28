
CREATE VIEW [dbo].[PJvJobCostCury]
AS
SELECT     dbo.PJACTSUM.acct, dbo.PJACTSUM.projcury_amount_01 as amount_01, dbo.PJACTSUM.projcury_amount_02 as amount_02, dbo.PJACTSUM.projcury_amount_03 as amount_03, dbo.PJACTSUM.projcury_amount_04 as amount_04, 
                      dbo.PJACTSUM.projcury_amount_05 as amount_05, dbo.PJACTSUM.projcury_amount_06 as amount_06, dbo.PJACTSUM.projcury_amount_07 as amount_07, dbo.PJACTSUM.projcury_amount_08 as amount_08, dbo.PJACTSUM.projcury_amount_10 as amount_10, 
                      dbo.PJACTSUM.projcury_amount_09 as amount_09, dbo.PJACTSUM.projcury_amount_11 as amount_11, dbo.PJACTSUM.projcury_amount_12 as amount_12, dbo.PJACTSUM.projcury_amount_bf as amount_bf, dbo.PJACTSUM.fsyear_num, 
                      dbo.PJACTSUM.pjt_entity, dbo.PJACTSUM.project, dbo.PJREPCOL.column_nbr, dbo.PJREPCOL.report_code, dbo.PJREPCOL.desc1, 
                      dbo.PJPROJ.status_pa, dbo.PJPROJ.contract_type, dbo.PJPROJ.gl_subacct, dbo.PJPROJ.CpnyId, dbo.RptCompany.CpnyName, dbo.PJPROJ.ProjCuryID, dbo.Currncy.Decpl
FROM         dbo.PJACTSUM 
	INNER JOIN dbo.PJREPCOL ON dbo.PJACTSUM.acct = dbo.PJREPCOL.acct 
	LEFT OUTER JOIN dbo.PJPROJ ON dbo.PJACTSUM.project = dbo.PJPROJ.project 
	INNER JOIN dbo.RptCompany on dbo.pjproj.cpnyid = dbo.RptCompany.CpnyID
	INNER JOIN dbo.currncy on dbo.PJPROJ.ProjCuryID = dbo.currncy.CuryID


