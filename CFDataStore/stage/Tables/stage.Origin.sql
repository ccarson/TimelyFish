CREATE TABLE [stage].[Origin] (
    [OriginKey]  BIGINT        NOT NULL,
    [SourceGUID] NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_Origin] PRIMARY KEY CLUSTERED ([OriginKey] ASC)
);

