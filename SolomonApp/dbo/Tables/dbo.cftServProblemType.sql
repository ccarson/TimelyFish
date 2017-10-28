CREATE TABLE [dbo].[cftServProblemType] (
    [Descr]         CHAR (30)  NULL,
    [ProblemTypeID] CHAR (5)   NOT NULL,
    [tstamp]        ROWVERSION NULL,
    CONSTRAINT [cftServProblemType0] PRIMARY KEY CLUSTERED ([ProblemTypeID] ASC) WITH (FILLFACTOR = 90)
);

