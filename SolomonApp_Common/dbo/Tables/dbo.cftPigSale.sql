CREATE TABLE [dbo].[cftPigSale] (
    [AmtBaseSale]   FLOAT (53)    NOT NULL,
    [AmtCheck]      FLOAT (53)    NOT NULL,
    [AmtDefer]      FLOAT (53)    NOT NULL,
    [AmtGradePrem]  FLOAT (53)    NOT NULL,
    [AmtInsect]     FLOAT (53)    NOT NULL,
    [AmtInsur]      FLOAT (53)    NOT NULL,
    [AmtNPPC]       FLOAT (53)    NOT NULL,
    [AmtOther]      FLOAT (53)    NOT NULL,
    [AmtScale]      FLOAT (53)    NOT NULL,
    [AmtSortLoss]   FLOAT (53)    NOT NULL,
    [AmtTruck]      FLOAT (53)    NOT NULL,
    [AmtTruckAllow] FLOAT (53)    NOT NULL,
    [ARBatNbr]      CHAR (10)     NOT NULL,
    [ARRefNbr]      CHAR (10)     NOT NULL,
    [AvgWgt]        FLOAT (53)    NULL,
    [BarnNbr]       CHAR (6)      NOT NULL,
    [BaseAcct]      CHAR (10)     NOT NULL,
    [BasePrice]     FLOAT (53)    NOT NULL,
    [BatNbr]        CHAR (10)     NOT NULL,
    [ChkPaidNbr]    CHAR (10)     NOT NULL,
    [ContrNbr]      CHAR (10)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CustId]        CHAR (15)     NOT NULL,
    [DelvCarcCWgt]  FLOAT (53)    NOT NULL,
    [DelvCarcWgt]   FLOAT (53)    NOT NULL,
    [DelvLiveCWgt]  FLOAT (53)    NOT NULL,
    [DelvLiveWgt]   FLOAT (53)    NOT NULL,
    [DepositDate]   SMALLDATETIME NOT NULL,
    [DocType]       CHAR (2)      NOT NULL,
    [GrpReqFlg]     SMALLINT      NOT NULL,
    [HCTot]         SMALLINT      NOT NULL,
    [HeadCount]     SMALLINT      NOT NULL,
    [KillDate]      SMALLDATETIME NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteId]        INT           NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [OrigRefNbr]    CHAR (10)     NOT NULL,
    [PigGroupID]    CHAR (10)     NOT NULL,
    [PkrContactId]  CHAR (6)      NOT NULL,
    [PMLoadId]      CHAR (6)      NOT NULL,
    [Project]       CHAR (16)     NOT NULL,
    [RefNbr]        CHAR (10)     NOT NULL,
    [SaleBasis]     CHAR (2)      NOT NULL,
    [SaleDate]      SMALLDATETIME NOT NULL,
    [SaleTypeId]    CHAR (2)      NOT NULL,
    [SiteContactID] CHAR (6)      NOT NULL,
    [TaskId]        CHAR (32)     NOT NULL,
    [TattooNbr]     CHAR (6)      NOT NULL,
    [TotPigCnt]     SMALLINT      NOT NULL,
    [TrkgPaidFlg]   SMALLINT      NOT NULL,
    [TrkVendID]     CHAR (15)     NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPigSale0] PRIMARY KEY CLUSTERED ([RefNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftPigSalePMID]
    ON [dbo].[cftPigSale]([PMLoadId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftPigSalePigGroup]
    ON [dbo].[cftPigSale]([PigGroupID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IDX_cftpigsale_origRefNbr_incl]
    ON [dbo].[cftPigSale]([OrigRefNbr] ASC)
    INCLUDE([RefNbr]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IDX_cftpigsale_custid_sale_incl]
    ON [dbo].[cftPigSale]([CustId] ASC, [SaleTypeId] ASC, [DocType] ASC, [SaleBasis] ASC, [SaleDate] ASC)
    INCLUDE([HCTot], [KillDate], [PkrContactId], [PMLoadId], [RefNbr], [SiteContactID], [TattooNbr]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftpigsale_cf581_batnbr_incl]
    ON [dbo].[cftPigSale]([BatNbr] ASC, [CustId] ASC, [DocType] ASC)
    INCLUDE([RefNbr], [SaleDate], [SaleTypeId], [TaskId], [TotPigCnt], [OrigRefNbr], [PigGroupID], [Project], [DelvLiveWgt], [HCTot], [PMLoadId]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftpigsale_userqry]
    ON [dbo].[cftPigSale]([ContrNbr] ASC, [KillDate] ASC, [PkrContactId] ASC, [TattooNbr] ASC, [ARRefNbr] ASC, [DocType] ASC)
    INCLUDE([RefNbr]) WITH (FILLFACTOR = 100);

