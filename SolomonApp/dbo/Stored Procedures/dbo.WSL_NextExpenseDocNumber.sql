
CREATE PROCEDURE WSL_NextExpenseDocNumber
 AS  
	Declare
	@tmp as varchar(10)

	set @tmp = (select lastused_5 from pjdocnum where ID = 5)
	set @tmp = (convert(bigint, @tmp) + 1)
	set @tmp = (right('0000000000' + @tmp, 10))
	while EXISTS (Select top 1 docnbr from PJEXPHDR where docnbr = @tmp)
		or EXISTS(Select top 1 docnbr from PJEXPAUD where docnbr = @tmp)
	BEGIN
		set @tmp = (convert(bigint, @tmp) + 1)
		set @tmp = (right('0000000000' + @tmp, 10))
	END
		
	update PJDOCNUM set LastUsed_5 = @tmp where ID = 5

	select lastused_5 from pjdocnum where ID = 5


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_NextExpenseDocNumber] TO [MSDSL]
    AS [dbo];

