
create proc XDDLBView_All
	@ViewID			varchar(10)
AS
	SELECT * FROM XDDLBView
	WHERE ViewID LIKE @ViewID
	ORDER BY ViewID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDLBView_All] TO [MSDSL]
    AS [dbo];

