
CREATE procedure XDDLBML_Format_Exists
	@FormatID		varchar( 15 )
AS
	Declare	@SP	varchar( 30 )
	
	SET	@SP = 'dbo.XDDLBML_' + @FormatID
	if exists (select * from sysobjects where id = object_id(@SP) and sysstat & 0xf = 4)
		SELECT convert(int, 1)
	else
		SELECT convert(int, 0)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDLBML_Format_Exists] TO [MSDSL]
    AS [dbo];

