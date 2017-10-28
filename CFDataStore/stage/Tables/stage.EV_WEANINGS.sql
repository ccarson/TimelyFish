CREATE TABLE [stage].[EV_WEANINGS] (
    [event_id]       INT              NOT NULL,
    [identity_id]    INT              NOT NULL,
    [site_id]        INT              NOT NULL,
    [eventdate]      DATETIME         NULL,
	event_type		int					not null,
    [weaned_boars]   TINYINT          NOT NULL,
    [weaned_gilts]   TINYINT          NOT NULL,
    [substandard]    TINYINT          NULL,
    [MFGUID]      VARCHAR (36)     NULL,
    [SequentialGUID] UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]     AS               (CONVERT([nvarchar](36),coalesce([MFGUID],[SequentialGUID]))),
    CONSTRAINT [PK_EV_WEANINGS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC)
);











