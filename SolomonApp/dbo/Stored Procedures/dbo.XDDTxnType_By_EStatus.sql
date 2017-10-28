
CREATE PROCEDURE XDDTxnType_By_EStatus
   @FormatID	varchar(15),
   @EStatus	varchar(1)

AS
   SELECT       *
   FROM		XDDTxnType
   WHERE	FormatID = @FormatID
   		and EStatus LIKE @EStatus
   ORDER BY	FormatID, EStatus
