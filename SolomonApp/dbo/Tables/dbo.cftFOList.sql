CREATE TABLE [dbo].[cftFOList] (
    [BarnNbr]       CHAR (6)      NOT NULL,
    [BatNbr]        CHAR (10)     NOT NULL,
    [BinNbr]        CHAR (6)      NOT NULL,
    [CnvFact]       FLOAT (53)    NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DateDel]       SMALLDATETIME NOT NULL,
    [DateReq]       SMALLDATETIME NOT NULL,
    [InvClassId]    CHAR (6)      NOT NULL,
    [InvStkU]       CHAR (6)      NOT NULL,
    [InvtID]        CHAR (30)     NOT NULL,
    [InvtIDDel]     CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MillId]        CHAR (6)      NOT NULL,
    [OrdNbr]        CHAR (10)     NOT NULL,
    [OrdType]       CHAR (2)      NOT NULL,
    [PigGroupID]    CHAR (10)     NOT NULL,
    [project]       CHAR (16)     NOT NULL,
    [Qty]           FLOAT (53)    NOT NULL,
    [QtyDel]        FLOAT (53)    NOT NULL,
    [RefNbr]        CHAR (10)     NOT NULL,
    [Selected]      SMALLINT      NOT NULL,
    [SiteName]      CHAR (30)     NOT NULL,
    [SortOrd]       CHAR (26)     NOT NULL,
    [UOMDel]        CHAR (6)      NOT NULL,
    [UOMOrd]        CHAR (6)      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftFOList0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [RefNbr] ASC, [OrdNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cftFOList1]
    ON [dbo].[cftFOList]([MillId] ASC, [SortOrd] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftFOList_ordnbr]
    ON [dbo].[cftFOList]([OrdNbr] ASC) WITH (FILLFACTOR = 90);

