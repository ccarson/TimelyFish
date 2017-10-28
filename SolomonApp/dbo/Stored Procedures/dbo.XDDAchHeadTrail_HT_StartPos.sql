CREATE PROCEDURE XDDAchHeadTrail_HT_StartPos
	@FileType	varchar(1),
	@FormatID	varchar(15),
	@HeadTrailID	varchar(1),
	@Header_Trailer	varchar(1),
	@StartPos	varchar(2)
AS
  Select 	*
  FROM		XDDAchHeadTrail
  WHERE 	FileType LIKE @FileType
  		and FormatID LIKE @FormatID
  		and HeadTrailID LIKE @HeadTrailID
  		and Header_Trailer LIKE @Header_Trailer
  		and StartPos LIKE @StartPos
  ORDER by 	FileType, FormatID, HeadTrailID, Header_Trailer, StartPos

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAchHeadTrail_HT_StartPos] TO [MSDSL]
    AS [dbo];

