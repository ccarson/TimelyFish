 create procedure PJBILL_sALL @parm1 varchar (16)  as
select * from PJBILL
where project like @parm1
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_sALL] TO [MSDSL]
    AS [dbo];

