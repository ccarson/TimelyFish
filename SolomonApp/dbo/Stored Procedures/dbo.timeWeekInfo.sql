
Create Procedure timeWeekInfo
	@parm1 varchar(10)    --Date in string form
AS
	select * from PJWEEK
	where we_date = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[timeWeekInfo] TO [MSDSL]
    AS [dbo];

