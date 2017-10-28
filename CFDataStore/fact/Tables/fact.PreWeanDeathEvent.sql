CREATE TABLE [fact].[PreWeanDeathEvent] (
    [PreWeanDeathEventKey] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ParityEventKey]       BIGINT        NOT NULL,
    [EventDateKey]         INT           NOT NULL,
    [Quantity]             TINYINT       NOT NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF__PreWeanDe__Creat__68FD7645] DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]            BIGINT        CONSTRAINT [DF__PreWeanDe__Creat__69F19A7E] DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]		DATETIME      NULL,
    [UpdatedBy]			BIGINT        NULL,
    [DeletedDate]		DATETIME      NULL,
    [DeletedBy]			BIGINT        NULL,
	[SourceCode]		NVARCHAR (20) NOT NULL ,
    [SourceID]             INT           NOT NULL,
    [SourceGUID]           NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK__PreWeanD__DA7F1D65C54DC56C] PRIMARY KEY CLUSTERED ([PreWeanDeathEventKey] ASC)
);


GO
ALTER TABLE [fact].[PreWeanDeathEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF);
