CREATE PROCEDURE XDDDepositor_EntryClass_PN
	@VendCust	varchar(1),
	@FormatID	varchar(15),
	@parm1 		varchar(4),
	@parm2 		varchar(1)

AS
  	Select 		*
  	from 		XDDDepositor
  	where 		VendCust = @VendCust
  			and FormatID = @FormatID
  			and EntryClass LIKE @parm1
  			and PNStatus LIKE @parm2
  	ORDER by 	EntryClass, VendID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_EntryClass_PN] TO [MSDSL]
    AS [dbo];

