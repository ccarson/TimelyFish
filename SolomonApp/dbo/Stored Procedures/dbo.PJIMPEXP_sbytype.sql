 create procedure PJIMPEXP_sbytype @parm1 varchar (2) , @parm2 varchar (8)  as
select * from PJIMPEXP
where
	map_type = @parm1 and
	map_id like @parm2
	order by map_type, map_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJIMPEXP_sbytype] TO [MSDSL]
    AS [dbo];

