CREATE TABLE [dbo].[POProjAuth] (
    [AddUnderDefer] CHAR (1)      CONSTRAINT [DF_POProjAuth_AddUnderDefer] DEFAULT (' ') NOT NULL,
    [Authority]     CHAR (2)      CONSTRAINT [DF_POProjAuth_Authority] DEFAULT (' ') NOT NULL,
    [Budgeted]      CHAR (1)      CONSTRAINT [DF_POProjAuth_Budgeted] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_POProjAuth_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_POProjAuth_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_POProjAuth_Crtd_User] DEFAULT (' ') NOT NULL,
    [Descr]         CHAR (30)     CONSTRAINT [DF_POProjAuth_Descr] DEFAULT (' ') NOT NULL,
    [DocType]       CHAR (2)      CONSTRAINT [DF_POProjAuth_DocType] DEFAULT (' ') NOT NULL,
    [EffDate]       SMALLDATETIME CONSTRAINT [DF_POProjAuth_EffDate] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_POProjAuth_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_POProjAuth_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_POProjAuth_LUpd_User] DEFAULT (' ') NOT NULL,
    [Project]       CHAR (16)     CONSTRAINT [DF_POProjAuth_Project] DEFAULT (' ') NOT NULL,
    [RequestType]   CHAR (2)      CONSTRAINT [DF_POProjAuth_RequestType] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_POProjAuth_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_POProjAuth_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_POProjAuth_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_POProjAuth_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_POProjAuth_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_POProjAuth_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_POProjAuth_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_POProjAuth_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_POProjAuth_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_POProjAuth_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_POProjAuth_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_POProjAuth_S4Future12] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_POProjAuth_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_POProjAuth_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_POProjAuth_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_POProjAuth_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_POProjAuth_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_POProjAuth_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_POProjAuth_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_POProjAuth_User8] DEFAULT ('01/01/1900') NOT NULL,
    [UserID]        CHAR (47)     CONSTRAINT [DF_POProjAuth_UserID] DEFAULT (' ') NOT NULL,
    [UserName]      CHAR (30)     CONSTRAINT [DF_POProjAuth_UserName] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [POProjAuth0] PRIMARY KEY CLUSTERED ([Project] ASC, [DocType] ASC, [RequestType] ASC, [Budgeted] ASC, [Authority] ASC, [EffDate] ASC, [UserID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [POProjAuth1]
    ON [dbo].[POProjAuth]([Project] ASC) WITH (FILLFACTOR = 90);

