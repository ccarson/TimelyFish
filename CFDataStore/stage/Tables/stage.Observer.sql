CREATE TABLE [stage].[Observer] (
    [ObserverKey] BIGINT        NOT NULL,
    [SourceGUID]  NVARCHAR (36) NOT NULL,
    CONSTRAINT [pk_Observer] PRIMARY KEY CLUSTERED ([ObserverKey] ASC)
);

