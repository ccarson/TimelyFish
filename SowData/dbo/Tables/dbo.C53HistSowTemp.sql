CREATE TABLE [dbo].[C53HistSowTemp] (
    [SowID]        VARCHAR (12) NOT NULL,
    [MaxGroupDate] VARCHAR (6)  NOT NULL,
    [RemovalDate]  VARCHAR (6)  NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [C53HistSowTemp0]
    ON [dbo].[C53HistSowTemp]([SowID] ASC) WITH (FILLFACTOR = 90);

