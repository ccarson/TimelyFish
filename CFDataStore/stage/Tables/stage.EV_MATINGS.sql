CREATE TABLE [stage].[EV_MATINGS] (
    [event_id]         INT              NOT NULL,
    [identity_id]      INT              NOT NULL,
    [site_id]          INT              NOT NULL,
    [eventdate]        DATETIME         NOT NULL,
    [mating_type]      TINYINT          NOT NULL,
    [male_identity_id] INT              NULL,
    [time_of_day]      VARCHAR (1)      NULL,
    [service_group]    VARCHAR (15)     NULL,
	supervisor_id		int				NULL, 
    [MFGUID]        VARCHAR (36)     NULL,
    [SequentialGUID]   UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]       AS               (CONVERT([nvarchar](36),coalesce([MFGUID],[SequentialGUID]))),
    CONSTRAINT [PK_EV_MATINGS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC)
);









