
/****** Object:  User Defined Function dbo.PGGetSource2    Script Date: 12/3/2004 1:09:09 PM ******/

/****** Object:  User Defined Function dbo.PGGetSource2    Script Date: 12/3/2004 1:07:18 PM ******/

/****** Object:  User Defined Function dbo.PGGetSource    Script Date: 12/3/2004 12:09:52 PM ******/
CREATE         FUNCTION dbo.PGGetSource2
(
      @PigGroupID VARCHAR(5)
)

RETURNS VARCHAR(200)
AS
BEGIN

	DECLARE CursorGroupSrc CURSOR 
	     FOR SELECT DISTINCT pj.project_desc AS Source
	     FROM cftPGInvTran tr
		LEFT JOIN cftPigGroup pg ON tr.SourcePigGroupID=pg.PigGroupID
		LEFT JOIN PJPROJ pj ON pg.ProjectID=pj.Project
		Where tr.PigGroupID = @PigGroupID AND tr.TranTypeID='MI'
		Group by pj.project_desc

OPEN CursorGroupSrc

DECLARE @Source VARCHAR(30), @SourceList VARCHAR(200), @LastSource VARCHAR(30)
SET @Source = ''
SET @SourceList = ''
SET @LastSource = ''

	   
FETCH NEXT FROM CursorGroupSrc INTO  @Source

While @@FETCH_STATUS=0
	BEGIN
		SET @SourceList= @SourceList + ';' + RTrim(@Source)
		FETCH NEXT FROM CursorGroupSrc 
		INTO  @Source
	END
CLOSE CursorGroupSrc
DEALLOCATE CursorGroupSrc

/**	DECLARE CursorGroupSrc2 CURSOR 
	     FOR SELECT DISTINCT pj.project_desc AS Source
	     FROM cftPGInvTran tr
		JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
		LEFT JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
		LEFT JOIN PJPROJ pj ON PM.SourceProject=pj.Project
		Where tr.PigGroupID = @PigGroupID AND (tr.TranTypeID='TI' or tr.TranTypeID='PP')
		Group by pj.project_desc

 OPEN CursorGroupSrc2

FETCH NEXT FROM CursorGroupSrc2 INTO  @Source

While @@FETCH_STATUS=0
	BEGIN
		SET @SourceList= @SourceList + ';' + RTrim(@Source)
		FETCH NEXT FROM CursorGroupSrc2 
		INTO  @Source
	END
CLOSE CursorGroupSrc2
DEALLOCATE CursorGroupSrc2 **/

--RETURN 'test'
IF @SourceList <> ''
BEGIN
SET @SourceList = RIGHT(@SourceList,LEN(@SourceList)-1)
END
RETURN @SourceList

END




GO
GRANT CONTROL
    ON OBJECT::[dbo].[PGGetSource2] TO [MSDSL]
    AS [dbo];

