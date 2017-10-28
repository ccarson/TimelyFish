CREATE TABLE [dbo].[ItemXRef] (
    [AlternateID]   CHAR (30)     CONSTRAINT [DF_ItemXRef_AlternateID] DEFAULT (' ') NOT NULL,
    [AltIDType]     CHAR (1)      CONSTRAINT [DF_ItemXRef_AltIDType] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_ItemXRef_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_ItemXRef_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_ItemXRef_Crtd_User] DEFAULT (' ') NOT NULL,
    [Descr]         CHAR (60)     CONSTRAINT [DF_ItemXRef_Descr] DEFAULT (' ') NOT NULL,
    [EntityID]      CHAR (15)     CONSTRAINT [DF_ItemXRef_EntityID] DEFAULT (' ') NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_ItemXRef_InvtID] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_ItemXRef_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_ItemXRef_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_ItemXRef_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_ItemXRef_NoteID] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_ItemXRef_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_ItemXRef_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_ItemXRef_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_ItemXRef_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_ItemXRef_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_ItemXRef_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_ItemXRef_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_ItemXRef_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_ItemXRef_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_ItemXRef_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_ItemXRef_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_ItemXRef_S4Future12] DEFAULT (' ') NOT NULL,
    [Sequence]      SMALLINT      CONSTRAINT [DF_ItemXRef_Sequence] DEFAULT ((0)) NOT NULL,
    [Unit]          CHAR (6)      CONSTRAINT [DF_ItemXRef_Unit] DEFAULT (' ') NOT NULL,
    [UnitPrice]     FLOAT (53)    CONSTRAINT [DF_ItemXRef_UnitPrice] DEFAULT ((0)) NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_ItemXRef_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_ItemXRef_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_ItemXRef_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_ItemXRef_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_ItemXRef_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_ItemXRef_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_ItemXRef_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_ItemXRef_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [ItemXRef0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [AltIDType] ASC, [EntityID] ASC, [AlternateID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [ItemXRef1]
    ON [dbo].[ItemXRef]([EntityID] ASC, [AltIDType] ASC, [InvtID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemXRef2]
    ON [dbo].[ItemXRef]([AlternateID] ASC, [AltIDType] ASC, [EntityID] ASC) WITH (FILLFACTOR = 90);

