
CREATE TABLE [stage].[EV_PARITY] (
    [event_id]       INT              NOT NULL,
    [event_type]     SMALLINT         NOT NULL,
    [eventdate]      DATETIME         NULL,
    [identity_id]    INT              NOT NULL,
    [parity_number]     INT          NOT NULL,
	site_id			int not null , 
	MobileFrameSourceGUID varchar(36) null, 
    [SequentialGUID] UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]     AS               (CONVERT([nvarchar](36),COALESCE( MobileFrameSourceGUID, [SequentialGUID]))) PERSISTED,
    CONSTRAINT [PK_EV_PARITY] PRIMARY KEY CLUSTERED ([event_id] ASC)
);



GO

CREATE NONCLUSTERED INDEX 
	IX_EV_PARITY
		ON stage.EV_PARITY( identity_id, parity_number ) ; 
			


