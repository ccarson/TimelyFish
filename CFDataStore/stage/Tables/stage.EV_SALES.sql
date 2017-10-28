CREATE TABLE [stage].[EV_SALES] (
    [event_id]       INT              NOT NULL,
    [identity_id]    INT              NOT NULL,
    [site_id]        INT              NOT NULL,
    [eventdate]      DATETIME         NULL,
    [sale_reason_id] INT              NOT NULL,
    [destination_id] INT              NULL,
    [old_identity]   VARCHAR (15)     NULL,
    [MFGUID]      VARCHAR (36)     NULL,
    [SequentialGUID] UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NULL,
    [SourceGUID]     AS               (CONVERT([nvarchar](36),coalesce([MFGUID],[SequentialGUID]))),
    CONSTRAINT [PK_EV_SALES] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 100)
);









