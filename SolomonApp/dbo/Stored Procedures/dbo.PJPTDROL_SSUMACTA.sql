
create procedure PJPTDROL_SSUMACTA @parm1 varchar (16), @parm2 varchar (16), @parm3 varchar (16) as
select sum(MX.act_amount), sum(MX.ProjCury_act_amount)
 from (select act_amount, ProjCury_act_amount
        from PJPTDROL with (nolock)
        where project = @parm1
         and acct = @parm2
       union all
       select act_amount, ProjCury_act_amount
        from PJPTDROL with (nolock)
        where project = @parm1
          and acct = @parm3) as MX


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDROL_SSUMACTA] TO [MSDSL]
    AS [dbo];

