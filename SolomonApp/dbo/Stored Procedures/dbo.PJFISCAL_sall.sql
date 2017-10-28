 create procedure PJFISCAL_sall @parm1 varchar (6)  as
select * from PJFISCAL
where   fiscalno like @parm1
	order by fiscalno



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJFISCAL_sall] TO [MSDSL]
    AS [dbo];

