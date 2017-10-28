 CREATE PROC [dbo].[AP03630_pre]
	@ri_id		smallint
as
       DECLARE @BegPerNbr      char(6),
                @EndPerNbr      char(6),
                @GLBaseCuryId   char(4),
                @BaseDecPl	SMALLINT

         ---  Get the beginning and ending period numbers and where clause
        ---  from RptRunTime


        SELECT  @BegPerNbr = '', @EndPerNbr = 'zzzzzz'
        SELECT  @BegPerNbr = BegPerNbr,
                @EndPerNbr = EndPerNbr
        FROM    RptRunTime
        WHERE   RI_ID = @RI_ID


          ---  Get the base currency id from GL Setup

        SELECT  @GLBaseCuryID = g.BaseCuryID, @BaseDecPl = c.DecPl
        FROM    GLSetup g(nolock),  currncy c(nolock)
        WHERE g.BaseCuryID = c.CuryID


        ---  Clean up old records if any

        DELETE FROM ap03630mc_wrk
        WHERE   RI_ID = @RI_ID

        ---  Update the where clause with the ri_id
        EXEC    SetRIWhere_sp   @ri_id, 'ap03630mc_wrk'


        ---  Insert check records into the work table
        ---  which are in the requested
        ---  beginning and ending periods.

        INSERT  ap03630mc_wrk
        SELECT  @RI_ID,
                APDocCk.Acct,
                APDocCk.BatNbr,
                APDocCk.Cpnyid,
                APDocCk.CuryId,
                APDocCk.DocClass,
                APDocCk.DocDate,
                APDocCk.DocType,
                APDocCk.OrigDocAmt,
                APDocCk.CuryOrigDocAmt,
                APDocCk.PerClosed,
                APDocCk.PerPost,
                APDocCk.RefNbr,
                APDocCk.Sub,
                APDocCk.VendId,
                APDocCk.VendName,
                NULL,
                APDocCk.CuryRate,
                NULL, NULL, NULL, NULL, NULL, NULL,
                NULL, NULL, NULL, NULL, APDocCk.CuryMultDiv, CONVERT(CHAR(1), ISNULL(Currncy.DecPl, 2)), NULL
        FROM APDoc APDocCk (NOLOCK)
                LEFT JOIN Vendor Vendor (NOLOCK) ON
			APDocCk.VendId = Vendor.VendId
                LEFT JOIN Currncy Currncy (NOLOCK) ON
			APDocCk.CuryId = Currncy.CuryId
        WHERE   APDocCK.DocType IN ( 'CK', 'HC', 'EP', 'ZC', 'MC', 'SC', 'VC' )
        	AND     APDocCk.Rlsed = 1
        	AND     APDocCk.PerPost BETWEEN @BegPerNbr  AND  @EndPerNbr
--	Insert Adjustments

        INSERT  ap03630mc_wrk
       SELECT  @RI_ID,
                APDocCk.Acct,
                APDocCk.BatNbr,
                APDocCk.Cpnyid,
                APDocCk.CuryId,
                APDocCk.DocClass,
                APDocCk.DocDate,
                APDocCk.DocType,
                APDocCk.OrigDocAmt,
                APDocCk.CuryOrigDocAmt,
                APDocCk.PerClosed,
                APDocCk.PerPost,
                APDocCk.RefNbr,
                APDocCk.Sub,
                APDocCk.VendId,
                APDocCk.Vendor_Name,
                @GLBaseCuryId,
		CASE APAdjust.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END
		*
		round (convert (dec(28,3),APAdjust.AdjAmt+APAdjust.CuryRGOLAmt), @BaseDecPl)
 		,
		ROUND(
		CASE APAdjust.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END
		*
		APAdjust.AdjDiscAmt, @BaseDecPl),
                APAdjust.AdjgPerPost,
		ROUND(
		CASE APAdjust.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END
		*
		(CASE ISNULL(APAdjust.CuryAdjdCuryId, APDocCk.CuryId) WHEN APDocCk.CuryId THEN
	                APAdjust.CuryAdjdAmt
		     ELSE
	                APAdjust.CuryAdjgAmt
                END), CONVERT(SMALLINT, APDocCk.APDocVO_RefNbr)),
		ROUND(
		CASE APAdjust.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END
		*
		(CASE ISNULL(APAdjust.CuryAdjdCuryId, APDocCk.CuryId) WHEN APDocCk.CuryId THEN
	                APAdjust.CuryAdjdDiscAmt
		     ELSE
	                APAdjust.CuryAdjgDiscAmt
                END), CONVERT(SMALLINT, APDocCk.APDocVO_RefNbr)),
                APAdjust.AdjdRefNbr,
                APAdjust.AdjdDocType,
                NULL, NULL, NULL, NULL, NULL, NULL, NULL
        FROM    AP03630MC_Wrk APDocCk
                LEFT LOOP JOIN APAdjust APAdjust (NOLOCK) ON
			APDocCk.RefNbr = APAdjust.AdjgRefNbr
        		AND     APDocCk.DocType = APAdjust.AdjgDocType
        		AND     APDocCk.Acct = APAdjust.AdjgAcct
        		AND     APDocCk.Sub = APAdjust.AdjgSub

        WHERE   APDocCk.RI_ID = @RI_ID

        ---  Update document information for adjustment
        ---  records with associated documents

	DELETE	ap03630mc_wrk
	WHERE	RI_ID = @RI_ID AND APDocVO_InvcNbr IS NOT NULL

        UPDATE  ap03630mc_wrk
        SET     APDocVO_CpnyID = APDocVO.CpnyID,
                APDocVO_CuryId = APDocVO.CuryId,
                APDocVO_DocType = APDocVO.DocType,
                APDocVO_InvcDate = APDocVO.InvcDate,
                APDocVO_InvcNbr = APDocVO.InvcNbr,
                APDocVO_RefNbr = APDocVO.RefNbr
        FROM    APDoc APDocVO (NOLOCK)
        WHERE   ap03630mc_wrk.RI_ID = @RI_ID
        	AND     ap03630mc_wrk.APAdjust_AdjdRefNbr = APDocVO.RefNbr
        	AND     ap03630mc_wrk.APAdjust_AdjdDocType = APDocVO.DocType


