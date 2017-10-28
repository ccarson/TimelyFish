CREATE TABLE [dimension].[SiteAnimal] (
    [SiteAnimalKey]		BIGINT          NOT NULL	IDENTITY	PRIMARY KEY CLUSTERED ,
    [AnimalKey]			BIGINT          NOT NULL,
    [SiteKey]			BIGINT          NOT NULL,
    [EntryDateKey]		INT				NOT NULL, 
	RemovalDateKey		INT				NOT NULL	DEFAULT 19700101 ,
    [CreatedDate]		DATETIME        DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]			BIGINT          DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]		DATETIME        DEFAULT (getutcdate()) NOT NULL,
    [UpdatedBy]			BIGINT          DEFAULT ((-1)) NOT NULL,
    [SourceCode]		NVARCHAR (20)   DEFAULT (N'PigCHAMP') NOT NULL,
    [SourceID]			INT				NOT NULL, 
    [SourceGUID]		UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL 
) ;

GO
ALTER TABLE [dimension].[SiteAnimal] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);



