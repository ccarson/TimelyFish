CREATE TABLE [dbo].[AssyDoc] (
    [BatNbr]         CHAR (10)     CONSTRAINT [DF_AssyDoc_BatNbr] DEFAULT (' ') NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_AssyDoc_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_AssyDoc_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_AssyDoc_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_AssyDoc_Crtd_User] DEFAULT (' ') NOT NULL,
    [Descr]          CHAR (30)     CONSTRAINT [DF_AssyDoc_Descr] DEFAULT (' ') NOT NULL,
    [InBal]          SMALLINT      CONSTRAINT [DF_AssyDoc_InBal] DEFAULT ((0)) NOT NULL,
    [KitCntr]        FLOAT (53)    CONSTRAINT [DF_AssyDoc_KitCntr] DEFAULT ((0)) NOT NULL,
    [KitID]          CHAR (30)     CONSTRAINT [DF_AssyDoc_KitID] DEFAULT (' ') NOT NULL,
    [LotSerCntr]     SMALLINT      CONSTRAINT [DF_AssyDoc_LotSerCntr] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_AssyDoc_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_AssyDoc_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_AssyDoc_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_AssyDoc_NoteID] DEFAULT ((0)) NOT NULL,
    [PerPost]        CHAR (6)      CONSTRAINT [DF_AssyDoc_PerPost] DEFAULT (' ') NOT NULL,
    [RefNbr]         CHAR (15)     CONSTRAINT [DF_AssyDoc_RefNbr] DEFAULT (' ') NOT NULL,
    [Rlsed]          SMALLINT      CONSTRAINT [DF_AssyDoc_Rlsed] DEFAULT ((0)) NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_AssyDoc_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_AssyDoc_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_AssyDoc_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_AssyDoc_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_AssyDoc_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_AssyDoc_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_AssyDoc_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_AssyDoc_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_AssyDoc_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_AssyDoc_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_AssyDoc_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_AssyDoc_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]         CHAR (10)     CONSTRAINT [DF_AssyDoc_SiteID] DEFAULT (' ') NOT NULL,
    [SpecificCostID] CHAR (25)     CONSTRAINT [DF_AssyDoc_SpecificCostID] DEFAULT (' ') NOT NULL,
    [TranDate]       SMALLDATETIME CONSTRAINT [DF_AssyDoc_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_AssyDoc_User1] DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_AssyDoc_User2] DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    CONSTRAINT [DF_AssyDoc_User3] DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    CONSTRAINT [DF_AssyDoc_User4] DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     CONSTRAINT [DF_AssyDoc_User5] DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     CONSTRAINT [DF_AssyDoc_User6] DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME CONSTRAINT [DF_AssyDoc_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME CONSTRAINT [DF_AssyDoc_User8] DEFAULT ('01/01/1900') NOT NULL,
    [WhseLoc]        CHAR (10)     CONSTRAINT [DF_AssyDoc_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [AssyDoc0] PRIMARY KEY CLUSTERED ([KitID] ASC, [RefNbr] ASC, [BatNbr] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AssyDoc1]
    ON [dbo].[AssyDoc]([CpnyID] ASC, [BatNbr] ASC, [KitID] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [AssyDoc2]
    ON [dbo].[AssyDoc]([BatNbr] ASC, [KitID] ASC) WITH (FILLFACTOR = 90);

