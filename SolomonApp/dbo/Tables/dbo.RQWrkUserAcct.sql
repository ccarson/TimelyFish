CREATE TABLE [dbo].[RQWrkUserAcct] (
    [RI_ID]       SMALLINT   NOT NULL,
    [UserID]      CHAR (47)  NOT NULL,
    [UserName]    CHAR (30)  NOT NULL,
    [Acct]        CHAR (10)  NOT NULL,
    [Description] CHAR (30)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQWrkUserAcct0]
    ON [dbo].[RQWrkUserAcct]([UserID] ASC, [Acct] ASC);

