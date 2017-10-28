CREATE TABLE [stage].[Location] (
    [LocationKey] BIGINT        NOT NULL,
    [SourceGUID]  NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationKey] ASC)
);

