CREATE TABLE [stage].[SalesEvent] (
    [SalesEventKey] BIGINT        NOT NULL,
    [FarmAnimalKey] BIGINT        NOT NULL,
    [SourceGUID]    NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([SalesEventKey] ASC)
);



