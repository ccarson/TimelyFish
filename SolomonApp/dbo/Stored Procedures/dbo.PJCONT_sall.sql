 create procedure PJCONT_sall @parm1 varchar (16)  as
select * from PJCONT
where contract like @parm1
order by contract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCONT_sall] TO [MSDSL]
    AS [dbo];

