CREATE TABLE [dbo].[RQItemReqDet] (
    [Acct]                 CHAR (10)     NOT NULL,
    [AppvLevObt]           CHAR (2)      NOT NULL,
    [AppvLevReq]           CHAR (2)      NOT NULL,
    [CatalogInfo]          CHAR (60)     NOT NULL,
    [CnvFact]              FLOAT (53)    NOT NULL,
    [CpnyID]               CHAR (10)     NOT NULL,
    [crtd_datetime]        SMALLDATETIME NOT NULL,
    [crtd_prog]            CHAR (8)      NOT NULL,
    [crtd_user]            CHAR (10)     NOT NULL,
    [CuryEstimateCost]     FLOAT (53)    NOT NULL,
    [CuryEstimatedExtcost] FLOAT (53)    NOT NULL,
    [CuryID]               CHAR (4)      NOT NULL,
    [CuryMultDiv]          CHAR (1)      NOT NULL,
    [CuryRate]             FLOAT (53)    NOT NULL,
    [CuryRateType]         CHAR (6)      NOT NULL,
    [CuryTaxAmt00]         FLOAT (53)    NOT NULL,
    [CuryTaxAmt01]         FLOAT (53)    NOT NULL,
    [CuryTaxAmt02]         FLOAT (53)    NOT NULL,
    [CuryTaxAmt03]         FLOAT (53)    NOT NULL,
    [CuryTxblAmt00]        FLOAT (53)    NOT NULL,
    [CuryTxblAmt01]        FLOAT (53)    NOT NULL,
    [CuryTxblAmt02]        FLOAT (53)    NOT NULL,
    [CuryTxblAmt03]        FLOAT (53)    NOT NULL,
    [CuryUnitCost]         FLOAT (53)    NOT NULL,
    [Dept]                 CHAR (10)     NOT NULL,
    [Descr]                CHAR (60)     NOT NULL,
    [EstimateCost]         FLOAT (53)    NOT NULL,
    [EstimatedExtcost]     FLOAT (53)    NOT NULL,
    [InvtId]               CHAR (30)     NOT NULL,
    [ItemReqNbr]           CHAR (10)     NOT NULL,
    [LineKey]              CHAR (17)     NOT NULL,
    [LineNbr]              SMALLINT      NOT NULL,
    [lupd_datetime]        SMALLDATETIME NOT NULL,
    [lupd_prog]            CHAR (8)      NOT NULL,
    [lupd_user]            CHAR (10)     NOT NULL,
    [MaterialType]         CHAR (10)     NOT NULL,
    [NoteId]               INT           NOT NULL,
    [PolicyLevObt]         CHAR (2)      NOT NULL,
    [PolicyLevReq]         CHAR (2)      NOT NULL,
    [PrefVendor]           CHAR (15)     NOT NULL,
    [Project]              CHAR (16)     NOT NULL,
    [PurchaseFor]          CHAR (2)      NOT NULL,
    [Qty]                  FLOAT (53)    NOT NULL,
    [ReqDate]              SMALLDATETIME NOT NULL,
    [ReqNbr]               CHAR (10)     NOT NULL,
    [S4Future1]            CHAR (30)     NOT NULL,
    [S4Future2]            CHAR (30)     NOT NULL,
    [S4Future3]            FLOAT (53)    NOT NULL,
    [S4Future4]            FLOAT (53)    NOT NULL,
    [S4Future5]            FLOAT (53)    NOT NULL,
    [S4Future6]            FLOAT (53)    NOT NULL,
    [S4Future7]            SMALLDATETIME NOT NULL,
    [S4Future8]            SMALLDATETIME NOT NULL,
    [S4Future9]            INT           NOT NULL,
    [S4Future10]           INT           NOT NULL,
    [S4Future11]           CHAR (10)     NOT NULL,
    [S4Future12]           CHAR (10)     NOT NULL,
    [SiteID]               CHAR (10)     NOT NULL,
    [Status]               CHAR (2)      NOT NULL,
    [Sub]                  CHAR (24)     NOT NULL,
    [Task]                 CHAR (32)     NOT NULL,
    [TotalCost]            FLOAT (53)    NOT NULL,
    [Unit]                 CHAR (6)      NOT NULL,
    [User1]                CHAR (30)     NOT NULL,
    [User2]                CHAR (30)     NOT NULL,
    [User3]                FLOAT (53)    NOT NULL,
    [User4]                FLOAT (53)    NOT NULL,
    [User5]                CHAR (10)     NOT NULL,
    [User6]                CHAR (10)     NOT NULL,
    [User7]                SMALLDATETIME NOT NULL,
    [User8]                SMALLDATETIME NOT NULL,
    [VendItemID]           CHAR (30)     NOT NULL,
    [tstamp]               ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [RQItemReqDet1]
    ON [dbo].[RQItemReqDet]([ItemReqNbr] ASC, [MaterialType] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [RQItemReqDet2]
    ON [dbo].[RQItemReqDet]([MaterialType] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQItemReqDet0]
    ON [dbo].[RQItemReqDet]([ItemReqNbr] ASC, [LineNbr] ASC);

