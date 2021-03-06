﻿CREATE TABLE [fact].[ObservedHeatEvent] (
    [ObservedHeatEventKey] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ParityEventKey]       BIGINT        NOT NULL,
    [EventDateKey]         INT           NOT NULL,
    [CreatedDate]          DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]            BIGINT        DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
	[SourceCode]		NVARCHAR (20) NOT NULL ,
    [SourceID]             INT           NOT NULL,
    [SourceGUID]           NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_ObservedHeatEvent] PRIMARY KEY CLUSTERED ([ObservedHeatEventKey] ASC)
);

GO

ALTER TABLE [fact].[ObservedHeatEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF)
;




 