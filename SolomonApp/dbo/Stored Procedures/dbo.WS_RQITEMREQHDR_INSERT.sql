CREATE PROCEDURE WS_RQITEMREQHDR_INSERT
            @Acct char(10), @AppvLevObt char(2), @AppvLevReq char(2), @BillAddr1 char(60), @BillAddr2 char(60),
            @BillAttn char(30), @BillCity char(30), @BillCountry char(3), @BillEmail char(80), @BillFax char(30),
            @BillName char(60), @BillPhone char(30), @BillState char(3), @BillZip char(10), @City char(30),
            @Country char(3), @CpnyID char(10), @CreateDate smalldatetime, @crtd_datetime smalldatetime, @crtd_prog char(8),
            @crtd_user char(10), @CuryEffDate smalldatetime, @CuryFreight float, @CuryID char(4), @CuryIRTotal float,
            @CuryMultDiv char(1), @CuryRate float, @CuryRateType char(6), @CuryTaxTot00 float, @CuryTaxTot01 float,
            @CuryTaxTot02 float, @CuryTaxTot03 float, @CuryTxblTot00 float, @CuryTxblTot01 float, @CuryTxblTot02 float,
            @CuryTxblTot03 float, @Dept char(10), @Descr char(30), @DocHandling char(2), @ItemReqNbr char(10), 
            @IrTotal float, @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @MaterialType char(10), 
            @NoteId int, @OptA char(1), @OptB char(1), @OptC char(1), @PolicyLevObt char(2), 
            @PolicyLevReq char(2), @Project char(16), @Requstnr char(47), @RequstnrDept char(10), @RequstnrName char(30), 
            @S4Future1 char(30), @S4Future2 char(30), @S4Future3 float, @S4Future4 float, @S4Future5 float, 
            @S4Future6 float, @S4Future7 smalldatetime, @S4Future8 smalldatetime, @S4Future9 int, @S4Future10 int, 
            @S4Future11 char(10), @S4Future12 char(10), @shipaddrid char(10), @ShipAddr1 char(60), @ShipAddr2 char(60), 
            @ShipAttn char(30), @ShipCity char(30), @ShipCountry char(3), @ShipCustID char(15), @ShipEmail char(80), 
            @ShipFax char(30), @ShipName char(60), @ShipOrdFromID char(10), @ShipPhone char(30), @ShipSiteID char(10), 
            @ShipState char(3), @ShipToID char(10), @ShipToTye char(1), @ShipVendID char(15), @ShipZip char(10), 
            @State char(3), @Status char(2), @Sub char(24), @Task char(32), @User1 char(30),
            @User2 char(30), @User3 float, @User4 float, @User5 char(10), @User6 char(10),
            @User7 smalldatetime, @User8 smalldatetime, @VendID char(15), @Zip char(10)
            AS
            BEGIN
            INSERT INTO [RQITEMREQHDR]
            ([Acct], [AppvLevObt], [AppvLevReq], [BillAddr1], [BillAddr2],
            [BillAttn], [BillCity], [BillCountry], [BillEmail], [BillFax],
            [BillName], [BillPhone], [BillState], [BillZip], [City],
            [Country], [CpnyID], [CreateDate], [crtd_datetime], [crtd_prog],
            [crtd_user], [CuryEffDate], [CuryFreight], [CuryID], [CuryIRTotal],
            [CuryMultDiv], [CuryRate], [CuryRateType], [CuryTaxTot00], [CuryTaxTot01],
            [CuryTaxTot02], [CuryTaxTot03], [CuryTxblTot00], [CuryTxblTot01], [CuryTxblTot02],
            [CuryTxblTot03], [Dept], [Descr], [DocHandling], [ItemReqNbr],
            [IrTotal], [lupd_datetime], [lupd_prog], [lupd_user], [MaterialType],
            [NoteId], [OptA], [OptB], [OptC], [PolicyLevObt],
            [PolicyLevReq], [Project], [Requstnr], [RequstnrDept], [RequstnrName],
            [S4Future1], [S4Future2], [S4Future3], [S4Future4], [S4Future5],
            [S4Future6], [S4Future7], [S4Future8], [S4Future9], [S4Future10],
            [S4Future11], [S4Future12], [shipaddrid], [ShipAddr1], [ShipAddr2],
            [ShipAttn], [ShipCity], [ShipCountry], [ShipCustID], [ShipEmail],
            [ShipFax], [ShipName], [ShipOrdFromID], [ShipPhone], [ShipSiteID],
            [ShipState], [ShipToID], [ShipToTye], [ShipVendID], [ShipZip],
            [State], [Status], [Sub], [Task], [User1],
            [User2], [User3], [User4], [User5], [User6],
            [User7], [User8], [VendID], [Zip])
            VALUES
            (@Acct, @AppvLevObt, @AppvLevReq, @BillAddr1, @BillAddr2,
            @BillAttn, @BillCity, @BillCountry, @BillEmail, @BillFax,
            @BillName, @BillPhone, @BillState, @BillZip, @City,
            @Country, @CpnyID, @CreateDate, @crtd_datetime, @crtd_prog,
            @crtd_user, @CuryEffDate, @CuryFreight, @CuryID, @CuryIRTotal,
            @CuryMultDiv, @CuryRate, @CuryRateType, @CuryTaxTot00, @CuryTaxTot01,
            @CuryTaxTot02, @CuryTaxTot03, @CuryTxblTot00, @CuryTxblTot01, @CuryTxblTot02,
            @CuryTxblTot03, @Dept, @Descr, @DocHandling, @ItemReqNbr,
            @IrTotal, @lupd_datetime, @lupd_prog, @lupd_user, @MaterialType,
            @NoteId, @OptA, @OptB, @OptC, @PolicyLevObt,
            @PolicyLevReq, @Project, @Requstnr, @RequstnrDept, @RequstnrName,
            @S4Future1, @S4Future2, @S4Future3, @S4Future4, @S4Future5,
            @S4Future6, @S4Future7, @S4Future8, @S4Future9, @S4Future10,
            @S4Future11, @S4Future12, @shipaddrid, @ShipAddr1, @ShipAddr2,
            @ShipAttn, @ShipCity, @ShipCountry, @ShipCustID, @ShipEmail,
            @ShipFax, @ShipName, @ShipOrdFromID, @ShipPhone, @ShipSiteID,
            @ShipState, @ShipToID, @ShipToTye, @ShipVendID, @ShipZip,
            @State, @Status, @Sub, @Task, @User1,
            @User2, @User3, @User4, @User5, @User6,
            @User7, @User8, @VendID, @Zip);
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQITEMREQHDR_INSERT] TO [MSDSL]
    AS [dbo];

