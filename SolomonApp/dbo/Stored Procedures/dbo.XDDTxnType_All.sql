
CREATE PROCEDURE XDDTxnType_All
   @FormatID	varchar(15),
   @EntryClass	varchar(4)

AS
   SELECT       *
   FROM		XDDTxnType
   WHERE	FormatID = @FormatID
   		and EntryClass LIKE @EntryClass
   ORDER BY	FormatID, EntryClass
