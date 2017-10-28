CREATE TABLE [dbo].[IRItemUsage] (
    [Crtd_Datetime] SMALLDATETIME CONSTRAINT [DF_IRItemUsage_Crtd_Datetime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_IRItemUsage_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_IRItemUsage_Crtd_User] DEFAULT (' ') NOT NULL,
    [DemActAdjust]  FLOAT (53)    CONSTRAINT [DF_IRItemUsage_DemActAdjust] DEFAULT ((0)) NOT NULL,
    [DemActual]     FLOAT (53)    CONSTRAINT [DF_IRItemUsage_DemActual] DEFAULT ((0)) NOT NULL,
    [DemNonRecur]   FLOAT (53)    CONSTRAINT [DF_IRItemUsage_DemNonRecur] DEFAULT ((0)) NOT NULL,
    [DemOverRide]   FLOAT (53)    CONSTRAINT [DF_IRItemUsage_DemOverRide] DEFAULT ((0)) NOT NULL,
    [DemProjected]  FLOAT (53)    CONSTRAINT [DF_IRItemUsage_DemProjected] DEFAULT ((0)) NOT NULL,
    [DemRolledup]   FLOAT (53)    CONSTRAINT [DF_IRItemUsage_DemRolledup] DEFAULT ((0)) NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_IRItemUsage_InvtID] DEFAULT (' ') NOT NULL,
    [Lupd_Datetime] SMALLDATETIME CONSTRAINT [DF_IRItemUsage_Lupd_Datetime] DEFAULT ('01/01/1900') NOT NULL,
    [Lupd_Prog]     CHAR (8)      CONSTRAINT [DF_IRItemUsage_Lupd_Prog] DEFAULT (' ') NOT NULL,
    [Lupd_User]     CHAR (10)     CONSTRAINT [DF_IRItemUsage_Lupd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_IRItemUsage_NoteID] DEFAULT ((0)) NOT NULL,
    [Period]        CHAR (6)      CONSTRAINT [DF_IRItemUsage_Period] DEFAULT (' ') NOT NULL,
    [Reason]        CHAR (1)      CONSTRAINT [DF_IRItemUsage_Reason] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_IRItemUsage_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_IRItemUsage_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_IRItemUsage_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_IRItemUsage_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_IRItemUsage_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_IRItemUsage_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_IRItemUsage_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_IRItemUsage_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_IRItemUsage_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_IRItemUsage_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_IRItemUsage_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_IRItemUsage_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_IRItemUsage_SiteID] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_IRItemUsage_User1] DEFAULT (' ') NOT NULL,
    [User10]        SMALLDATETIME CONSTRAINT [DF_IRItemUsage_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_IRItemUsage_User2] DEFAULT (' ') NOT NULL,
    [User3]         CHAR (30)     CONSTRAINT [DF_IRItemUsage_User3] DEFAULT (' ') NOT NULL,
    [User4]         CHAR (30)     CONSTRAINT [DF_IRItemUsage_User4] DEFAULT (' ') NOT NULL,
    [User5]         FLOAT (53)    CONSTRAINT [DF_IRItemUsage_User5] DEFAULT ((0)) NOT NULL,
    [User6]         FLOAT (53)    CONSTRAINT [DF_IRItemUsage_User6] DEFAULT ((0)) NOT NULL,
    [User7]         CHAR (10)     CONSTRAINT [DF_IRItemUsage_User7] DEFAULT (' ') NOT NULL,
    [User8]         CHAR (10)     CONSTRAINT [DF_IRItemUsage_User8] DEFAULT (' ') NOT NULL,
    [User9]         SMALLDATETIME CONSTRAINT [DF_IRItemUsage_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [IRItemUsage0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [SiteID] ASC, [Period] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IRItemUsage1]
    ON [dbo].[IRItemUsage]([Period] ASC) WITH (FILLFACTOR = 90);

