CREATE TABLE [dbo].[PurOrdLSDet] (
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_PurOrdLSDet_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_PurOrdLSDet_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_PurOrdLSDet_Crtd_User] DEFAULT (' ') NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_PurOrdLSDet_InvtID] DEFAULT (' ') NOT NULL,
    [LineID]        INT           CONSTRAINT [DF_PurOrdLSDet_LineID] DEFAULT ((0)) NOT NULL,
    [LineNbr]       SMALLINT      CONSTRAINT [DF_PurOrdLSDet_LineNbr] DEFAULT ((0)) NOT NULL,
    [LineRef]       CHAR (5)      CONSTRAINT [DF_PurOrdLSDet_LineRef] DEFAULT (' ') NOT NULL,
    [LotSerNbr]     CHAR (25)     CONSTRAINT [DF_PurOrdLSDet_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_PurOrdLSDet_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_PurOrdLSDet_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_PurOrdLSDet_LUpd_User] DEFAULT (' ') NOT NULL,
    [MfgrLotSerNbr] CHAR (25)     CONSTRAINT [DF_PurOrdLSDet_MfgrLotSerNbr] DEFAULT (' ') NOT NULL,
    [PONbr]         CHAR (10)     CONSTRAINT [DF_PurOrdLSDet_PONbr] DEFAULT (' ') NOT NULL,
    [Qty]           FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_Qty] DEFAULT ((0)) NOT NULL,
    [QtyRcvd]       FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_QtyRcvd] DEFAULT ((0)) NOT NULL,
    [QtyReturned]   FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_QtyReturned] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_PurOrdLSDet_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_PurOrdLSDet_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_PurOrdLSDet_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_PurOrdLSDet_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_PurOrdLSDet_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_PurOrdLSDet_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_PurOrdLSDet_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_PurOrdLSDet_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_PurOrdLSDet_SiteID] DEFAULT (' ') NOT NULL,
    [Status]        CHAR (1)      CONSTRAINT [DF_PurOrdLSDet_Status] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_PurOrdLSDet_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_PurOrdLSDet_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_PurOrdLSDet_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_PurOrdLSDet_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_PurOrdLSDet_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_PurOrdLSDet_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_PurOrdLSDet_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [PurOrdLSDet0] PRIMARY KEY CLUSTERED ([PONbr] ASC, [LineID] ASC, [MfgrLotSerNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PurOrdLSDet1]
    ON [dbo].[PurOrdLSDet]([PONbr] ASC, [LineID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PurOrdLSDet2]
    ON [dbo].[PurOrdLSDet]([PONbr] ASC, [LineID] ASC, [InvtID] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PurOrdLSDet3]
    ON [dbo].[PurOrdLSDet]([InvtID] ASC, [SiteID] ASC, [LotSerNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PurOrdLSDet4]
    ON [dbo].[PurOrdLSDet]([InvtID] ASC, [SiteID] ASC, [MfgrLotSerNbr] ASC) WITH (FILLFACTOR = 90);

