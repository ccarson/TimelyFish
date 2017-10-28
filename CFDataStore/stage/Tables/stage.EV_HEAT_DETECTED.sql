CREATE TABLE [stage].[EV_HEAT_DETECTED] (
    [event_id]       INT              NOT NULL,
    [identity_id]    INT              NOT NULL,
    [site_id]        INT              NOT NULL,
    [eventdate]      DATETIME         NULL,
    [MFGUID]      VARCHAR (36)     NULL,
    [SequentialGUID] UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]     AS               (CONVERT([nvarchar](36),coalesce([MFGUID],[SequentialGUID]))),
    CONSTRAINT [PK_EV_HEAT_DETECTED] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC)
);









