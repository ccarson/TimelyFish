CREATE TABLE [dbo].[TrnsfrDoc] (
    [BatNbr]        CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_BatNbr] DEFAULT (' ') NOT NULL,
    [Comment]       CHAR (30)     CONSTRAINT [DF_TrnsfrDoc_Comment] DEFAULT (' ') NOT NULL,
    [CostBatNbr]    CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_CostBatNbr] DEFAULT (' ') NOT NULL,
    [CpnyID]        CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_TrnsfrDoc_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_Crtd_User] DEFAULT (' ') NOT NULL,
    [ExpectedDate]  SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_ExpectedDate] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_TrnsfrDoc_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_TrnsfrDoc_NoteID] DEFAULT ((0)) NOT NULL,
    [RcptBatNbr]    CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_RcptBatNbr] DEFAULT (' ') NOT NULL,
    [RcptDate]      SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_RcptDate] DEFAULT ('01/01/1900') NOT NULL,
    [RcptNbr]       CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_RcptNbr] DEFAULT (' ') NOT NULL,
    [RefNbr]        CHAR (15)     CONSTRAINT [DF_TrnsfrDoc_RefNbr] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_TrnsfrDoc_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_TrnsfrDoc_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_TrnsfrDoc_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_TrnsfrDoc_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_TrnsfrDoc_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_TrnsfrDoc_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_TrnsfrDoc_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_TrnsfrDoc_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipperID]     CHAR (15)     CONSTRAINT [DF_TrnsfrDoc_ShipperID] DEFAULT (' ') NOT NULL,
    [ShipViaID]     CHAR (15)     CONSTRAINT [DF_TrnsfrDoc_ShipViaID] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_SiteID] DEFAULT (' ') NOT NULL,
    [Source]        CHAR (2)      CONSTRAINT [DF_TrnsfrDoc_Source] DEFAULT (' ') NOT NULL,
    [Status]        CHAR (1)      CONSTRAINT [DF_TrnsfrDoc_Status] DEFAULT (' ') NOT NULL,
    [ToSiteID]      CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_ToSiteID] DEFAULT (' ') NOT NULL,
    [TranDate]      SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [TransferType]  CHAR (1)      CONSTRAINT [DF_TrnsfrDoc_TransferType] DEFAULT (' ') NOT NULL,
    [TrnsfrDocNbr]  CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_TrnsfrDocNbr] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_TrnsfrDoc_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_TrnsfrDoc_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_TrnsfrDoc_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_TrnsfrDoc_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_TrnsfrDoc_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_TrnsfrDoc_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [TrnsfrDoc0] PRIMARY KEY CLUSTERED ([TrnsfrDocNbr] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [TrnsfrDoc1]
    ON [dbo].[TrnsfrDoc]([CpnyID] ASC, [BatNbr] ASC, [TrnsfrDocNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [TrnsfrDoc2]
    ON [dbo].[TrnsfrDoc]([TrnsfrDocNbr] ASC, [BatNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [TrnsfrDoc3]
    ON [dbo].[TrnsfrDoc]([S4Future11] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [TrnsfrDoc4]
    ON [dbo].[TrnsfrDoc]([TransferType] ASC, [Source] ASC, [Status] ASC) WITH (FILLFACTOR = 90);

