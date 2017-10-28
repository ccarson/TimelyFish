
CREATE PROCEDURE XDDACHHeadTrail_Move_Recs
	@FileType	varchar( 1 ),
	@FormatID	varchar( 15 ),
	@HeadTrailID	varchar( 1 ),
	@OldHT		varchar( 1 ),
	@NewHT		varchar( 1 )
AS

	-- Remove any records at the "New" Code
	DELETE		
	FROM 		XDDACHHeadTrail
	WHERE		FileType = @FileType
			and FormatID = @FormatID
			and HeadTrailID = @HeadTrailID
			and Header_Trailer = @NewHT
			
	-- Change all "Old" codes to the "New" codes		
	UPDATE		XDDAchHeadTrail		
	SET		Header_Trailer = @NewHT
	WHERE		FileType = @FileType
			and FormatID = @FormatID
			and HeadTrailID = @HeadTrailID
			and Header_Trailer = @OldHT
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDACHHeadTrail_Move_Recs] TO [MSDSL]
    AS [dbo];

