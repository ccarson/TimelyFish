CREATE TABLE [dbo].[MAS90FiscPer] (
    [FiscYr]    CHAR (4)      NOT NULL,
    [PerNbr]    CHAR (2)      NOT NULL,
    [StartDate] SMALLDATETIME NOT NULL,
    [EndDate]   SMALLDATETIME NOT NULL,
    [tstamp]    ROWVERSION    NULL,
    CONSTRAINT [PK_MAS90FiscPer] PRIMARY KEY CLUSTERED ([FiscYr] ASC, [PerNbr] ASC) WITH (FILLFACTOR = 90)
);

