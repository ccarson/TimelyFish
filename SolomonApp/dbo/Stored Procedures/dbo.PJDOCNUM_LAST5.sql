
CREATE proc PJDOCNUM_LAST5 @parm1 varchar (10) as  
Begin

Declare
@tmp as varchar(10)

	set @tmp = (select lastused_5 from pjdocnum where ID = @parm1)
	set @tmp = (convert(bigint, @tmp) + 1)
	set @tmp = (right('0000000000' + @tmp, 10))
		
	update PJDOCNUM set LastUsed_5 = @tmp where ID = @parm1

	select lastused_5 from pjdocnum where ID = 5

	

End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJDOCNUM_LAST5] TO [MSDSL]
    AS [dbo];

