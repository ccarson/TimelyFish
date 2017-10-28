CREATE TABLE [dbo].[RQItemReqHdr] (
    [Acct]          CHAR (10)     NOT NULL,
    [AppvLevObt]    CHAR (2)      NOT NULL,
    [AppvLevReq]    CHAR (2)      NOT NULL,
    [BillAddr1]     CHAR (60)     NOT NULL,
    [BillAddr2]     CHAR (60)     NOT NULL,
    [BillAttn]      CHAR (30)     NOT NULL,
    [BillCity]      CHAR (30)     NOT NULL,
    [BillCountry]   CHAR (3)      NOT NULL,
    [BillEmail]     CHAR (80)     NOT NULL,
    [BillFax]       CHAR (30)     NOT NULL,
    [BillName]      CHAR (60)     NOT NULL,
    [BillPhone]     CHAR (30)     NOT NULL,
    [BillState]     CHAR (3)      NOT NULL,
    [BillZip]       CHAR (10)     NOT NULL,
    [City]          CHAR (30)     NOT NULL,
    [Country]       CHAR (3)      NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [CreateDate]    SMALLDATETIME NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [CuryEffDate]   SMALLDATETIME NOT NULL,
    [CuryFreight]   FLOAT (53)    NOT NULL,
    [CuryID]        CHAR (4)      NOT NULL,
    [CuryIRTotal]   FLOAT (53)    NOT NULL,
    [CuryMultDiv]   CHAR (1)      NOT NULL,
    [CuryRate]      FLOAT (53)    NOT NULL,
    [CuryRateType]  CHAR (6)      NOT NULL,
    [CuryTaxTot00]  FLOAT (53)    NOT NULL,
    [CuryTaxTot01]  FLOAT (53)    NOT NULL,
    [CuryTaxTot02]  FLOAT (53)    NOT NULL,
    [CuryTaxTot03]  FLOAT (53)    NOT NULL,
    [CuryTxblTot00] FLOAT (53)    NOT NULL,
    [CuryTxblTot01] FLOAT (53)    NOT NULL,
    [CuryTxblTot02] FLOAT (53)    NOT NULL,
    [CuryTxblTot03] FLOAT (53)    NOT NULL,
    [Dept]          CHAR (10)     NOT NULL,
    [Descr]         CHAR (30)     NOT NULL,
    [DocHandling]   CHAR (2)      NOT NULL,
    [ItemReqNbr]    CHAR (10)     NOT NULL,
    [IrTotal]       FLOAT (53)    NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [MaterialType]  CHAR (10)     NOT NULL,
    [NoteId]        INT           NOT NULL,
    [OptA]          CHAR (1)      NOT NULL,
    [OptB]          CHAR (1)      NOT NULL,
    [OptC]          CHAR (1)      NOT NULL,
    [PolicyLevObt]  CHAR (2)      NOT NULL,
    [PolicyLevReq]  CHAR (2)      NOT NULL,
    [Project]       CHAR (16)     NOT NULL,
    [Requstnr]      CHAR (47)     NOT NULL,
    [RequstnrDept]  CHAR (10)     NOT NULL,
    [RequstnrName]  CHAR (30)     NOT NULL,
    [S4Future1]     CHAR (30)     NOT NULL,
    [S4Future2]     CHAR (30)     NOT NULL,
    [S4Future3]     FLOAT (53)    NOT NULL,
    [S4Future4]     FLOAT (53)    NOT NULL,
    [S4Future5]     FLOAT (53)    NOT NULL,
    [S4Future6]     FLOAT (53)    NOT NULL,
    [S4Future7]     SMALLDATETIME NOT NULL,
    [S4Future8]     SMALLDATETIME NOT NULL,
    [S4Future9]     INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
    [shipaddrid]    CHAR (10)     NOT NULL,
    [ShipAddr1]     CHAR (60)     NOT NULL,
    [ShipAddr2]     CHAR (60)     NOT NULL,
    [ShipAttn]      CHAR (30)     NOT NULL,
    [ShipCity]      CHAR (30)     NOT NULL,
    [ShipCountry]   CHAR (3)      NOT NULL,
    [ShipCustID]    CHAR (15)     NOT NULL,
    [ShipEmail]     CHAR (80)     NOT NULL,
    [ShipFax]       CHAR (30)     NOT NULL,
    [ShipName]      CHAR (60)     NOT NULL,
    [ShipOrdFromID] CHAR (10)     NOT NULL,
    [ShipPhone]     CHAR (30)     NOT NULL,
    [ShipSiteID]    CHAR (10)     NOT NULL,
    [ShipState]     CHAR (3)      NOT NULL,
    [ShipToID]      CHAR (10)     NOT NULL,
    [ShipToTye]     CHAR (1)      NOT NULL,
    [ShipVendID]    CHAR (15)     NOT NULL,
    [ShipZip]       CHAR (10)     NOT NULL,
    [State]         CHAR (3)      NOT NULL,
    [Status]        CHAR (2)      NOT NULL,
    [Sub]           CHAR (24)     NOT NULL,
    [Task]          CHAR (32)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [VendID]        CHAR (15)     NOT NULL,
    [Zip]           CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [RQItemReqHdr1]
    ON [dbo].[RQItemReqHdr]([Status] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQItemReqHdr2]
    ON [dbo].[RQItemReqHdr]([CreateDate] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQItemReqHdr3]
    ON [dbo].[RQItemReqHdr]([IrTotal] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQItemReqHdr4]
    ON [dbo].[RQItemReqHdr]([Requstnr] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQItemReqHdr5]
    ON [dbo].[RQItemReqHdr]([RequstnrDept] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQItemReqHdr0]
    ON [dbo].[RQItemReqHdr]([ItemReqNbr] ASC);

