CREATE TABLE [dbo].[RQWrkUserSubAcct] (
    [RI_ID]       SMALLINT   NOT NULL,
    [UserID]      CHAR (47)  NOT NULL,
    [UserName]    CHAR (30)  NOT NULL,
    [SubAcct]     CHAR (24)  NOT NULL,
    [Description] CHAR (30)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQWrkUserSubAcct0]
    ON [dbo].[RQWrkUserSubAcct]([UserID] ASC, [SubAcct] ASC);

