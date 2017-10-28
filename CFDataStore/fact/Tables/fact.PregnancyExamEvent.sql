CREATE TABLE [fact].[PregnancyExamEvent] (
    [PregnancyExamEventKey] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ParityEventKey]        BIGINT        NOT NULL,
    [EventDateKey]          INT           NOT NULL,
    [IsPositive]            BIT           NOT NULL,
    [CreatedDate]           DATETIME      NOT NULL DEFAULT (getutcdate()) , 
    [CreatedBy]             BIGINT        NOT NULL DEFAULT ((-1)) , 
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
	[SourceCode]		NVARCHAR (20) NOT NULL ,

    [SourceID]              INT           NOT NULL,
    [SourceGUID]            NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_PregnancyExamEvent] PRIMARY KEY CLUSTERED ([PregnancyExamEventKey] ASC)
);
GO

ALTER TABLE [fact].[PregnancyExamEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF)
;






 

