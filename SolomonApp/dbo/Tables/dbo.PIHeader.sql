CREATE TABLE [dbo].[PIHeader] (
    [ControlQty]     FLOAT (53)    CONSTRAINT [DF_PIHeader_ControlQty] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_PIHeader_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_PIHeader_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_PIHeader_Crtd_User] DEFAULT (' ') NOT NULL,
    [DateFreeze]     SMALLDATETIME CONSTRAINT [DF_PIHeader_DateFreeze] DEFAULT ('01/01/1900') NOT NULL,
    [Descr]          CHAR (30)     CONSTRAINT [DF_PIHeader_Descr] DEFAULT (' ') NOT NULL,
    [FNumber]        INT           CONSTRAINT [DF_PIHeader_FNumber] DEFAULT ((0)) NOT NULL,
    [LineCntr]       INT           CONSTRAINT [DF_PIHeader_LineCntr] DEFAULT ((0)) NOT NULL,
    [LNumber]        INT           CONSTRAINT [DF_PIHeader_LNumber] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_PIHeader_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_PIHeader_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_PIHeader_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_PIHeader_NoteID] DEFAULT ((0)) NOT NULL,
    [Numbered]       SMALLINT      CONSTRAINT [DF_PIHeader_Numbered] DEFAULT ((0)) NOT NULL,
    [PerClosed]      CHAR (6)      CONSTRAINT [DF_PIHeader_PerClosed] DEFAULT (' ') NOT NULL,
    [PhysAdjVarAcct] CHAR (10)     CONSTRAINT [DF_PIHeader_PhysAdjVarAcct] DEFAULT (' ') NOT NULL,
    [PhysAdjVarSub]  CHAR (24)     CONSTRAINT [DF_PIHeader_PhysAdjVarSub] DEFAULT (' ') NOT NULL,
    [PIID]           CHAR (10)     CONSTRAINT [DF_PIHeader_PIID] DEFAULT (' ') NOT NULL,
    [PITagType]      CHAR (1)      CONSTRAINT [DF_PIHeader_PITagType] DEFAULT (' ') NOT NULL,
    [PIType]         CHAR (1)      CONSTRAINT [DF_PIHeader_PIType] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_PIHeader_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_PIHeader_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_PIHeader_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_PIHeader_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_PIHeader_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_PIHeader_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_PIHeader_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_PIHeader_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_PIHeader_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_PIHeader_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_PIHeader_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_PIHeader_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]         CHAR (10)     CONSTRAINT [DF_PIHeader_SiteID] DEFAULT (' ') NOT NULL,
    [Status]         CHAR (1)      CONSTRAINT [DF_PIHeader_Status] DEFAULT (' ') NOT NULL,
    [TNumber]        INT           CONSTRAINT [DF_PIHeader_TNumber] DEFAULT ((0)) NOT NULL,
    [TotBookAmt]     FLOAT (53)    CONSTRAINT [DF_PIHeader_TotBookAmt] DEFAULT ((0)) NOT NULL,
    [TotBookQty]     FLOAT (53)    CONSTRAINT [DF_PIHeader_TotBookQty] DEFAULT ((0)) NOT NULL,
    [TotVarAmt]      FLOAT (53)    CONSTRAINT [DF_PIHeader_TotVarAmt] DEFAULT ((0)) NOT NULL,
    [TotVarQty]      FLOAT (53)    CONSTRAINT [DF_PIHeader_TotVarQty] DEFAULT ((0)) NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_PIHeader_User1] DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_PIHeader_User2] DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    CONSTRAINT [DF_PIHeader_User3] DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    CONSTRAINT [DF_PIHeader_User4] DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     CONSTRAINT [DF_PIHeader_User5] DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     CONSTRAINT [DF_PIHeader_User6] DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME CONSTRAINT [DF_PIHeader_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME CONSTRAINT [DF_PIHeader_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [PIHeader0] PRIMARY KEY CLUSTERED ([PIID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PIHeader1]
    ON [dbo].[PIHeader]([SiteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PIHeader2]
    ON [dbo].[PIHeader]([NoteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PIHeader3]
    ON [dbo].[PIHeader]([Status] ASC) WITH (FILLFACTOR = 90);

