
CREATE proc PJDOCNUM_LASTLABHDR @parm1 varchar (10) as  
Begin

Declare
@tmp as varchar(10)

	set @tmp = (select LastUsed_labhdr from pjdocnum where ID = @parm1)
	set @tmp = (convert(bigint, @tmp) + 1)
	set @tmp = (right('0000000000' + @tmp, 10))
	
	update PJDOCNUM set LastUsed_labhdr = @tmp where ID = @parm1

	select LastUsed_labhdr from pjdocnum where ID = 13
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJDOCNUM_LASTLABHDR] TO [MSDSL]
    AS [dbo];

