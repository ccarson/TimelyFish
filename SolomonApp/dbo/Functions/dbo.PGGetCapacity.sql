
/****** Object:  User Defined Function dbo.PGGetCapacity    Script Date: 12/2/2005 7:38:43 AM ******/

/****** Object:  User Defined Function dbo.PGGetCapacity    Script Date: 7/6/2005 6:40:08 AM ******/

/****** Object:  User Defined Function dbo.PGGetCapacity    Script Date: 7/5/2005 1:57:04 PM ******/

CREATE FUNCTION dbo.PGGetCapacity
(
      @PigGroupID VARCHAR(5)
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
		JOIN cftPigGroup pg ON pg.SiteContactID=st.ContactID
		Where pg.PigGroupID=@PigGroupID

OPEN CursorFac


	DECLARE CursorGroupR CURSOR 
	     FOR SELECT Sum(b.StdCap * m.BrnCapPrct) 
		From cftPigGroup p 
		Join cftPigGroupRoom r ON p.PigGroupID=r.PigGroupID 
		JOIN cftBarn b ON b.ContactID=p.SiteContactID and b.BarnNbr = p.BarnNbr
		Join cftRoom m on b.ContactId = m.ContactId and b.BarnNbr = m.BarnNbr and r.RoomNbr = m.RoomNbr
		--Where b.StatusTypeID='1' AND p.PigGroupID=@PigGroupID
		Where p.PigGroupID=@PigGroupID

OPEN CursorGroupR

	DECLARE CursorGroupRN CURSOR 
	     FOR SELECT Sum(b.StdCap * m.BrnCapPrct * b.CapMultiplier) 
		From cftPigGroup p 
		Join cftPigGroupRoom r ON p.PigGroupID=r.PigGroupID 
		JOIN cftBarn b ON b.ContactID=p.SiteContactID and b.BarnNbr = p.BarnNbr
		Join cftRoom m on b.ContactId = m.ContactId and b.BarnNbr = m.BarnNbr and r.RoomNbr = m.RoomNbr
		--Where b.StatusTypeID='1' AND p.PigGroupID=@PigGroupID
		Where p.PigGroupID=@PigGroupID

OPEN CursorGroupRN

	DECLARE CursorGroup CURSOR 
	     FOR SELECT DISTINCT b.MaxCap
	     FROM cftPigGroup p
	     JOIN cftBarn b ON p.BarnNbr = b.BarnNbr and p.SiteContactId = b.ContactId
	     WHERE p.PigGroupID = @PigGroupID

OPEN CursorGroup

	DECLARE CursorGroupN CURSOR 
	     FOR SELECT DISTINCT Sum(b.MaxCap * b.CapMultiplier)
	     FROM cftPigGroup p
	     JOIN cftBarn b ON p.BarnNbr = b.BarnNbr and p.SiteContactId = b.ContactId
	     WHERE p.PigGroupID = @PigGroupID

OPEN CursorGroupN

DECLARE @FacType AS VARCHAR(3)
DECLARE @Phase As VARCHAR(3)
DECLARE @Room INTEGER
DECLARE @Total INTEGER
DECLARE @RoomN INTEGER
DECLARE @TotalN INTEGER
DECLARE @Send INTEGER
SET @Room = 0
SET @Total = 0
SET @RoomN = 0
SET @TotalN = 0
SET @Send = 0

FETCH NEXT FROM CursorGroupR INTO  @Room
FETCH NEXT FROM CursorGroup INTO  @Total
FETCH NEXT FROM CursorGroupRN INTO  @RoomN
FETCH NEXT FROM CursorGroupN INTO  @TotalN
FETCH NEXT FROM CursorPhase INTO  @Phase
FETCH NEXT FROM CursorFac INTO  @FacType

IF ISNULL(@Room,0)=0
	BEGIN
		--If @Phase='NUR' AND @FacType='005'
		--	BEGIN
		--		SET @SEND = @TotalN
		--	END
		--ELSE
			--BEGIN
				SET @Send = @Total
			--END
	END
Else
	BEGIN	
		--IF @Phase='NUR' AND @FacType='005'
		--	BEGIN
		--		SET @Send = @RoomN
		--	END
		--ELSE
		--	BEGIN
				SET @Send = @Room
		--	END
	END

CLOSE CursorGroupR
DEALLOCATE CursorGroupR
CLOSE CursorGroup
DEALLOCATE CursorGroup
CLOSE CursorGroupRN
DEALLOCATE CursorGroupRN
CLOSE CursorGroupN
DEALLOCATE CursorGroupN
CLOSE CursorPhase
DEALLOCATE CursorPhase
--RETURN 'test'

RETURN @Send

END








