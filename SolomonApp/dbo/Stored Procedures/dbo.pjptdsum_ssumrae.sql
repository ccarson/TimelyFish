 create procedure pjptdsum_ssumrae (@parm1 char(16), @parm2 char(32), @parm3 integer) as
        select  substring(pjt_entity, 1, @parm3),
                pjacct.sort_num,
                pjacct.acct,
                pjacct.acct_type,
                sum(pjptdsum.eac_amount),
                sum(pjptdsum.eac_units),
                sum(pjptdsum.total_budget_amount),
                sum(pjptdsum.total_budget_units),
                sum(pjptdsum.ProjCury_eac_amount),
                sum(pjptdsum.ProjCury_tot_bud_amt)
        from PJPTDSUM, PJACCT
        where PJPTDSUM.project =  @parm1 and
              PJPTDSUM.pjt_entity like ltrim(@parm2) and
              PJPTDSUM.acct = PJACCT.acct and
              (PJACCT.acct_type = 'RV' or
               PJACCT.acct_type = 'EX')
       group by substring(pjt_entity, 1, @parm3),
                pjacct.sort_num,
                pjacct.acct,
                pjacct.acct_type
       order by substring(pjt_entity, 1, @parm3),
                  PJACCT.sort_num, PJACCT.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjptdsum_ssumrae] TO [MSDSL]
    AS [dbo];

