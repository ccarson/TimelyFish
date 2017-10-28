CREATE TABLE [dimension].[Observer] (
    [ObserverKey]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [FarmKey]         BIGINT        NOT NULL,
    [ObserverName]    NVARCHAR (50) NULL,
    [ObserverSynonym] NVARCHAR (5)  NULL,
    [IsDisabled]      BIT           NULL,
    [CreatedDate]     DATETIME      CONSTRAINT [DF__Observer__Create__5402595F] DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]       BIGINT        CONSTRAINT [DF__Observer__Create__54F67D98] DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]     DATETIME      NULL,
    [UpdatedBy]       BIGINT        NULL,
    [DeletedDate]     DATETIME      NULL,
    [DeletedBy]       BIGINT        NULL,
    [SourceCode]      NVARCHAR (20) NOT NULL,
    [SourceID]        INT           NOT NULL,
    [SourceGUID]      NVARCHAR (36) NOT NULL,
    CONSTRAINT [pk_Observer] PRIMARY KEY CLUSTERED ([ObserverKey] ASC)
);
