
/****** Object:  User Defined Function dbo.GetBarnCapacity    Script Date: 9/1/2005 11:19:04 AM ******/
CREATE   FUNCTION dbo.GetBarnCapacity
(
      @ContactID VARCHAR(6), @Barn VARCHAR(6), @PigGroupID VARCHAR(5)
)

RETURNS INTEGER
AS
BEGIN

	DECLARE CursorPhase CURSOR
	     FOR Select PigProdPhaseID 
		From cftPigGroup
		Where PigGroupID=@PigGroupID

OPEN CursorPhase

	DECLARE CursorFac CURSOR
	     FOR Select FacilityTypeID
		From cftSite st
		Where st.ContactID=@ContactID

OPEN CursorFac
--User for barn with no group or group no rooms
	DECLARE CursorBarn CURSOR 
	     FOR SELECT Sum(b.StdCap) 
		From cftBarn b 
		WHERE b.ContactID=@ContactID and b.BarnNbr = @Barn

OPEN CursorBarn

--Use for group with rooms not WTF NUR
	DECLARE CursorGroupR CURSOR 
	     FOR SELECT Sum(b.StdCap * m.BrnCapPrct) 
		From cftPigGroup p 
		Join cftPigGroupRoom r ON p.PigGroupID=r.PigGroupID 
		JOIN cftBarn b ON b.ContactID=p.SiteContactID and b.BarnNbr = p.BarnNbr
		Join cftRoom m on b.ContactId = m.ContactId and b.BarnNbr = m.BarnNbr and r.RoomNbr = m.RoomNbr
		Where p.PigGroupID=@PigGroupID

OPEN CursorGroupR

--User for group with rooms NUR phase WTF
	DECLARE CursorGroupRN CURSOR 
	     FOR SELECT Sum(b.StdCap * m.BrnCapPrct * b.CapMultiplier) 
		From cftPigGroup p 
		Join cftPigGroupRoom r ON p.PigGroupID=r.PigGroupID 
		JOIN cftBarn b ON b.ContactID=p.SiteContactID and b.BarnNbr = p.BarnNbr
		Join cftRoom m on b.ContactId = m.ContactId and b.BarnNbr = m.BarnNbr and r.RoomNbr = m.RoomNbr
		Where p.PigGroupID=@PigGroupID
OPEN CursorGroupRN

--User for group no rooms NUR phase WTF
	DECLARE CursorGroupN CURSOR 
	     FOR SELECT DISTINCT Sum(b.MaxCap * b.CapMultiplier)
	     FROM cftPigGroup p
	     JOIN cftBarn b ON p.BarnNbr = b.BarnNbr and p.SiteContactId = b.ContactId
	     WHERE p.PigGroupID = @PigGroupID

OPEN CursorGroupN

DECLARE @FacType AS VARCHAR(3)
DECLARE @Phase As VARCHAR(3)
DECLARE @BarnCap INTEGER
DECLARE @RoomCap INTEGER
DECLARE @RoomCapRN INTEGER
DECLARE @BarnGroupN INTEGER
DECLARE @Send INTEGER
SET @Send = 0
SET @BarnCap = 0
SET @RoomCap = 0
SET @RoomCapRN = 0
SET @BarnGroupN = 0
FETCH NEXT FROM CursorFac INTO  @FacType
FETCH NEXT FROM CursorPhase INTO  @Phase
FETCH NEXT FROM CursorBarn INTO  @BarnCap
FETCH NEXT FROM CursorGroupR INTO  @RoomCap
FETCH NEXT FROM CursorGroupRN INTO  @RoomCapRN
FETCH NEXT FROM CursorGroupN INTO  @BarnGroupN


If ISNULL(@PigGroupID,0)=0
	BEGIN
		SET @SEND = @BarnCap
 	END
ELSE
	IF ISNULL(@RoomCap,0)=0
		BEGIN
			--NO Rooms with a Group
			If @Phase='NUR' AND @FacType='005'
				BEGIN
					--No Rooms NUR WTF
					SET @SEND = @BarnGroupN
				END
			ELSE
				BEGIN
					SET @Send = @BarnCap
				END
		END
	Else
		BEGIN	
			IF @Phase='NUR' AND @FacType='005'
				--Rooms with NUR WTF
				BEGIN
					SET @Send = @RoomCapRN
				END
			ELSE
				BEGIN
					SET @Send = @RoomCap
				END
		END

CLOSE CursorPhase
DEALLOCATE CursorPhase
CLOSE CursorFac
DEALLOCATE CursorFac
CLOSE CursorBarn
DEALLOCATE CursorBarn
CLOSE CursorGroupR
DEALLOCATE CursorGroupR
CLOSE CursorGroupRN
DEALLOCATE CursorGroupRN
CLOSE CursorGroupN
DEALLOCATE CursorGroupN
--RETURN 'test'

RETURN @Send

END


