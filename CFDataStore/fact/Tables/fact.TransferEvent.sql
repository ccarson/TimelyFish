CREATE TABLE [fact].[TransferEvent] (
    [TransferEventKey] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ArrivalEventKey]  BIGINT        NOT NULL,
    [RemovalEventKey]  BIGINT        NOT NULL,
    [EventDateKey]     INT           NOT NULL,
    [CreatedDate]      DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]        BIGINT        DEFAULT ((-1)) NOT NULL,
	   UpdatedDate		DATETIME      ,
	   UpdatedBy		BIGINT        ,
	   DeletedDate		DATETIME      ,
	   DeletedBy		BIGINT        ,
       SourceCode		NVARCHAR (20) NOT NULL	,
    [SourceID]         INT           NOT NULL,
    [SourceGUID]       NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_TransferEvent] PRIMARY KEY CLUSTERED ([TransferEventKey] ASC)
);
GO

ALTER TABLE [fact].[TransferEvent] ENABLE CHANGE_TRACKING WITH (TRACK_COLUMNS_UPDATED = OFF)
;











