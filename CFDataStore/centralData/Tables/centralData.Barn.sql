CREATE TABLE [centralData].[Barn] (
    [BarnKey]      BIGINT           IDENTITY (1, 1) NOT NULL,
    [OtherColumns] NCHAR (10)       NULL,
    [SourceCode]   NVARCHAR (20)    CONSTRAINT [DF__Barn__SourceCode__07C12930] DEFAULT (N'CentralData') NOT NULL,
    [SourceID]     INT              NOT NULL,
    [SourceGUID]   UNIQUEIDENTIFIER CONSTRAINT [DF__Barn__SourceGUID__08B54D69] DEFAULT (newsequentialid()) NOT NULL,
    [SyncStatus]   NVARCHAR (20)    CONSTRAINT [DF_Barn_SyncStatus] DEFAULT (N'To MobileFrame') NOT NULL,
    CONSTRAINT [PK_Barn] PRIMARY KEY CLUSTERED ([BarnKey] ASC)
);



