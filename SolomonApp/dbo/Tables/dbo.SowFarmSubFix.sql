CREATE TABLE [dbo].[SowFarmSubFix] (
    [OldSubAcct] VARCHAR (24) NOT NULL,
    [NewSubAcct] VARCHAR (24) NOT NULL,
    CONSTRAINT [PK_SowFarmSubFix] PRIMARY KEY CLUSTERED ([OldSubAcct] ASC, [NewSubAcct] ASC) WITH (FILLFACTOR = 90)
);

