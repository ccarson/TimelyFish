CREATE TABLE [stage].[EV_ARRIVALS] (
    [identity_id]              INT              NOT NULL,
    [event_id]                 INT              NOT NULL,
    [site_id]                  INT              NOT NULL,
    [eventdate]                DATETIME         NULL,
    [MobileFrameAnimalEventID] VARCHAR (36)     NULL,
    [SequentialGUID]           UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NULL,
    [SourceGUID]               AS               (CONVERT([nvarchar](36),coalesce([MobileFrameAnimalEventID],[SequentialGUID]))),
    CONSTRAINT [PK_EV_ARRIVALS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 100)
);











