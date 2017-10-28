CREATE TABLE [stage].[RemovalEvent] (
    [RemovalEventKey] BIGINT        NOT NULL,
    [FarmAnimalKey]   BIGINT        NOT NULL,
    [SourceGUID]      NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([RemovalEventKey] ASC)
);



