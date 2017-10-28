CREATE PROCEDURE WS_RQITEMREQDET_INSERT
            @Acct char(10), @AppvLevObt char(2), @AppvLevReq char(2), @CatalogInfo char(60), @CnvFact float,
            @CpnyID char(10), @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @CuryEstimateCost float,
            @CuryEstimatedExtcost float, @CuryID char(4), @CuryMultDiv char(1), @CuryRate float, @CuryRateType char(6),
            @CuryTaxAmt00 float, @CuryTaxAmt01 float, @CuryTaxAmt02 float, @CuryTaxAmt03 float, @CuryTxblAmt00 float,
            @CuryTxblAmt01 float, @CuryTxblAmt02 float, @CuryTxblAmt03 float, @CuryUnitCost float, @Dept char(10),
            @Descr char(60), @EstimateCost float, @EstimatedExtcost float, @InvtId char(30), @ItemReqNbr char(10),
            @LineKey char(17), @LineNbr smallint, @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10),
            @MaterialType char(10), @NoteId int, @PolicyLevObt char(2), @PolicyLevReq char(2), @PrefVendor char(15),
            @Project char(16), @PurchaseFor char(2), @Qty float, @ReqDate smalldatetime, @ReqNbr char(10),
            @S4Future1 char(30), @S4Future2 char(30), @S4Future3 float, @S4Future4 float, @S4Future5 float,
            @S4Future6 float, @S4Future7 smalldatetime, @S4Future8 smalldatetime, @S4Future9 int, @S4Future10 int,
            @S4Future11 char(10), @S4Future12 char(10), @SiteID char(10), @Status char(2), @Sub char(24),
            @Task char(32), @TotalCost float, @Unit char(6), @User1 char(30), @User2 char(30),
            @User3 float, @User4 float, @User5 char(10), @User6 char(10), @User7 smalldatetime,
            @User8 smalldatetime, @VendItemID char(30)
            AS
            BEGIN
            INSERT INTO [RQITEMREQDET]
            ([Acct], [AppvLevObt], [AppvLevReq], [CatalogInfo], [CnvFact],
            [CpnyID], [crtd_datetime], [crtd_prog], [crtd_user], [CuryEstimateCost],
            [CuryEstimatedExtcost], [CuryID], [CuryMultDiv], [CuryRate], [CuryRateType],
            [CuryTaxAmt00], [CuryTaxAmt01], [CuryTaxAmt02], [CuryTaxAmt03], [CuryTxblAmt00],
            [CuryTxblAmt01], [CuryTxblAmt02], [CuryTxblAmt03], [CuryUnitCost], [Dept],
            [Descr], [EstimateCost], [EstimatedExtcost], [InvtId], [ItemReqNbr],
            [LineKey], [LineNbr], [lupd_datetime], [lupd_prog], [lupd_user],
            [MaterialType], [NoteId], [PolicyLevObt], [PolicyLevReq], [PrefVendor],
            [Project], [PurchaseFor], [Qty], [ReqDate], [ReqNbr],
            [S4Future1], [S4Future2], [S4Future3], [S4Future4], [S4Future5],
            [S4Future6], [S4Future7], [S4Future8], [S4Future9], [S4Future10],
            [S4Future11], [S4Future12], [SiteID], [Status], [Sub],
            [Task], [TotalCost], [Unit], [User1], [User2],
            [User3], [User4], [User5], [User6], [User7],
            [User8], [VendItemID])
            VALUES
            (@Acct, @AppvLevObt, @AppvLevReq, @CatalogInfo, @CnvFact,
            @CpnyID, @crtd_datetime, @crtd_prog, @crtd_user, @CuryEstimateCost,
            @CuryEstimatedExtcost, @CuryID, @CuryMultDiv, @CuryRate, @CuryRateType,
            @CuryTaxAmt00, @CuryTaxAmt01, @CuryTaxAmt02, @CuryTaxAmt03, @CuryTxblAmt00, 
            @CuryTxblAmt01, @CuryTxblAmt02, @CuryTxblAmt03, @CuryUnitCost, @Dept,
            @Descr, @EstimateCost, @EstimatedExtcost, @InvtId, @ItemReqNbr,
            @LineKey, @LineNbr, @lupd_datetime, @lupd_prog, @lupd_user,
            @MaterialType, @NoteId, @PolicyLevObt, @PolicyLevReq, @PrefVendor,
            @Project, @PurchaseFor, @Qty, @ReqDate, @ReqNbr,
            @S4Future1, @S4Future2, @S4Future3, @S4Future4, @S4Future5,
            @S4Future6, @S4Future7, @S4Future8, @S4Future9, @S4Future10,
            @S4Future11, @S4Future12, @SiteID, @Status, @Sub,
            @Task, @TotalCost, @Unit, @User1, @User2,
            @User3, @User4, @User5, @User6, @User7,
            @User8, @VendItemID);
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQITEMREQDET_INSERT] TO [MSDSL]
    AS [dbo];

