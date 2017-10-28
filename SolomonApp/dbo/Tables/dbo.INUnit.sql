CREATE TABLE [dbo].[INUnit] (
    [ClassID]       CHAR (6)      CONSTRAINT [DF_INUnit_ClassID] DEFAULT (' ') NOT NULL,
    [CnvFact]       FLOAT (53)    CONSTRAINT [DF_INUnit_CnvFact] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_INUnit_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_INUnit_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_INUnit_Crtd_User] DEFAULT (' ') NOT NULL,
    [FromUnit]      CHAR (6)      CONSTRAINT [DF_INUnit_FromUnit] DEFAULT (' ') NOT NULL,
    [InvtId]        CHAR (30)     CONSTRAINT [DF_INUnit_InvtId] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_INUnit_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_INUnit_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_INUnit_LUpd_User] DEFAULT (' ') NOT NULL,
    [MultDiv]       CHAR (1)      CONSTRAINT [DF_INUnit_MultDiv] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_INUnit_NoteID] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_INUnit_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_INUnit_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_INUnit_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_INUnit_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_INUnit_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_INUnit_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_INUnit_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_INUnit_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_INUnit_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_INUnit_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_INUnit_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_INUnit_S4Future12] DEFAULT (' ') NOT NULL,
    [ToUnit]        CHAR (6)      CONSTRAINT [DF_INUnit_ToUnit] DEFAULT (' ') NOT NULL,
    [UnitType]      CHAR (1)      CONSTRAINT [DF_INUnit_UnitType] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_INUnit_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_INUnit_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_INUnit_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_INUnit_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_INUnit_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_INUnit_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_INUnit_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_INUnit_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [INUnit0] PRIMARY KEY CLUSTERED ([UnitType] ASC, [ClassID] ASC, [InvtId] ASC, [FromUnit] ASC, [ToUnit] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [INUnit1]
    ON [dbo].[INUnit]([ToUnit] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INUnit2]
    ON [dbo].[INUnit]([FromUnit] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INUnit3]
    ON [dbo].[INUnit]([InvtId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INUnit4]
    ON [dbo].[INUnit]([ClassID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [INUnit5]
    ON [dbo].[INUnit]([NoteID] ASC) WITH (FILLFACTOR = 90);

