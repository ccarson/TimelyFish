CREATE TABLE [dbo].[POReqHist] (
    [ApprPath]      CHAR (1)      CONSTRAINT [DF_POReqHist_ApprPath] DEFAULT (' ') NOT NULL,
    [Authority]     CHAR (2)      CONSTRAINT [DF_POReqHist_Authority] DEFAULT (' ') NOT NULL,
    [Comment]       CHAR (60)     CONSTRAINT [DF_POReqHist_Comment] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_POReqHist_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_POReqHist_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_POReqHist_Crtd_User] DEFAULT (' ') NOT NULL,
    [Descr]         CHAR (30)     CONSTRAINT [DF_POReqHist_Descr] DEFAULT (' ') NOT NULL,
    [LineID]        SMALLINT      CONSTRAINT [DF_POReqHist_LineID] DEFAULT ((0)) NOT NULL,
    [LineRef]       CHAR (5)      CONSTRAINT [DF_POReqHist_LineRef] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_POReqHist_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_POReqHist_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_POReqHist_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_POReqHist_NoteID] DEFAULT ((0)) NOT NULL,
    [ReqNbr]        CHAR (10)     CONSTRAINT [DF_POReqHist_ReqNbr] DEFAULT (' ') NOT NULL,
    [RowNbr]        SMALLINT      CONSTRAINT [DF_POReqHist_RowNbr] DEFAULT ((0)) NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_POReqHist_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_POReqHist_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_POReqHist_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_POReqHist_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_POReqHist_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_POReqHist_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_POReqHist_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_POReqHist_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_POReqHist_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_POReqHist_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_POReqHist_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_POReqHist_S4Future12] DEFAULT (' ') NOT NULL,
    [Status]        CHAR (2)      CONSTRAINT [DF_POReqHist_Status] DEFAULT (' ') NOT NULL,
    [TranAmt]       FLOAT (53)    CONSTRAINT [DF_POReqHist_TranAmt] DEFAULT ((0)) NOT NULL,
    [TranDate]      SMALLDATETIME CONSTRAINT [DF_POReqHist_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [TranTime]      CHAR (10)     CONSTRAINT [DF_POReqHist_TranTime] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_POReqHist_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_POReqHist_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_POReqHist_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_POReqHist_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_POReqHist_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_POReqHist_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_POReqHist_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_POReqHist_User8] DEFAULT ('01/01/1900') NOT NULL,
    [UserID]        CHAR (47)     CONSTRAINT [DF_POReqHist_UserID] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [POReqHist0] PRIMARY KEY CLUSTERED ([ReqNbr] ASC, [LineRef] ASC, [TranDate] ASC, [TranTime] ASC, [UserID] ASC, [ApprPath] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [POReqHist1]
    ON [dbo].[POReqHist]([ApprPath] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHist2]
    ON [dbo].[POReqHist]([UserID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHist3]
    ON [dbo].[POReqHist]([TranTime] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [POReqHist4]
    ON [dbo].[POReqHist]([TranDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHist5]
    ON [dbo].[POReqHist]([LineRef] ASC) WITH (FILLFACTOR = 100);

