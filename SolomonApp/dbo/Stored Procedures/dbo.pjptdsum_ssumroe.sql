 create procedure pjptdsum_ssumroe (@parm1 char (16), @parm2 char (32), @parm3 char (2), @parm4 integer) as
        select  substring(pjt_entity, 1, @parm4),
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
              PJACCT.acct_type = @parm3
       group by substring(pjt_entity, 1, @parm4),
                pjacct.sort_num,
                pjacct.acct,
                pjacct.acct_type
       order by substring(pjt_entity, 1, @parm4),
                  PJACCT.sort_num, PJACCT.acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjptdsum_ssumroe] TO [MSDSL]
    AS [dbo];

