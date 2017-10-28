CREATE TABLE [dbo].[PGList] (
    [ECD]        SMALLDATETIME NOT NULL,
    [ESD]        SMALLDATETIME NOT NULL,
    [PigGroupID] CHAR (10)     NOT NULL,
    [Status]     CHAR (2)      NOT NULL,
    [tstamp]     ROWVERSION    NOT NULL,
    CONSTRAINT [PGList0] PRIMARY KEY CLUSTERED ([PigGroupID] ASC) WITH (FILLFACTOR = 90)
);

