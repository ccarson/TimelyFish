CREATE TABLE [caredata].[EV_MATINGS] (
    [event_id]           INT           NOT NULL,
    [identity_id]        INT           NOT NULL,
    [mating_type]        TINYINT       NOT NULL,
    [male_identity_id]   INT           NULL,
    [time_of_day]        VARCHAR (1)   NULL,
    [service_group]      VARCHAR (15)  NULL,
    [lock_id]            INT           NULL,
    [leak_id]            INT           NULL,
    [quality_id]         INT           NULL,
    [standing_reflex_id] INT           NULL,
    [sow_weight]         FLOAT (53)    NULL,
    [UDF2990]            VARCHAR (8)   NULL,
    [UDF33598]           VARCHAR (30)  NULL,
    [UDF73933]           VARCHAR (30)  NULL,
    [UDF6423]            VARCHAR (8)   NULL,
    [UDF64820]           INT           NULL,
    [UDF4564]            VARCHAR (30)  NULL,
    [UDF25332]           VARCHAR (5)   NULL,
    [UDF65625]           VARCHAR (30)  NULL,
    [UDF41941]           VARCHAR (30)  NULL,
    [UDF49637]           VARCHAR (30)  NULL,
    [UDF97038]           VARCHAR (8)   NULL,
    [UDF3543]            INT           NULL,
    [UDF20784]           VARCHAR (20)  NULL,
    [UDF81832]           VARCHAR (5)   NULL,
    [UDF60736]           VARCHAR (30)  NULL,
    [UDF89631]           VARCHAR (30)  NULL,
    [UDF25099]           VARCHAR (30)  NULL,
    [UDF22268]           VARCHAR (2)   NULL,
    [UDF21988]           VARCHAR (30)  NULL,
    [UDF55469]           VARCHAR (30)  NULL,
    [UDF10879]           VARCHAR (30)  NULL,
    [UDF41864]           VARCHAR (30)  NULL,
    [UDF72163]           VARCHAR (30)  NULL,
    [UDF75901]           VARCHAR (30)  NULL,
    [UDF73635]           VARCHAR (5)   NULL,
    [UDF35879]           VARCHAR (30)  NULL,
    [UDF86715]           INT           NULL,
    [UDF5702]            VARCHAR (8)   NULL,
    [UDF24417]           VARCHAR (30)  NULL,
    [UDF83082]           VARCHAR (30)  NULL,
    [UDF72237]           VARCHAR (30)  NULL,
    [UDF088848]          VARCHAR (500) NULL,
    [UDF023888]          VARCHAR (9)   NULL,
    [UDF013249]          INT           NULL,
    [UDF068060]          VARCHAR (36)  NULL,
    CONSTRAINT [PK_EV_MATINGS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [event_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EV_MATINGS_BH_EVENTS_0] FOREIGN KEY ([event_id]) REFERENCES [caredata].[BH_EVENTS] ([event_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EV_MATINGS_BH_IDENTITIES_1] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_MATINGS_BH_IDENTITIES_2] FOREIGN KEY ([male_identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_EV_MATINGS_COMMON_LOOKUPS_3] FOREIGN KEY ([lock_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]),
    CONSTRAINT [FK_EV_MATINGS_COMMON_LOOKUPS_4] FOREIGN KEY ([leak_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]),
    CONSTRAINT [FK_EV_MATINGS_COMMON_LOOKUPS_5] FOREIGN KEY ([quality_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]),
    CONSTRAINT [FK_EV_MATINGS_COMMON_LOOKUPS_6] FOREIGN KEY ([standing_reflex_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_MATINGS_1]
    ON [caredata].[EV_MATINGS]([male_identity_id] ASC)
    INCLUDE([event_id]) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_MATINGS_2]
    ON [caredata].[EV_MATINGS]([lock_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_MATINGS_3]
    ON [caredata].[EV_MATINGS]([leak_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_MATINGS_4]
    ON [caredata].[EV_MATINGS]([quality_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_MATINGS_5]
    ON [caredata].[EV_MATINGS]([standing_reflex_id] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_MATINGS_6]
    ON [caredata].[EV_MATINGS]([service_group] ASC, [event_id] ASC) WITH (FILLFACTOR = 80);

