 create procedure PJCOPROJ_spk0 @parm1 varchar (16)  as
select * from PJCOPROJ
where project = @parm1
order by PJCOPROJ.project, PJCOPROJ.change_order_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOPROJ_spk0] TO [MSDSL]
    AS [dbo];

