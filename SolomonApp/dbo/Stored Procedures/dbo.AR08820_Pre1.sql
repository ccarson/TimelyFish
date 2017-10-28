 CREATE PROC [dbo].[AR08820_Pre1] @RI_ID smallint AS

        DECLARE         @BegPerNbr char(6),
                        @EndPerNbr char(6),
						@RI_Where varchar(1024),
						@Search varchar(1024),
						@Pos SMALLINT

        SELECT          @BegPerNbr='',
                        @EndPerNbr=''

        SELECT          @BegPerNbr=BegPerNbr,
                        @EndPerNbr=EndPerNbr
        FROM            RptRunTime
        WHERE           RI_ID=@RI_ID

        DELETE FROM AR08820_wrk
        WHERE   RI_ID = @RI_ID

        EXEC    SetRIWhere_sp   @ri_id, "ar08820_wrk"

        INSERT  AR08820_wrk (RI_ID, AdjAmt, AdjBatNbr, AdjDDocType, AdjDiscAmt, AdjDRefNbr,
							AdjGDocType, AdjGRefNbr, CpnyID, CustID, CuryAdjDAmt,
							CuryAdjDDiscAmt, AdjGDoc_BatNbr, AdjGDoc_DiscBal, AdjGDoc_DocBal,
							AdjGDoc_DocDate, AdjGDoc_DocDesc, AdjGDoc_OrigDocAmt, AdjGDoc_PerPost,
							AdjGDoc_CuryDiscBal, AdjGDoc_CuryDocBal, AdjGDoc_CuryId,
							AdjGDoc_CuryODocAmt, AdjDDoc_DiscDate, AdjDDoc_DocDate, AdjDDoc_DueDate,
							AdjDDoc_OrigDocAmt, AdjDDoc_PerClosed, AdjDDoc_Terms, AdjDDoc_CuryID,
							Customer_Name, Terms_Descr)
        SELECT DISTINCT
                @RI_ID,
                ARAdjust.AdjAmt,
                ARAdjust.AdjBatNbr,
                ARAdjust.AdjDDocType,
                ARAdjust.AdjDiscAmt,
                ARAdjust.AdjDRefNbr,
                ARAdjust.AdjGDocType,
                ARAdjust.AdjGRefNbr,
                GDoc.CpnyID,
                ARAdjust.CustID,
                ARAdjust.CuryAdjGAmt,
                ARAdjust.CuryAdjGDiscAmt,

                GDoc.BatNbr,
                GDoc.DiscBal,
                GDoc.DocBal,
                GDoc.DocDate,
                GDoc.DocDesc,
                GDoc.OrigDocAmt,
                GDoc.PerPost,
                GDoc.CuryDiscBal,
                GDoc.CuryDocBal,
                GDoc.CuryID,
                GDoc.CuryOrigDocAmt,

                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,

                Customer.Name,

                NULL
        FROM    ArAdjust
			left outer join ARDoc GDoc
				on ArAdjust.CustID = GDoc.CustID
					and ArAdjust.AdjgDocType = GDoc.DocType
					and ArAdjust.AdjGRefNbr = GDoc.RefNbr
            left outer join Customer
				on ArAdjust.CustID = Customer.CustID
        WHERE ArAdjust.PerAppl BETWEEN @BegPerNbr AND @EndPerNbr

        UPDATE  ar08820_wrk
        SET
                AdjDDoc_DiscDate = DDoc.DiscDate,
                AdjDDoc_DocDate  = DDoc.DocDate,
                AdjDDoc_DueDate  = DDoc.DueDate,
                AdjDDoc_OrigDocAmt = DDoc.OrigDocAmt,
                AdjDDoc_PerClosed = DDoc.PerClosed,
                AdjDDoc_Terms    = DDoc.Terms,
                AdjDDoc_CuryID   = DDoc.CuryID
        FROM
                ar08820_wrk
			left outer join ARDoc DDoc
				on Ar08820_wrk.CustID = DDoc.CustID
                and Ar08820_wrk.AdjDDocType = DDoc.DocType
                and Ar08820_wrk.AdjDRefNbr = DDoc.RefNbr
        WHERE
				RI_ID = @RI_ID

                 create table #sumdiscamt
(custid  char(15)  null,
 refnbr  char(10)  null,
 doctype char(2) null,
 discamt float       null,
 curydiscamt float   null)

insert into #sumdiscamt

select aradjust.custid,
        aradjust.adjgrefnbr,
        aradjust.adjgdoctype,
        discamt = sum(aradjust.adjdiscamt),
        curydiscamt = sum(aradjust.curyadjgdiscamt)
from aradjust
group by aradjust.custid, aradjust.adjgrefnbr, aradjust.adjgdoctype

update ar08820_wrk
set
        AdjGDoc_DiscBal = s.discamt,
        AdjGDoc_CuryDiscBal = s.curydiscamt
from ar08820_wrk, #sumdiscamt s
where ar08820_wrk.custid = s.custid    and
      ar08820_wrk.AdjGRefNbr = s.refnbr AND
      ar08820_wrk.Adjgdoctype = s.doctype

        UPDATE  AR08820_Wrk
        SET     Terms_Descr = Terms.Descr
        FROM    AR08820_Wrk
			left outer join Terms
				 on AdjDDoc_Terms = Terms.TermsID
        WHERE   RI_ID = @RI_ID


select @RI_Where = LTRIM(RTRIM(RI_Where)), @BegPerNbr = BegPerNbr, @EndPerNbr = EndPerNbr
from RptRunTime
where RI_ID = @RI_ID

select @Search = "({AR08820_wrk.RI_ID} = " + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + ")"

select @Pos = PATINDEX("%" + @Search + "%", @RI_Where)

	UPDATE RptRunTime SET RI_Where = CASE
	WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
		THEN @Search
	WHEN @Pos <= 0
		THEN @Search + " AND (" + @RI_WHERE + ")"
	END
	WHERE RI_ID = @RI_ID

