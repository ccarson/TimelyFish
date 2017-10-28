CREATE TABLE [dbo].[vs_AcctXref] (
    [Acct]     CHAR (10)  NOT NULL,
    [AcctType] CHAR (2)   NULL,
    [Active]   SMALLINT   NOT NULL,
    [CpnyID]   CHAR (10)  NOT NULL,
    [Descr]    CHAR (30)  NULL,
    [User1]    CHAR (30)  NULL,
    [User2]    CHAR (30)  NULL,
    [User3]    FLOAT (53) NOT NULL,
    [User4]    FLOAT (53) NOT NULL,
    [tstamp]   ROWVERSION NOT NULL,
    CONSTRAINT [vs_AcctXRef0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [Acct] ASC) WITH (FILLFACTOR = 90)
);

