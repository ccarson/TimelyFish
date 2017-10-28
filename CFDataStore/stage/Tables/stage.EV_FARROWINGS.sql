CREATE TABLE [stage].[EV_FARROWINGS] (
    [event_id]       INT              NOT NULL,
    [identity_id]    INT              NOT NULL,
    [site_id]        INT              NOT NULL,
    [location_id]    INT              NULL,
    [eventdate]      DATETIME         NULL,
    [sexed]          BIT              NOT NULL,
    [liveborn_gilts] TINYINT          NOT NULL,
    [liveborn_boars] TINYINT          NOT NULL,
    [stillborn]      TINYINT          NULL,
    [mummified]      TINYINT          NULL,
    [assisted]       BIT              NULL,
    [induced]        BIT              NULL,
    [substandard]    TINYINT          NULL,
    [MFGUID]      VARCHAR (36)     NULL,
    [SequentialGUID] UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]     AS               (CONVERT([nvarchar](36),coalesce([MFGUID],[SequentialGUID]))),
    CONSTRAINT [PK_EV_FARROWINGS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 100)
);









