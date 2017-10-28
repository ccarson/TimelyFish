CREATE TABLE [stage].[DataStoreGenetics] (
    [GeneticsKey] BIGINT        NOT NULL,
    [SourceGUID]  NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_DataStoreGenetics] PRIMARY KEY CLUSTERED ([GeneticsKey] ASC)
);

