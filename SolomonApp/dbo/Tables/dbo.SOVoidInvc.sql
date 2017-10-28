CREATE TABLE [dbo].[SOVoidInvc] (
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_SOVoidInvc_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SOVoidInvc_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_SOVoidInvc_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_SOVoidInvc_Crtd_User] DEFAULT (' ') NOT NULL,
    [InvcNbr]        CHAR (15)     CONSTRAINT [DF_SOVoidInvc_InvcNbr] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SOVoidInvc_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_SOVoidInvc_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_SOVoidInvc_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_SOVoidInvc_NoteID] DEFAULT ((0)) NOT NULL,
    [ReportName]     CHAR (30)     CONSTRAINT [DF_SOVoidInvc_ReportName] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_SOVoidInvc_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_SOVoidInvc_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_SOVoidInvc_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_SOVoidInvc_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_SOVoidInvc_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_SOVoidInvc_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_SOVoidInvc_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_SOVoidInvc_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_SOVoidInvc_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_SOVoidInvc_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_SOVoidInvc_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_SOVoidInvc_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipRegisterID] CHAR (10)     CONSTRAINT [DF_SOVoidInvc_ShipRegisterID] DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_SOVoidInvc_User1] DEFAULT (' ') NOT NULL,
    [User10]         SMALLDATETIME CONSTRAINT [DF_SOVoidInvc_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_SOVoidInvc_User2] DEFAULT (' ') NOT NULL,
    [User3]          CHAR (30)     CONSTRAINT [DF_SOVoidInvc_User3] DEFAULT (' ') NOT NULL,
    [User4]          CHAR (30)     CONSTRAINT [DF_SOVoidInvc_User4] DEFAULT (' ') NOT NULL,
    [User5]          FLOAT (53)    CONSTRAINT [DF_SOVoidInvc_User5] DEFAULT ((0)) NOT NULL,
    [User6]          FLOAT (53)    CONSTRAINT [DF_SOVoidInvc_User6] DEFAULT ((0)) NOT NULL,
    [User7]          CHAR (10)     CONSTRAINT [DF_SOVoidInvc_User7] DEFAULT (' ') NOT NULL,
    [User8]          CHAR (10)     CONSTRAINT [DF_SOVoidInvc_User8] DEFAULT (' ') NOT NULL,
    [User9]          SMALLDATETIME CONSTRAINT [DF_SOVoidInvc_User9] DEFAULT ('01/01/1900') NOT NULL,
    [VoidType]       CHAR (1)      CONSTRAINT [DF_SOVoidInvc_VoidType] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [SOVoidInvc0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [ReportName] ASC, [InvcNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [SOVoidInvc1]
    ON [dbo].[SOVoidInvc]([ShipRegisterID] ASC) WITH (FILLFACTOR = 90);

