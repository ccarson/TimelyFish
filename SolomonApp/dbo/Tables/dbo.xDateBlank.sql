CREATE TABLE [dbo].[xDateBlank] (
    [DateBlank] SMALLDATETIME NOT NULL,
    [tstamp]    ROWVERSION    NOT NULL,
    CONSTRAINT [xDateBlank0] PRIMARY KEY CLUSTERED ([DateBlank] ASC) WITH (FILLFACTOR = 90)
);

