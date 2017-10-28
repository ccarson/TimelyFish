 create procedure PJCOPROJ_sspv @parm1 varchar (16) , @parm2 varchar (16)  as
select * from PJCOPROJ
where
project like @parm1 and
change_order_num like @parm2
order by project, change_order_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOPROJ_sspv] TO [MSDSL]
    AS [dbo];

