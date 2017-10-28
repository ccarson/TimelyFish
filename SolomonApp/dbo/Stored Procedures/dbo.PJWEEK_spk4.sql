 create procedure PJWEEK_spk4 @parm1 varchar (6)   as
select * from PJWEEK
where   fiscalno  = @parm1
	order by we_date desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJWEEK_spk4] TO [MSDSL]
    AS [dbo];

