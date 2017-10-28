CREATE TABLE [stage].[EV_FOSTERS] (
    [event_id]       INT              NOT NULL,
    [identity_id]    INT              NOT NULL,
    [site_id]        INT              NOT NULL,
    [eventdate]      DATETIME         NULL,
    [piglets]        TINYINT          NOT NULL,
    [age]            TINYINT          NULL,
    [foster_type]    VARCHAR (3)      NULL,
    [total_weight]   FLOAT (53)       NULL,
    [other_event_id] INT              NULL,
    [MFGUID]      VARCHAR (36)     NULL,
    [SequentialGUID] UNIQUEIDENTIFIER CONSTRAINT [DF__EV_FOSTER__Seque__24E9D9C8] DEFAULT (newsequentialid()) NULL,
    [SourceGUID]     AS               (CONVERT([nvarchar](36),coalesce([MFGUID],[SequentialGUID]))),
    CONSTRAINT [PK__EV_FOSTE__B72DFA8633F267B4] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC)
);







