﻿CREATE TABLE [caredata].[TRIAL_CANDIDATES] (
    [identity_id] INT NOT NULL,
    [trial_id]    INT NOT NULL,
    CONSTRAINT [PK_TRIAL_CANDIDATES] PRIMARY KEY CLUSTERED ([identity_id] ASC, [trial_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_TRIAL_CANDIDATES_BH_IDENTITIES_0] FOREIGN KEY ([identity_id]) REFERENCES [caredata].[BH_IDENTITIES] ([identity_id]),
    CONSTRAINT [FK_TRIAL_CANDIDATES_COMMON_LOOKUPS_1] FOREIGN KEY ([trial_id]) REFERENCES [caredata].[COMMON_LOOKUPS] ([lookup_id]) ON UPDATE CASCADE
);
