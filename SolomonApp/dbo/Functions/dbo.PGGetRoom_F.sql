
/****** Object:  User Defined Function dbo.PGGetRoom    Script Date: 12/20/2004 3:35:53 PM ******/
CREATE  FUNCTION dbo.PGGetRoom_F
(
      @PigGroupID VARCHAR(5)
)

RETURNS VARCHAR(200)
AS
BEGIN

	DECLARE CursorGroupRoom CURSOR 
	     FOR SELECT DISTINCT RoomNbr
	     From cftPigGroupRoom 
	     WHERE PigGroupID = @PigGroupID

OPEN CursorGroupRoom

DECLARE @Room VARCHAR(10), @RoomList VARCHAR(200), @LastRoom VARCHAR(10)
SET @Room = ''
SET @RoomList = ''
SET @LastRoom = ''

	   
FETCH NEXT FROM CursorGroupRoom INTO  @Room
--SET @SourceList=RTrim(@Source)
--SET @LastSource = @Source
While @@FETCH_STATUS=0
	BEGIN
	--	If @LastSource <> @Source 
	--	BEGIN
			SET @RoomList= @RoomList + ';' + RTrim(@Room)
	--	END
		FETCH NEXT FROM CursorGroupRoom 
		INTO  @Room
	END
CLOSE CursorGroupRoom
DEALLOCATE CursorGroupRoom
--RETURN 'test'
IF @RoomList <> ''
BEGIN
SET @RoomList = RIGHT(@RoomList,LEN(@RoomList)-1)
END
RETURN @RoomList

END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PGGetRoom_F] TO [MSDSL]
    AS [dbo];

