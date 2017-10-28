CREATE TABLE [stage].[EV_NURSE_ON] (
    [event_id]                  INT             NOT NULL,
    [identity_id]               INT             NOT NULL,
    [site_id]                   INT             NOT NULL,
    [eventdate]                 DATETIME        NULL,
    [piglets_on]                TINYINT         NOT NULL,
    [fostered_weight]           FLOAT (53)      NULL,
    [fostered_from_identity_id] INT             NULL,
	[MFGUID]					varchar(36)		NULL, 
    [SequentialGUID]            UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]                AS             CONVERT( nvarchar(36),coalesce( [MFGUID], [SequentialGUID] ) ) PERSISTED,
    CONSTRAINT [PK_EV_NURSE_ON] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC)
);













