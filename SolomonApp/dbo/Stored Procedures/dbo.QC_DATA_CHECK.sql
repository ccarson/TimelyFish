﻿ Create Procedure QC_DATA_CHECK
	@BATNBR		VARCHAR(10),
	@CPNYID		VARCHAR(10)
AS
	SET NOCOUNT ON

	DECLARE	@FISCYR		CHAR(4),
		@PERNBR 	CHAR(2)

	SELECT 	@FISCYR = LEFT(CURRPERNBR, 4),
		@PERNBR = RIGHT(CURRPERNBR, 2)
		FROM	INSETUP (NoLock)

	Select	InvtID, LotSerTrack, SerAssign, ValMthd
		From	Inventory (NoLock)
		Where	InvtID In (SELECT DISTINCT INVTID FROM INTRAN (NoLock) WHERE BATNBR = @BATNBR AND CPNYID = @CPNYID)

	PRINT	'BATCH'
	SELECT	BATNBR, CPNYID, CRTOT, CTRLTOT, DRTOT,
		EDITSCRNNBR, JRNLTYPE, MODULE, RLSED, STATUS
		FROM	BATCH (NoLock)
		WHERE	BATNBR = @BATNBR
			AND MODULE IN ('IN', 'PO')
			AND CPNYID = @CPNYID

	PRINT	'GL TRANS'
	SELECT	ACCT, SUB, TRANDESC, CRAMT, DRAMT,
		JRNLTYPE, QTY, TRANTYPE
		FROM	GLTRAN (NoLock)
		WHERE	BATNBR = @BATNBR
			AND MODULE = 'IN'
			AND CPNYID = @CPNYID

	IF EXISTS(SELECT * FROM INTRAN (NoLock) WHERE TRANTYPE = 'AS' AND BATNBR = @BATNBR AND CPNYID = @CPNYID)
	BEGIN
		PRINT 	'ASSEMBLY DOC'
		SELECT	BATNBR, CPNYID, KITCNTR, KITID, PERPOST,
			REFNBR, RLSED, SITEID, SPECIFICCOSTID, TRANDATE,
			WHSELOC
			FROM	ASSYDOC (NoLock)
			WHERE 	BATNBR = @BATNBR
				AND CPNYID = @CPNYID
	END

	IF EXISTS(SELECT * FROM TRNSFRDOC WHERE BATNBR = @BATNBR OR S4FUTURE11 = @BATNBR AND CPNYID = @CPNYID)
	BEGIN
		PRINT	'TRANSFER DOC'
		SELECT	BATNBR, S4FUTURE11 AS TOBATNBR, TRNSFRDOCNBR,
		STATUS	= CASE	WHEN STATUS = 'P' THEN 'PENDING'
				WHEN STATUS = 'R' THEN 'RECEIVED'
				WHEN STATUS = 'I' THEN 'IN TRANSIT'
				ELSE STATUS
			END, TRANSFERTYPE AS STEPS,
			REFNBR, SITEID, TOSITEID, SOURCE
			FROM TRNSFRDOC (NoLock)
			WHERE 	(BATNBR = @BATNBR
				OR S4FUTURE11 = @BATNBR)
				AND CPNYID = @CPNYID
	END

	PRINT 	'ITEMSITE'
	SELECT 	INVTID, SITEID, CPNYID, STKITEM, STDCOST,
		DIRSTDCST, AVGCOST, LASTCOST, TOTCOST, QTYONHAND,
		QTYINTRANSIT, QTYSHIPNOTINV, QTYAVAIL
		FROM 	ITEMSITE (NoLock)
		WHERE 	INVTID IN (SELECT DISTINCT INVTID FROM INTRAN WHERE BATNBR = @BATNBR AND CPNYID = @CPNYID)
			AND CPNYID = @CPNYID

	PRINT 'LOCATION'
	SELECT	INVTID, SITEID, WHSELOC, COUNTSTATUS, QTYONHAND, QTYSHIPNOTINV
		FROM	LOCATION (NoLock)
		WHERE 	INVTID IN (SELECT DISTINCT INVTID FROM INTRAN WHERE BATNBR = @BATNBR)

	IF EXISTS(SELECT DISTINCT INTRAN.INVTID
			FROM	INVENTORY  (NoLock) JOIN INTRAN  (NoLock)
			ON 	INVENTORY.INVTID = INTRAN.INVTID
			WHERE 	INTRAN.BATNBR = @BATNBR
				AND LOTSERTRACK IN ('LI', 'SI')
				AND INTRAN.CPNYID = @CPNYID)
	BEGIN
		PRINT 'LOTSERMST'
		SELECT	INVTID, SITEID, WHSELOC, LOTSERNBR, ORIGQTY,
			QTYONHAND, QTYSHIPNOTINV, MFGRLOTSERNBR, EXPDATE, WARRANTYDATE,
			SOURCE, SRCORDNBR, SHIPCONTCODE
			FROM	LOTSERMST (NoLock)
			WHERE	INVTID IN (SELECT DISTINCT INVTID FROM INTRAN (NoLock) WHERE BATNBR = @BATNBR AND CPNYID = @CPNYID)

		PRINT 'LOTSERT'
		SELECT	BATNBR, RLSED, INTRANLINEREF, TranType, INVTID,
			SITEID, WHSELOC, LOTSERNBR, QTY, MFGRLOTSERNBR,
			TRANSRC, REFNBR, SHIPCONTCODE, EXPDATE
			FROM 	LOTSERT (NoLock)
			WHERE 	BATNBR = @BATNBR
	END

	IF EXISTS(SELECT DISTINCT INTRAN.INVTID
			FROM	INVENTORY (NoLock) JOIN INTRAN (NoLock)
			ON 	INVENTORY.INVTID = INTRAN.INVTID
			WHERE 	BATNBR = @BATNBR
				AND VALMTHD IN ('F', 'L', 'S')
				AND INTRAN.CPNYID = @CPNYID)
	BEGIN
		PRINT 'ITEMCOST'
		SELECT	INVTID, SITEID, LAYERTYPE, SPECIFICCOSTID, RCPTDATE,
			RCPTNBR, QTY, TOTCOST, UNITCOST
			FROM	ITEMCOST (NoLock)
			WHERE 	INVTID IN (SELECT DISTINCT INVTID FROM INTRAN (NoLock) WHERE BATNBR = @BATNBR AND CPNYID = @CPNYID)
			ORDER BY INVTID, SITEID, LAYERTYPE, SPECIFICCOSTID, RCPTDATE, RCPTNBR
	END

	PRINT 'INTRAN'
	SELECT	BATNBR, LINEREF, TRANTYPE, RLSED, JRNLTYPE,
		INVTID, KITID, SITEID, WHSELOC, TOSITEID,
		TOWHSELOC, INSUFFQTY, QTYUNCOSTED, UNITPRICE,
		TRANAMT, EXTCOST, OVRHDAMT, OVRHDFLAG, INVTMULT,
		QTY, CNVFACT, UNITMULTDIV, UNITDESC, RCPTNBR,
		REFNBR, RCPTDATE, TRANDATE, SPECIFICCOSTID, TRANDESC,
		S4FUTURE09, S4FUTURE10, S4FUTURE01 AS ORIGBATNBR, S4FUTURE02 AS ORIGREFNBR, S4FUTURE11 AS ORIGLINEREF
		FROM 	INTRAN  (NoLock)
		WHERE 	(BATNBR = @BATNBR
			OR (INVTID IN (SELECT DISTINCT INVTID FROM INTRAN (NoLock) WHERE BATNBR = @BATNBR AND CPNYID = @CPNYID) AND INSUFFQTY <> 0))
			AND CPNYID = @CPNYID
		ORDER BY BATNBR, LINEID, INVTID, SITEID, WHSELOC, SPECIFICCOSTID

	PRINT 'INTRAN ACCOUNTS'
	SELECT	BATNBR, LINEREF, INVTID, SITEID, TRANTYPE,
		PERENT, PERPOST, RLSED, ACCT, SUB,
		INVTACCT, INVTSUB, COGSACCT, COGSSUB
		FROM 	INTRAN (NoLock)
		WHERE 	(BATNBR = @BATNBR
			OR (INVTID IN (SELECT DISTINCT INVTID FROM INTRAN (NoLock) WHERE BATNBR = @BATNBR AND CPNYID = @CPNYID) AND INSUFFQTY <> 0))
			AND CPNYID = @CPNYID
		ORDER BY BATNBR, LINEID, INVTID, SITEID, WHSELOC, SPECIFICCOSTID

	PRINT 'ITEM COST HISTORY'
	SELECT	INVTID, SITEID, FISCYR, BEGBAL,
		CASE	WHEN @PERNBR = '01' THEN PTDCOGS00
			WHEN @PERNBR = '02' THEN PTDCOGS01
			WHEN @PERNBR = '03' THEN PTDCOGS02
			WHEN @PERNBR = '04' THEN PTDCOGS03
			WHEN @PERNBR = '05' THEN PTDCOGS04
			WHEN @PERNBR = '06' THEN PTDCOGS05
			WHEN @PERNBR = '07' THEN PTDCOGS06
			WHEN @PERNBR = '08' THEN PTDCOGS07
			WHEN @PERNBR = '09' THEN PTDCOGS08
			WHEN @PERNBR = '10' THEN PTDCOGS09
			WHEN @PERNBR = '11' THEN PTDCOGS10
			WHEN @PERNBR = '12' THEN PTDCOGS11
			WHEN @PERNBR = '00' THEN PTDCOGS12
		END AS PTDCOGS, YTDCOGS,
		CASE	WHEN @PERNBR = '01' THEN PTDCOSTADJD00
			WHEN @PERNBR = '02' THEN PTDCOSTADJD01
			WHEN @PERNBR = '03' THEN PTDCOSTADJD02
			WHEN @PERNBR = '04' THEN PTDCOSTADJD03
			WHEN @PERNBR = '05' THEN PTDCOSTADJD04
			WHEN @PERNBR = '06' THEN PTDCOSTADJD05
			WHEN @PERNBR = '07' THEN PTDCOSTADJD06
			WHEN @PERNBR = '08' THEN PTDCOSTADJD07
			WHEN @PERNBR = '09' THEN PTDCOSTADJD08
			WHEN @PERNBR = '10' THEN PTDCOSTADJD09
			WHEN @PERNBR = '11' THEN PTDCOSTADJD10
			WHEN @PERNBR = '12' THEN PTDCOSTADJD11
			WHEN @PERNBR = '00' THEN PTDCOSTADJD12
		END AS PTDCOSTADJD, YTDCOSTADJD,
		CASE	WHEN @PERNBR = '01' THEN PTDCOSTISSD00
			WHEN @PERNBR = '02' THEN PTDCOSTISSD01
			WHEN @PERNBR = '03' THEN PTDCOSTISSD02
			WHEN @PERNBR = '04' THEN PTDCOSTISSD03
			WHEN @PERNBR = '05' THEN PTDCOSTISSD04
			WHEN @PERNBR = '06' THEN PTDCOSTISSD05
			WHEN @PERNBR = '07' THEN PTDCOSTISSD06
			WHEN @PERNBR = '08' THEN PTDCOSTISSD07
			WHEN @PERNBR = '09' THEN PTDCOSTISSD08
			WHEN @PERNBR = '10' THEN PTDCOSTISSD09
			WHEN @PERNBR = '11' THEN PTDCOSTISSD10
			WHEN @PERNBR = '12' THEN PTDCOSTISSD11
			WHEN @PERNBR = '00' THEN PTDCOSTISSD12
		END AS PTDCOSTISSD, YTDCOSTISSD,
		CASE	WHEN @PERNBR = '01' THEN PTDCOSTRCVD00
			WHEN @PERNBR = '02' THEN PTDCOSTRCVD01
			WHEN @PERNBR = '03' THEN PTDCOSTRCVD02
			WHEN @PERNBR = '04' THEN PTDCOSTRCVD03
			WHEN @PERNBR = '05' THEN PTDCOSTRCVD04
			WHEN @PERNBR = '06' THEN PTDCOSTRCVD05
			WHEN @PERNBR = '07' THEN PTDCOSTRCVD06
			WHEN @PERNBR = '08' THEN PTDCOSTRCVD07
			WHEN @PERNBR = '09' THEN PTDCOSTRCVD08
			WHEN @PERNBR = '10' THEN PTDCOSTRCVD09
			WHEN @PERNBR = '11' THEN PTDCOSTRCVD10
			WHEN @PERNBR = '12' THEN PTDCOSTRCVD11
			WHEN @PERNBR = '00' THEN PTDCOSTRCVD12
		END AS PTDCOSTRCVD, YTDCOSTRCVD,
		CASE	WHEN @PERNBR = '01' THEN PTDCOSTTRSFRIN00
			WHEN @PERNBR = '02' THEN PTDCOSTTRSFRIN01
			WHEN @PERNBR = '03' THEN PTDCOSTTRSFRIN02
			WHEN @PERNBR = '04' THEN PTDCOSTTRSFRIN03
			WHEN @PERNBR = '05' THEN PTDCOSTTRSFRIN04
			WHEN @PERNBR = '06' THEN PTDCOSTTRSFRIN05
			WHEN @PERNBR = '07' THEN PTDCOSTTRSFRIN06
			WHEN @PERNBR = '08' THEN PTDCOSTTRSFRIN07
			WHEN @PERNBR = '09' THEN PTDCOSTTRSFRIN08
			WHEN @PERNBR = '10' THEN PTDCOSTTRSFRIN09
			WHEN @PERNBR = '11' THEN PTDCOSTTRSFRIN10
			WHEN @PERNBR = '12' THEN PTDCOSTTRSFRIN11
			WHEN @PERNBR = '00' THEN PTDCOSTTRSFRIN12
		END AS PTDCOSTTRSFRIN, YTDCOSTTRSFRIN,
		CASE	WHEN @PERNBR = '01' THEN PTDCOSTTRSFROUT00
			WHEN @PERNBR = '02' THEN PTDCOSTTRSFROUT01
			WHEN @PERNBR = '03' THEN PTDCOSTTRSFROUT02
			WHEN @PERNBR = '04' THEN PTDCOSTTRSFROUT03
			WHEN @PERNBR = '05' THEN PTDCOSTTRSFROUT04
			WHEN @PERNBR = '06' THEN PTDCOSTTRSFROUT05
			WHEN @PERNBR = '07' THEN PTDCOSTTRSFROUT06
			WHEN @PERNBR = '08' THEN PTDCOSTTRSFROUT07
			WHEN @PERNBR = '09' THEN PTDCOSTTRSFROUT08
			WHEN @PERNBR = '10' THEN PTDCOSTTRSFROUT09
			WHEN @PERNBR = '11' THEN PTDCOSTTRSFROUT10
			WHEN @PERNBR = '12' THEN PTDCOSTTRSFROUT11
			WHEN @PERNBR = '00' THEN PTDCOSTTRSFROUT12
		END AS PTDCOSTTRSFROUT, YTDCOSTTRSFROUT,
		CASE	WHEN @PERNBR = '01' THEN PTDSLS00
			WHEN @PERNBR = '02' THEN PTDSLS01
			WHEN @PERNBR = '03' THEN PTDSLS02
			WHEN @PERNBR = '04' THEN PTDSLS03
			WHEN @PERNBR = '05' THEN PTDSLS04
			WHEN @PERNBR = '06' THEN PTDSLS05
			WHEN @PERNBR = '07' THEN PTDSLS06
			WHEN @PERNBR = '08' THEN PTDSLS07
			WHEN @PERNBR = '09' THEN PTDSLS08
			WHEN @PERNBR = '10' THEN PTDSLS09
			WHEN @PERNBR = '11' THEN PTDSLS10
			WHEN @PERNBR = '12' THEN PTDSLS11
			WHEN @PERNBR = '00' THEN PTDSLS12
		END AS PTDSLS, YTDSLS
		FROM 	ITEMHIST (NoLock)
		WHERE 	INVTID IN (SELECT DISTINCT INVTID FROM INTRAN (NoLock) WHERE BATNBR = @BATNBR AND CPNYID = @CPNYID)
			AND FISCYR = @FISCYR
		ORDER BY INVTID, SITEID, FISCYR

	PRINT 'ITEM QUANTITY HISTORY'
	SELECT	INVTID, SITEID, FISCYR,
		CASE	WHEN @PERNBR = '01' THEN PTDQTYADJD00
			WHEN @PERNBR = '02' THEN PTDQTYADJD01
			WHEN @PERNBR = '03' THEN PTDQTYADJD02
			WHEN @PERNBR = '04' THEN PTDQTYADJD03
			WHEN @PERNBR = '05' THEN PTDQTYADJD04
			WHEN @PERNBR = '06' THEN PTDQTYADJD05
			WHEN @PERNBR = '07' THEN PTDQTYADJD06
			WHEN @PERNBR = '08' THEN PTDQTYADJD07
			WHEN @PERNBR = '09' THEN PTDQTYADJD08
			WHEN @PERNBR = '10' THEN PTDQTYADJD09
			WHEN @PERNBR = '11' THEN PTDQTYADJD10
			WHEN @PERNBR = '12' THEN PTDQTYADJD11
			WHEN @PERNBR = '00' THEN PTDQTYADJD12
		END AS PTDQTYADJD, YTDQTYADJD,
		CASE	WHEN @PERNBR = '01' THEN PTDQTYISSD00
			WHEN @PERNBR = '02' THEN PTDQTYISSD01
			WHEN @PERNBR = '03' THEN PTDQTYISSD02
			WHEN @PERNBR = '04' THEN PTDQTYISSD03
			WHEN @PERNBR = '05' THEN PTDQTYISSD04
			WHEN @PERNBR = '06' THEN PTDQTYISSD05
			WHEN @PERNBR = '07' THEN PTDQTYISSD06
			WHEN @PERNBR = '08' THEN PTDQTYISSD07
			WHEN @PERNBR = '09' THEN PTDQTYISSD08
			WHEN @PERNBR = '10' THEN PTDQTYISSD09
			WHEN @PERNBR = '11' THEN PTDQTYISSD10
			WHEN @PERNBR = '12' THEN PTDQTYISSD11
			WHEN @PERNBR = '00' THEN PTDQTYISSD12
		END AS PTDQTYISSD, YTDQTYISSD,
		CASE	WHEN @PERNBR = '01' THEN PTDQTYRCVD00
			WHEN @PERNBR = '02' THEN PTDQTYRCVD01
			WHEN @PERNBR = '03' THEN PTDQTYRCVD02
			WHEN @PERNBR = '04' THEN PTDQTYRCVD03
			WHEN @PERNBR = '05' THEN PTDQTYRCVD04
			WHEN @PERNBR = '06' THEN PTDQTYRCVD05
			WHEN @PERNBR = '07' THEN PTDQTYRCVD06
			WHEN @PERNBR = '08' THEN PTDQTYRCVD07
			WHEN @PERNBR = '09' THEN PTDQTYRCVD08
			WHEN @PERNBR = '10' THEN PTDQTYRCVD09
			WHEN @PERNBR = '11' THEN PTDQTYRCVD10
			WHEN @PERNBR = '12' THEN PTDQTYRCVD11
			WHEN @PERNBR = '00' THEN PTDQTYRCVD12
		END AS PTDQTYRCVD, YTDQTYRCVD,
		CASE	WHEN @PERNBR = '01' THEN PTDQTYTRSFRIN00
			WHEN @PERNBR = '02' THEN PTDQTYTRSFRIN01
			WHEN @PERNBR = '03' THEN PTDQTYTRSFRIN02
			WHEN @PERNBR = '04' THEN PTDQTYTRSFRIN03
			WHEN @PERNBR = '05' THEN PTDQTYTRSFRIN04
			WHEN @PERNBR = '06' THEN PTDQTYTRSFRIN05
			WHEN @PERNBR = '07' THEN PTDQTYTRSFRIN06
			WHEN @PERNBR = '08' THEN PTDQTYTRSFRIN07
			WHEN @PERNBR = '09' THEN PTDQTYTRSFRIN08
			WHEN @PERNBR = '10' THEN PTDQTYTRSFRIN09
			WHEN @PERNBR = '11' THEN PTDQTYTRSFRIN10
			WHEN @PERNBR = '12' THEN PTDQTYTRSFRIN11
			WHEN @PERNBR = '00' THEN PTDQTYTRSFRIN12
		END AS PTDQTYTRSFRIN, YTDQTYTRSFRIN,
		CASE	WHEN @PERNBR = '01' THEN PTDQTYTRSFROUT00
			WHEN @PERNBR = '02' THEN PTDQTYTRSFROUT01
			WHEN @PERNBR = '03' THEN PTDQTYTRSFROUT02
			WHEN @PERNBR = '04' THEN PTDQTYTRSFROUT03
			WHEN @PERNBR = '05' THEN PTDQTYTRSFROUT04
			WHEN @PERNBR = '06' THEN PTDQTYTRSFROUT05
			WHEN @PERNBR = '07' THEN PTDQTYTRSFROUT06
			WHEN @PERNBR = '08' THEN PTDQTYTRSFROUT07
			WHEN @PERNBR = '09' THEN PTDQTYTRSFROUT08
			WHEN @PERNBR = '10' THEN PTDQTYTRSFROUT09
			WHEN @PERNBR = '11' THEN PTDQTYTRSFROUT10
			WHEN @PERNBR = '12' THEN PTDQTYTRSFROUT11
			WHEN @PERNBR = '00' THEN PTDQTYTRSFROUT12
		END AS PTDQTYTRSFROUT, YTDQTYTRSFROUT,
		CASE	WHEN @PERNBR = '01' THEN PTDQTYSLS00
			WHEN @PERNBR = '02' THEN PTDQTYSLS01
			WHEN @PERNBR = '03' THEN PTDQTYSLS02
			WHEN @PERNBR = '04' THEN PTDQTYSLS03
			WHEN @PERNBR = '05' THEN PTDQTYSLS04
			WHEN @PERNBR = '06' THEN PTDQTYSLS05
			WHEN @PERNBR = '07' THEN PTDQTYSLS06
			WHEN @PERNBR = '08' THEN PTDQTYSLS07
			WHEN @PERNBR = '09' THEN PTDQTYSLS08
			WHEN @PERNBR = '10' THEN PTDQTYSLS09
			WHEN @PERNBR = '11' THEN PTDQTYSLS10
			WHEN @PERNBR = '12' THEN PTDQTYSLS11
			WHEN @PERNBR = '00' THEN PTDQTYSLS12
		END AS PTDQTYSLS, YTDQTYSLS
		FROM 	ITEM2HIST (NoLock)
		WHERE 	INVTID IN (SELECT DISTINCT INVTID FROM INTRAN (NoLock) WHERE BATNBR = @BATNBR AND CPNYID = @CPNYID)
			AND FISCYR = @FISCYR
		ORDER BY INVTID, SITEID, FISCYR

	PRINT	'BATCH RELEASE ERROR RETURN TABLE'
	SELECT * FROM IN10400_RETURN (NoLock)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[QC_DATA_CHECK] TO [MSDSL]
    AS [dbo];
