CREATE TABLE [stage].[MatingGroup] (
    [MatingGroupKey] BIGINT        NOT NULL,
    [SourceGUID]     NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_MatingGroup] PRIMARY KEY CLUSTERED ([MatingGroupKey] ASC)
);

