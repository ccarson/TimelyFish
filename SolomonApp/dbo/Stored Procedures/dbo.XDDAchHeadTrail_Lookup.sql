CREATE PROCEDURE XDDAchHeadTrail_Lookup
	@FileType	varchar(1),
	@FormatID	varchar(15),
	@HeadTrailID	varchar(1)
AS

  Select 	count(*)
  FROM		XDDAchHeadTrail (nolock)
  WHERE		FileType = @FileType
  		and FormatID = @FormatID
  		and HeadTrailID = @HeadTrailID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAchHeadTrail_Lookup] TO [MSDSL]
    AS [dbo];

