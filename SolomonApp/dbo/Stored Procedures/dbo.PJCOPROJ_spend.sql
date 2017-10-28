 create procedure PJCOPROJ_spend @parm1 varchar (16) , @parm2 varchar (16)  as
select * from PJCOPROJ
where
project = @parm1 and
change_order_num like @parm2
and status1 = 'P'
order by project, change_order_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOPROJ_spend] TO [MSDSL]
    AS [dbo];

