CREATE TABLE [dbo].[RQItemReqHist] (
    [ApprPath]      CHAR (1)      NOT NULL,
    [Authority]     CHAR (2)      NOT NULL,
    [Comment]       CHAR (60)     NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [Descr]         CHAR (30)     NOT NULL,
    [ItemReqNbr]    CHAR (10)     NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [RowNbr]        SMALLINT      NOT NULL,
    [S4Future1]     CHAR (30)     NOT NULL,
    [S4Future2]     CHAR (30)     NOT NULL,
    [S4Future3]     FLOAT (53)    NOT NULL,
    [S4Future4]     FLOAT (53)    NOT NULL,
    [S4Future5]     FLOAT (53)    NOT NULL,
    [S4Future6]     FLOAT (53)    NOT NULL,
    [S4Future7]     SMALLDATETIME NOT NULL,
    [S4Future8]     SMALLDATETIME NOT NULL,
    [S4Future9]     INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
    [Status]        CHAR (2)      NOT NULL,
    [TranAmt]       FLOAT (53)    NOT NULL,
    [TranDate]      SMALLDATETIME NOT NULL,
    [TranTime]      CHAR (10)     NOT NULL,
    [UniqueID]      CHAR (17)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [UserID]        CHAR (47)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [RQItemReqHist1]
    ON [dbo].[RQItemReqHist]([ItemReqNbr] ASC, [UniqueID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQItemReqHist0]
    ON [dbo].[RQItemReqHist]([ItemReqNbr] ASC, [UniqueID] ASC, [TranDate] ASC, [TranTime] ASC, [UserID] ASC);

