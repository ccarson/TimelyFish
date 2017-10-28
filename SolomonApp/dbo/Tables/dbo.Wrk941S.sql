CREATE TABLE [dbo].[Wrk941S] (
    [ChkDate]      SMALLDATETIME NOT NULL,
    [CpnyID]       CHAR (10)     NOT NULL,
    [FedWithhold]  FLOAT (53)    NOT NULL,
    [FicaWithhold] FLOAT (53)    NOT NULL,
    [UserID]       CHAR (47)     NOT NULL,
    [tstamp]       ROWVERSION    NOT NULL,
    CONSTRAINT [Wrk941S0] PRIMARY KEY CLUSTERED ([UserID] ASC, [ChkDate] ASC) WITH (FILLFACTOR = 90)
);

