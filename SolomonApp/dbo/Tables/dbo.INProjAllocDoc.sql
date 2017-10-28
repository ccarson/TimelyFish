CREATE TABLE [dbo].[INProjAllocDoc] (
    [AllocationType] CHAR (2)      DEFAULT (' ') NOT NULL,
    [CpnyID]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (47)     DEFAULT (' ') NOT NULL,
    [DocDate]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Handling]       CHAR (1)      DEFAULT (' ') NOT NULL,
    [LineCntr]       INT           DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (47)     DEFAULT (' ') NOT NULL,
    [NoteID]         INT           DEFAULT ((0)) NOT NULL,
    [RefNbr]         CHAR (15)     DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [User2]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]          FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [User6]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [User7]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]          SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [INProjAllocDoc0] PRIMARY KEY CLUSTERED ([RefNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [INProjAllocDoc1]
    ON [dbo].[INProjAllocDoc]([RefNbr] ASC, [AllocationType] ASC) WITH (FILLFACTOR = 90);

