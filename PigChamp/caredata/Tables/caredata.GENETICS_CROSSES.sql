CREATE TABLE [caredata].[GENETICS_CROSSES] (
    [genetics_id]      INT NOT NULL,
    [sire_genetics_id] INT NULL,
    [dam_genetics_id]  INT NULL,
    CONSTRAINT [FK_GENETICS_CROSSES_GENETICS_0] FOREIGN KEY ([sire_genetics_id]) REFERENCES [caredata].[GENETICS] ([genetics_id]),
    CONSTRAINT [FK_GENETICS_CROSSES_GENETICS_1] FOREIGN KEY ([dam_genetics_id]) REFERENCES [caredata].[GENETICS] ([genetics_id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_GENETICS_CROSSES_0]
    ON [caredata].[GENETICS_CROSSES]([genetics_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_GENETICS_CROSSES_1]
    ON [caredata].[GENETICS_CROSSES]([sire_genetics_id] ASC, [dam_genetics_id] ASC) WITH (FILLFACTOR = 80);

