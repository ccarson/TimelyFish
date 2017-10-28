CREATE TABLE [centralData].[Contact] (
    [ContactKey]    BIGINT           IDENTITY (1, 1) NOT NULL,
    [ContactName]   NVARCHAR (50)    NOT NULL,
    [ContactTypeID] INT              NOT NULL,
    [OtherColumns]  NCHAR (10)       NOT NULL,
    [CreatedDate]   DATETIME         NOT NULL,
    [CreatedBy]     BIGINT           NOT NULL,
    [UpdatedDate]   DATETIME         NULL,
    [UpdatedBy]     BIGINT           NULL,
    [SourceCode]    NVARCHAR (20)    CONSTRAINT [DF__Contact__SourceC__04E4BC85] DEFAULT (N'CentralData') NOT NULL,
    [SourceID]      INT              NOT NULL,
    [SourceGUID]    UNIQUEIDENTIFIER CONSTRAINT [DF__Contact__SourceG__05D8E0BE] DEFAULT (newsequentialid()) NOT NULL,
    [SyncStatus]    NVARCHAR (20)    CONSTRAINT [DF_Contact_SyncStatus] DEFAULT (N'To MobileFrame') NOT NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED ([ContactKey] ASC)
);



