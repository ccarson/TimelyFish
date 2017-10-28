CREATE PROCEDURE XDDDepositor_EntryClass_Count
	@VendCust	varchar( 1 ),
	@FormatID	varchar( 15 ),
	@EntryClass	varchar( 4 )

AS
  	Select 		count(*)
  	from 		XDDDepositor (nolock)
  	where 		VendCust = @VendCust
  			and FormatID = @FormatID
  			and EntryClass LIKE @EntryClass

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_EntryClass_Count] TO [MSDSL]
    AS [dbo];

