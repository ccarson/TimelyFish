
CREATE PROCEDURE WSL_NextTimecardNumber
 AS  
	Declare
	@tmp as varchar(10)

	set @tmp = (select LastUsed_labhdr from pjdocnum where ID = 13)
	set @tmp = (convert(bigint, @tmp) + 1)
	set @tmp = (right('0000000000' + @tmp, 10))
	while EXISTS (Select top 1 docnbr from PJLABHDR where docnbr = @tmp)
	    or EXISTS(Select top 1 docnbr from PJLABAUD where docnbr = @tmp)
	BEGIN
		set @tmp = (convert(bigint, @tmp) + 1)
		set @tmp = (right('0000000000' + @tmp, 10))
	END
		
	update PJDOCNUM set LastUsed_labhdr = @tmp where ID = 13
	select LastUsed_labhdr from pjdocnum where ID = 13


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_NextTimecardNumber] TO [MSDSL]
    AS [dbo];

