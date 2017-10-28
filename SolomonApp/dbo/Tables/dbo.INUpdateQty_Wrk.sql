CREATE TABLE [dbo].[INUpdateQty_Wrk] (
    [ComputerName]   CHAR (21)     CONSTRAINT [DF_INUpdateQty_Wrk_ComputerName] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_INUpdateQty_Wrk_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_INUpdateQty_Wrk_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_INUpdateQty_Wrk_Crtd_User] DEFAULT (' ') NOT NULL,
    [InvtID]         CHAR (30)     CONSTRAINT [DF_INUpdateQty_Wrk_InvtID] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_INUpdateQty_Wrk_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_INUpdateQty_Wrk_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_INUpdateQty_Wrk_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_INUpdateQty_Wrk_NoteID] DEFAULT ((0)) NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_INUpdateQty_Wrk_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_INUpdateQty_Wrk_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_INUpdateQty_Wrk_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_INUpdateQty_Wrk_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_INUpdateQty_Wrk_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_INUpdateQty_Wrk_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_INUpdateQty_Wrk_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_INUpdateQty_Wrk_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_INUpdateQty_Wrk_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_INUpdateQty_Wrk_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_INUpdateQty_Wrk_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_INUpdateQty_Wrk_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]         CHAR (10)     CONSTRAINT [DF_INUpdateQty_Wrk_SiteID] DEFAULT (' ') NOT NULL,
    [UpdatePO]       SMALLINT      CONSTRAINT [DF_INUpdateQty_Wrk_UpdatePO] DEFAULT ((0)) NOT NULL,
    [UpdateSO]       SMALLINT      CONSTRAINT [DF_INUpdateQty_Wrk_UpdateSO] DEFAULT ((0)) NOT NULL,
    [UpdateWODemand] SMALLINT      CONSTRAINT [DF_INUpdateQty_Wrk_UpdateWODemand] DEFAULT ((0)) NOT NULL,
    [UpdateWOSupply] SMALLINT      CONSTRAINT [DF_INUpdateQty_Wrk_UpdateWOSupply] DEFAULT ((0)) NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_INUpdateQty_Wrk_User1] DEFAULT (' ') NOT NULL,
    [User10]         SMALLDATETIME CONSTRAINT [DF_INUpdateQty_Wrk_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_INUpdateQty_Wrk_User2] DEFAULT (' ') NOT NULL,
    [User3]          CHAR (30)     CONSTRAINT [DF_INUpdateQty_Wrk_User3] DEFAULT (' ') NOT NULL,
    [User4]          CHAR (30)     CONSTRAINT [DF_INUpdateQty_Wrk_User4] DEFAULT (' ') NOT NULL,
    [User5]          FLOAT (53)    CONSTRAINT [DF_INUpdateQty_Wrk_User5] DEFAULT ((0)) NOT NULL,
    [User6]          FLOAT (53)    CONSTRAINT [DF_INUpdateQty_Wrk_User6] DEFAULT ((0)) NOT NULL,
    [User7]          CHAR (10)     CONSTRAINT [DF_INUpdateQty_Wrk_User7] DEFAULT (' ') NOT NULL,
    [User8]          CHAR (10)     CONSTRAINT [DF_INUpdateQty_Wrk_User8] DEFAULT (' ') NOT NULL,
    [User9]          SMALLDATETIME CONSTRAINT [DF_INUpdateQty_Wrk_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [INUpdateQty_Wrk0] PRIMARY KEY CLUSTERED ([ComputerName] ASC, [InvtID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [INUpdateQty_Wrk1]
    ON [dbo].[INUpdateQty_Wrk]([InvtID] ASC, [SiteID] ASC, [UpdateWODemand] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INUpdateQty_Wrk2]
    ON [dbo].[INUpdateQty_Wrk]([UpdateWODemand] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INUpdateQty_Wrk3]
    ON [dbo].[INUpdateQty_Wrk]([UpdateSO] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INUpdateQty_Wrk4]
    ON [dbo].[INUpdateQty_Wrk]([UpdatePO] ASC) WITH (FILLFACTOR = 90);

