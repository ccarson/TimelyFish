 create procedure pjfiscal_spk0 @parm1 varchar (6)  as
select * from pjfiscal
where   fiscalno = @parm1
	order by fiscalno



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjfiscal_spk0] TO [MSDSL]
    AS [dbo];

