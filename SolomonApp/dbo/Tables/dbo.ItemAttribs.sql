CREATE TABLE [dbo].[ItemAttribs] (
    [Attrib00]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib00] DEFAULT (' ') NOT NULL,
    [Attrib01]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib01] DEFAULT (' ') NOT NULL,
    [Attrib02]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib02] DEFAULT (' ') NOT NULL,
    [Attrib03]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib03] DEFAULT (' ') NOT NULL,
    [Attrib04]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib04] DEFAULT (' ') NOT NULL,
    [Attrib05]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib05] DEFAULT (' ') NOT NULL,
    [Attrib06]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib06] DEFAULT (' ') NOT NULL,
    [Attrib07]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib07] DEFAULT (' ') NOT NULL,
    [Attrib08]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib08] DEFAULT (' ') NOT NULL,
    [Attrib09]      CHAR (10)     CONSTRAINT [DF_ItemAttribs_Attrib09] DEFAULT (' ') NOT NULL,
    [ClassID]       CHAR (10)     CONSTRAINT [DF_ItemAttribs_ClassID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_ItemAttribs_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_ItemAttribs_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_ItemAttribs_Crtd_User] DEFAULT (' ') NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_ItemAttribs_InvtID] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_ItemAttribs_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_ItemAttribs_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_ItemAttribs_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_ItemAttribs_NoteID] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_ItemAttribs_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_ItemAttribs_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_ItemAttribs_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_ItemAttribs_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_ItemAttribs_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_ItemAttribs_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_ItemAttribs_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_ItemAttribs_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_ItemAttribs_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_ItemAttribs_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_ItemAttribs_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_ItemAttribs_S4Future12] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_ItemAttribs_User1] DEFAULT (' ') NOT NULL,
    [User10]        SMALLDATETIME CONSTRAINT [DF_ItemAttribs_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_ItemAttribs_User2] DEFAULT (' ') NOT NULL,
    [User3]         CHAR (30)     CONSTRAINT [DF_ItemAttribs_User3] DEFAULT (' ') NOT NULL,
    [User4]         CHAR (30)     CONSTRAINT [DF_ItemAttribs_User4] DEFAULT (' ') NOT NULL,
    [User5]         FLOAT (53)    CONSTRAINT [DF_ItemAttribs_User5] DEFAULT ((0)) NOT NULL,
    [User6]         FLOAT (53)    CONSTRAINT [DF_ItemAttribs_User6] DEFAULT ((0)) NOT NULL,
    [User7]         CHAR (10)     CONSTRAINT [DF_ItemAttribs_User7] DEFAULT (' ') NOT NULL,
    [User8]         CHAR (10)     CONSTRAINT [DF_ItemAttribs_User8] DEFAULT (' ') NOT NULL,
    [User9]         SMALLDATETIME CONSTRAINT [DF_ItemAttribs_User9] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [ItemAttribs0] PRIMARY KEY CLUSTERED ([InvtID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs1]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib00] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs10]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib09] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs2]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib01] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs3]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib02] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs4]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib03] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs5]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib04] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs6]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib05] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs7]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib06] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs8]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib07] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [ItemAttribs9]
    ON [dbo].[ItemAttribs]([ClassID] ASC, [Attrib08] ASC) WITH (FILLFACTOR = 90);

