CREATE TABLE [dbo].[RQBudRptWrk] (
    [Acct]       CHAR (10)     NOT NULL,
    [CommitAmt]  FLOAT (53)    NOT NULL,
    [Descr]      CHAR (60)     NOT NULL,
    [ReqCntr]    CHAR (2)      NOT NULL,
    [ReqNbr]     CHAR (10)     NOT NULL,
    [S4Future1]  CHAR (30)     NOT NULL,
    [S4Future2]  CHAR (30)     NOT NULL,
    [S4Future3]  FLOAT (53)    NOT NULL,
    [S4Future4]  FLOAT (53)    NOT NULL,
    [S4Future5]  FLOAT (53)    NOT NULL,
    [S4Future6]  FLOAT (53)    NOT NULL,
    [S4Future7]  SMALLDATETIME NOT NULL,
    [S4Future8]  SMALLDATETIME NOT NULL,
    [S4Future9]  INT           NOT NULL,
    [S4Future10] INT           NOT NULL,
    [S4Future11] CHAR (10)     NOT NULL,
    [S4Future12] CHAR (10)     NOT NULL,
    [SeqNbr]     CHAR (4)      NOT NULL,
    [Sub]        CHAR (24)     NOT NULL,
    [User1]      CHAR (30)     NOT NULL,
    [User2]      CHAR (30)     NOT NULL,
    [User3]      FLOAT (53)    NOT NULL,
    [User4]      FLOAT (53)    NOT NULL,
    [User5]      CHAR (10)     NOT NULL,
    [User6]      CHAR (10)     NOT NULL,
    [User7]      SMALLDATETIME NOT NULL,
    [User8]      SMALLDATETIME NOT NULL,
    [VendID]     CHAR (15)     NOT NULL,
    [VendName]   CHAR (60)     NOT NULL,
    [tstamp]     ROWVERSION    NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQBudRptWrk0]
    ON [dbo].[RQBudRptWrk]([ReqNbr] ASC, [ReqCntr] ASC, [SeqNbr] ASC);

