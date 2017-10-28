
CREATE VIEW [dbo].PJvDirectBudget
AS
SELECT     dbo.PJPTDSUM.acct, dbo.PJACCT.acct_desc, dbo.PJACCT.acct_status, dbo.PJACCT.acct_type, dbo.PJACCT.sort_num, dbo.PJPTDSUM.act_amount, 
                      dbo.PJPTDSUM.act_units, dbo.PJPTDSUM.com_amount, dbo.PJPTDSUM.com_units, dbo.PJPTDSUM.crtd_datetime, dbo.PJPTDSUM.crtd_prog, 
                      dbo.PJPTDSUM.crtd_user, dbo.PJPTDSUM.eac_amount, dbo.PJPTDSUM.eac_units, dbo.PJPTDSUM.fac_amount, dbo.PJPTDSUM.fac_units, 
                      dbo.PJPTDSUM.lupd_datetime, dbo.PJPTDSUM.lupd_user, dbo.PJPTDSUM.lupd_prog, dbo.PJPTDSUM.noteid, dbo.PJPTDSUM.project, 
                      dbo.PJPTDSUM.total_budget_amount, dbo.PJPTDSUM.total_budget_units, dbo.PJPTDSUM.user1, dbo.PJPTDSUM.user2, dbo.PJPTDSUM.user3, 
                      dbo.PJPTDSUM.user4, dbo.PJPTDSUM.data1, dbo.PJPTDSUM.data2, dbo.PJPTDSUM.data3, dbo.PJPTDSUM.data4, dbo.PJPTDSUM.data5, 
                      dbo.PJPTDSUM.pjt_entity, dbo.PJPTDSUM.rate, dbo.PJPTDSUM.tstamp,
                      dbo.PJPTDSUM.ProjCury_act_amount, dbo.PJPTDSUM.ProjCury_com_amount, dbo.PJPTDSUM.ProjCury_eac_amount, dbo.PJPTDSUM.ProjCury_fac_amount,
                      dbo.PJPTDSUM.ProjCury_tot_bud_amt
FROM         dbo.PJACCT INNER JOIN
                      dbo.PJPTDSUM ON dbo.PJACCT.acct = dbo.PJPTDSUM.acct
