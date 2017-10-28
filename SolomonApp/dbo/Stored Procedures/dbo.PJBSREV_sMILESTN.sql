 create procedure PJBSREV_sMILESTN  @parm1 varchar (16) ,  @parm2 varchar (6) , @parm3 smalldatetime  as
select * from PJBSREV
where    PJBSREV.Project = @parm1
and PJBSREV.Schednbr= @parm2
and PJBSREV.Rel_Status <> 'Y'
and PJBSREV.Post_Date <> ''
and PJBSREV.Amount <> 0
and PJBSREV.Post_Date_Est <= @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBSREV_sMILESTN] TO [MSDSL]
    AS [dbo];

