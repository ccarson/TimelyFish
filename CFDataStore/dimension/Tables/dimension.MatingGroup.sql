CREATE TABLE [dimension].[MatingGroup] (
    [MatingGroupKey] BIGINT        IDENTITY (1, 1) NOT NULL,
    [MatingGroup]    NVARCHAR (10) NOT NULL,
    [StartDateKey]   INT           NOT NULL,
	[EndDateKey]	 INT           NOT NULL,
    [CreatedDate]    DATETIME      DEFAULT (getdate()) NOT NULL,
    [CreatedBy]      BIGINT        DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
    
    CONSTRAINT [PK_MatingGroup] PRIMARY KEY CLUSTERED ([MatingGroupKey] ASC)
);

GO


ALTER TABLE [dimension].[MatingGroup] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);
