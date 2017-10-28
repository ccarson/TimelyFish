 create procedure PJCOPROJ_spk1 @parm1 varchar (16) , @parm2 varchar (16)  as
select * from PJCOPROJ
where project = @parm1 and
change_order_num = @parm2
order by PJCOPROJ.project, PJCOPROJ.change_order_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOPROJ_spk1] TO [MSDSL]
    AS [dbo];

