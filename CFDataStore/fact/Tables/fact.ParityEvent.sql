CREATE TABLE [fact].[ParityEvent] (
    [ParityEventKey] BIGINT        IDENTITY (1, 1) NOT NULL,
    [AnimalKey]  BIGINT        NOT NULL,
    [ParityNumber]   INT           NOT NULL,
    [ParityDateKey]  INT           NOT NULL,
    [MatingGroupKey] INT           NULL,
    [CreatedDate]    DATETIME      NOT NULL DEFAULT (getutcdate()) , 
    [CreatedBy]      BIGINT        NOT NULL DEFAULT ((-1)) , 
    [UpdatedDate]    DATETIME      NULL,
    [UpdatedBy]      BIGINT        NULL,
	DeletedDate				datetime		NULL, 
	DeletedBy				BIGINT			NULL, 
    [SourceCode]     NVARCHAR (20) NOT NULL ,
    [SourceID]       INT           NOT NULL,
    [SourceGUID]     NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_ParityEvent] 
		PRIMARY KEY CLUSTERED ([ParityEventKey] ASC)
);

GO

CREATE NONCLUSTERED INDEX [IX_MatingEvent_01]
    ON [fact].[ParityEvent]([AnimalKey] ASC, [ParityDateKey] ASC);

GO
ALTER TABLE [fact].[ParityEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);
