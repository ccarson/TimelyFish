CREATE TABLE [stage].[EV_TRANSFERS] (
    [event_id]       INT              NOT NULL,
    [identity_id]    INT              NOT NULL,
    [site_id]        INT              NOT NULL,
	[event_type]     INT              NOT NULL,
    [eventdate]      DATETIME         NULL,
    [other_event_id] INT              NOT NULL,
    [old_identity]   VARCHAR (15)     NULL,
    [MFGUID]      VARCHAR (36)     NULL,
    [SequentialGUID] UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]     AS               (CONVERT([nvarchar](36),coalesce([MFGUID],[SequentialGUID]))),
    CONSTRAINT [PK_EV_TRANSFERS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC)
);











