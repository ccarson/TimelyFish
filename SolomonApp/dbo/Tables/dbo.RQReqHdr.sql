CREATE TABLE [dbo].[RQReqHdr] (
    [Acct]             CHAR (10)     NOT NULL,
    [AckDateTime]      SMALLDATETIME NOT NULL,
    [Addr1]            CHAR (60)     NOT NULL,
    [Addr2]            CHAR (60)     NOT NULL,
    [AppvLevObt]       CHAR (2)      NOT NULL,
    [AppvLevReq]       CHAR (2)      NOT NULL,
    [Attn]             CHAR (30)     NOT NULL,
    [BatNbr]           CHAR (10)     NOT NULL,
    [BillAddrID]       CHAR (10)     NOT NULL,
    [BillAddr1]        CHAR (60)     NOT NULL,
    [BillAddr2]        CHAR (60)     NOT NULL,
    [BillAttn]         CHAR (30)     NOT NULL,
    [BillCity]         CHAR (30)     NOT NULL,
    [BillCountry]      CHAR (3)      NOT NULL,
    [BillEmail]        CHAR (80)     NOT NULL,
    [BillFax]          CHAR (30)     NOT NULL,
    [BillName]         CHAR (60)     NOT NULL,
    [BillPhone]        CHAR (30)     NOT NULL,
    [BillShipAddr]     SMALLINT      NOT NULL,
    [BillState]        CHAR (3)      NOT NULL,
    [BillZip]          CHAR (10)     NOT NULL,
    [BlktExpDate]      SMALLDATETIME NOT NULL,
    [BlktNbr]          CHAR (10)     NOT NULL,
    [Budgeted]         CHAR (1)      NOT NULL,
    [Buyer]            CHAR (10)     NOT NULL,
    [CertCompl]        SMALLINT      NOT NULL,
    [City]             CHAR (30)     NOT NULL,
    [ConfirmTo]        CHAR (10)     NOT NULL,
    [Country]          CHAR (3)      NOT NULL,
    [CpnyID]           CHAR (10)     NOT NULL,
    [CreateDate]       SMALLDATETIME NOT NULL,
    [crtd_datetime]    SMALLDATETIME NOT NULL,
    [crtd_prog]        CHAR (8)      NOT NULL,
    [crtd_user]        CHAR (10)     NOT NULL,
    [CurrentNbr]       SMALLINT      NOT NULL,
    [CuryEffdate]      SMALLDATETIME NOT NULL,
    [CuryFreight]      FLOAT (53)    NOT NULL,
    [CuryID]           CHAR (4)      NOT NULL,
    [CuryMultDiv]      CHAR (1)      NOT NULL,
    [CuryPOItemTotal]  FLOAT (53)    NOT NULL,
    [CuryPrevPoTotal]  FLOAT (53)    NOT NULL,
    [CuryRate]         FLOAT (53)    NOT NULL,
    [CuryRateType]     CHAR (6)      NOT NULL,
    [CuryRcptTotAmt]   FLOAT (53)    NOT NULL,
    [CuryReqTotal]     FLOAT (53)    NOT NULL,
    [CuryTaxTot00]     FLOAT (53)    NOT NULL,
    [CuryTaxTot01]     FLOAT (53)    NOT NULL,
    [CuryTaxTot02]     FLOAT (53)    NOT NULL,
    [CuryTaxTot03]     FLOAT (53)    NOT NULL,
    [CuryTotalExtCost] FLOAT (53)    NOT NULL,
    [CuryTxblTot00]    FLOAT (53)    NOT NULL,
    [CuryTxblTot01]    FLOAT (53)    NOT NULL,
    [CuryTxblTot02]    FLOAT (53)    NOT NULL,
    [CuryTxblTot03]    FLOAT (53)    NOT NULL,
    [Dept]             CHAR (10)     NOT NULL,
    [Descr]            CHAR (30)     NOT NULL,
    [DocHandling]      CHAR (2)      NOT NULL,
    [EDI]              SMALLINT      NOT NULL,
    [EncumProc]        CHAR (1)      NOT NULL,
    [Fax]              CHAR (30)     NOT NULL,
    [FOB]              CHAR (15)     NOT NULL,
    [Freight]          FLOAT (53)    NOT NULL,
    [lupd_datetime]    SMALLDATETIME NOT NULL,
    [lupd_prog]        CHAR (8)      NOT NULL,
    [lupd_user]        CHAR (10)     NOT NULL,
    [MaterialType]     CHAR (10)     NOT NULL,
    [Name]             CHAR (30)     NOT NULL,
    [NoteID]           INT           NOT NULL,
    [OptA]             CHAR (1)      NOT NULL,
    [OptB]             CHAR (1)      NOT NULL,
    [OptC]             CHAR (1)      NOT NULL,
    [PC_Status]        CHAR (1)      NOT NULL,
    [PerApproved]      CHAR (6)      NOT NULL,
    [PerEntered]       CHAR (6)      NOT NULL,
    [Phone]            CHAR (30)     NOT NULL,
    [PODate]           SMALLDATETIME NOT NULL,
    [POItemTotal]      FLOAT (53)    NOT NULL,
    [PolicyLevObt]     CHAR (2)      NOT NULL,
    [PolicyLevReq]     CHAR (2)      NOT NULL,
    [PONbr]            CHAR (10)     NOT NULL,
    [POType]           CHAR (2)      NOT NULL,
    [PrevPoTotal]      FLOAT (53)    NOT NULL,
    [Project]          CHAR (16)     NOT NULL,
    [QuoteDate]        SMALLDATETIME NOT NULL,
    [RcptTotAmt]       FLOAT (53)    NOT NULL,
    [ReqCntr]          CHAR (2)      NOT NULL,
    [ReqNbr]           CHAR (10)     NOT NULL,
    [ReqTotal]         FLOAT (53)    NOT NULL,
    [ReqType]          CHAR (2)      NOT NULL,
    [Requstnr]         CHAR (47)     NOT NULL,
    [RequstnrDept]     CHAR (10)     NOT NULL,
    [RequstnrName]     CHAR (30)     NOT NULL,
    [S4Future1]        CHAR (30)     NOT NULL,
    [S4Future2]        CHAR (30)     NOT NULL,
    [S4Future3]        FLOAT (53)    NOT NULL,
    [S4Future4]        FLOAT (53)    NOT NULL,
    [S4Future5]        FLOAT (53)    NOT NULL,
    [S4Future6]        FLOAT (53)    NOT NULL,
    [S4Future7]        SMALLDATETIME NOT NULL,
    [S4Future8]        SMALLDATETIME NOT NULL,
    [S4Future9]        INT           NOT NULL,
    [S4Future10]       INT           NOT NULL,
    [S4Future11]       CHAR (10)     NOT NULL,
    [S4Future12]       CHAR (10)     NOT NULL,
    [ServiceCallID]    CHAR (10)     NOT NULL,
    [ShipAddr1]        CHAR (60)     NOT NULL,
    [ShipAddr2]        CHAR (60)     NOT NULL,
    [ShipAddrID]       CHAR (15)     NOT NULL,
    [ShipAttn]         CHAR (30)     NOT NULL,
    [ShipCity]         CHAR (30)     NOT NULL,
    [ShipCountry]      CHAR (3)      NOT NULL,
    [ShipCustID]       CHAR (15)     NOT NULL,
    [ShipEmail]        CHAR (80)     NOT NULL,
    [ShipFax]          CHAR (30)     NOT NULL,
    [ShipName]         CHAR (60)     NOT NULL,
    [ShipPhone]        CHAR (30)     NOT NULL,
    [ShipSiteID]       CHAR (10)     NOT NULL,
    [ShipState]        CHAR (3)      NOT NULL,
    [ShipToID]         CHAR (10)     NOT NULL,
    [ShipToType]       CHAR (1)      NOT NULL,
    [ShipVendAddrID]   CHAR (10)     NOT NULL,
    [ShipVendID]       CHAR (15)     NOT NULL,
    [ShipVia]          CHAR (15)     NOT NULL,
    [ShipZip]          CHAR (10)     NOT NULL,
    [State]            CHAR (3)      NOT NULL,
    [Status]           CHAR (2)      NOT NULL,
    [Sub]              CHAR (24)     NOT NULL,
    [Task]             CHAR (32)     NOT NULL,
    [TaxCntr00]        SMALLINT      NOT NULL,
    [TaxCntr01]        SMALLINT      NOT NULL,
    [TaxCntr02]        SMALLINT      NOT NULL,
    [TaxCntr03]        SMALLINT      NOT NULL,
    [TaxID00]          CHAR (10)     NOT NULL,
    [TaxID01]          CHAR (10)     NOT NULL,
    [TaxID02]          CHAR (10)     NOT NULL,
    [TaxID03]          CHAR (10)     NOT NULL,
    [TaxTot00]         FLOAT (53)    NOT NULL,
    [TaxTot01]         FLOAT (53)    NOT NULL,
    [TaxTot02]         FLOAT (53)    NOT NULL,
    [TaxTot03]         FLOAT (53)    NOT NULL,
    [Terms]            CHAR (2)      NOT NULL,
    [TotalExtCost]     FLOAT (53)    NOT NULL,
    [TranMedium]       CHAR (2)      NOT NULL,
    [TxblTot00]        FLOAT (53)    NOT NULL,
    [TxblTot01]        FLOAT (53)    NOT NULL,
    [TxblTot02]        FLOAT (53)    NOT NULL,
    [TxblTot03]        FLOAT (53)    NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [VendAddrID]       CHAR (10)     NOT NULL,
    [VendEmail]        CHAR (80)     NOT NULL,
    [VendID]           CHAR (15)     NOT NULL,
    [VouchStage]       CHAR (1)      NOT NULL,
    [Zip]              CHAR (10)     NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [RQReqHdr1]
    ON [dbo].[RQReqHdr]([ReqType] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQReqHdr2]
    ON [dbo].[RQReqHdr]([Status] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQReqHdr3]
    ON [dbo].[RQReqHdr]([ReqTotal] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQReqHdr4]
    ON [dbo].[RQReqHdr]([Requstnr] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQReqHdr5]
    ON [dbo].[RQReqHdr]([VendID] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQReqHdr6]
    ON [dbo].[RQReqHdr]([CreateDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQReqHdr7]
    ON [dbo].[RQReqHdr]([RequstnrDept] ASC, [ReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQReqHdr8]
    ON [dbo].[RQReqHdr]([Requstnr] ASC, [RequstnrDept] ASC, [ReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQReqHdr0]
    ON [dbo].[RQReqHdr]([ReqNbr] ASC, [ReqCntr] ASC);

