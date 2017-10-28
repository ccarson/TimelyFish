CREATE TABLE [stage].[EV_DEATHS] (
    [event_id]        INT              NOT NULL,
    [identity_id]     INT              NOT NULL,
    [site_id]         INT              NOT NULL,
    [eventdate]       DATETIME         NULL,
    [death_reason_id] INT              NOT NULL,
    [old_identity]    VARCHAR (15)     NULL,
    [destroyed]       BIT              NULL,
    [MFGUID]       VARCHAR (36)     NULL,
    [SequentialGUID]  UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NULL,
    [SourceGUID]      AS               (CONVERT([nvarchar](36),coalesce([MFGUID],[SequentialGUID]))),
    CONSTRAINT [PK_EV_DEATHS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 100)
);











