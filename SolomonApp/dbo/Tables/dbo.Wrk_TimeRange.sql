CREATE TABLE [dbo].[Wrk_TimeRange] (
    [FiscYr]      CHAR (4)  NOT NULL,
    [UserAddress] CHAR (21) NOT NULL,
    CONSTRAINT [Wrk_TimeRange0] PRIMARY KEY NONCLUSTERED ([UserAddress] ASC, [FiscYr] ASC) WITH (FILLFACTOR = 90)
);

