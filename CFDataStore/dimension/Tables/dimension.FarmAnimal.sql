CREATE TABLE [dimension].[FarmAnimal] (
    [FarmAnimalKey]			BIGINT			IDENTITY (1, 1) NOT NULL,
    [AnimalKey]				BIGINT			NOT NULL,
    [FarmKey]				BIGINT			NOT NULL,
    [EntryDateKey]			INT				NOT NULL,
    [RemovalDateKey]		INT				NULL,
    [CreatedDate]			DATETIME		DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]				BIGINT			DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
	[SourceCode]		NVARCHAR (20) NOT NULL ,
    [EntrySourceID]			INT				NOT NULL,
    [EntrySourceGUID]		NVARCHAR(36)	NOT NULL,
    [RemovalSourceID]		INT				NULL,
    [RemovalSourceGUID]		NVARCHAR(36)	NULL,
    [SourceID]				INT				NOT NULL,
    [SourceGUID]			NVARCHAR(36)	NOT NULL,

CONSTRAINT [PK_dimension_FarmAnimal] PRIMARY KEY CLUSTERED ([FarmAnimalKey] ASC)
);
GO

CREATE NONCLUSTERED INDEX UX_FarmAnimal_01 
	ON dimension.FarmAnimal( FarmKey, AnimalKey )
GO

CREATE NONCLUSTERED INDEX UX_FarmAnimal_02
	ON dimension.FarmAnimal( AnimalKey, FarmKey )
GO

ALTER TABLE [dimension].[FarmAnimal] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);



