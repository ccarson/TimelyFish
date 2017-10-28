CREATE PROCEDURE XDDAchHeadTrail_HT
	@FileType	varchar(1),
	@FormatID	varchar(15),
	@HeadTrailID	varchar(1),
	@Header_Trailer	varchar(1)
AS
  Select 	*
  FROM		XDDAchHeadTrail
  WHERE		FileType = @FileType
  		and FormatID = @FormatID
  		and HeadTrailID = @HeadTrailID
  		and Header_Trailer = @Header_Trailer
  ORDER by 	Header_Trailer, StartPos

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAchHeadTrail_HT] TO [MSDSL]
    AS [dbo];

