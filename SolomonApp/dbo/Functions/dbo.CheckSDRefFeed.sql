
/****** Object:  User Defined Function dbo.CheckSDRefFeed    Script Date: 9/26/2005 8:36:40 AM ******/

/****** Object:  User Defined Function dbo.CheckSDRefFeed    Script Date: 9/26/2005 8:35:10 AM ******/

/****** Object:  User Defined Function dbo.CheckSDRefFeed    Script Date: 9/26/2005 8:34:16 AM ******/


CREATE     FUNCTION dbo.CheckSDRefFeed
(
)

RETURNS VARCHAR(200)
AS
BEGIN

	DECLARE CursorGroupSrc CURSOR 
	        FOR select SDRefNo
		from cftSafeFeed Order by SDRefNo Asc

OPEN CursorGroupSrc

DECLARE @RefNo VARCHAR(6), @PrevSDNo VARCHAR(6), @BadRefs VARCHAR(200)
SET @RefNo = ''
SET @PrevSDNo = ''
	   
FETCH NEXT FROM CursorGroupSrc INTO  @RefNo
SET @PrevSDNo = @RefNo
--RETURN 'test'

While @@FETCH_STATUS=0
	BEGIN
		FETCH NEXT FROM CursorGroupSrc 
		INTO  @RefNo
		IF @RefNo <> @PrevSDNo +1
		BEGIN
			SET @BadRefs= @BadRefs + ';' + RTrim(@RefNo)
		END
		SET @PrevSDNo = @RefNo
	END
CLOSE CursorGroupSrc
DEALLOCATE CursorGroupSrc

--RETURN 'test'

IF @BadRefs <> ''
BEGIN
SET @BadRefs = RIGHT(@BadRefs,LEN(@BadRefs)-1)
END


RETURN @BadRefs
--RETURN 'test'

END






GO
GRANT CONTROL
    ON OBJECT::[dbo].[CheckSDRefFeed] TO [MSDSL]
    AS [dbo];

