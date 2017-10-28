CREATE FUNCTION dbo.PGGetSource
(
      @PigGroupID VARCHAR(5)
)

RETURNS VARCHAR(200)
AS
BEGIN

	DECLARE CursorGroupSrc CURSOR 
	     FOR SELECT DISTINCT Source
	     FROM dbo.cfv_GroupSource
	     WHERE PigGroupID = @PigGroupID

OPEN CursorGroupSrc

DECLARE @Source VARCHAR(30), @SourceList VARCHAR(200), @LastSource VARCHAR(30)
SET @Source = ''
SET @SourceList = ''
SET @LastSource = ''

	   
FETCH NEXT FROM CursorGroupSrc INTO  @Source
--SET @SourceList=RTrim(@Source)
--SET @LastSource = @Source
While @@FETCH_STATUS=0
	BEGIN
	--	If @LastSource <> @Source 
	--	BEGIN
			SET @SourceList= @SourceList + ';' + RTrim(@Source)
	--	END
		FETCH NEXT FROM CursorGroupSrc 
		INTO  @Source
	END
CLOSE CursorGroupSrc
DEALLOCATE CursorGroupSrc
--RETURN 'test'
IF @SourceList <> ''
BEGIN
SET @SourceList = RIGHT(@SourceList,LEN(@SourceList)-1)
END
RETURN @SourceList

END
