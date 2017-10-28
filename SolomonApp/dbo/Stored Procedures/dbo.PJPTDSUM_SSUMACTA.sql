
create procedure PJPTDSUM_SSUMACTA @parm1 varchar (16), @parm2 varchar (32), @parm3 varchar (16), @parm4 varchar (16) as
select sum(MX.act_amount), sum(MX.projcury_act_amount)
 from (select act_amount, ProjCury_act_amount
        from PJPTDSUM with (nolock)
        where project = @parm1
          and pjt_entity = @parm2
          and acct = @parm3
       union all
       select act_amount, ProjCury_act_amount
        from PJPTDSUM with (nolock)
        where project = @parm1
          and pjt_entity = @parm2
          and acct = @parm4) as MX


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_SSUMACTA] TO [MSDSL]
    AS [dbo];

