CREATE TABLE [careglobal].[FARM_IDENTITIES] (
    [site_id]        INT          NOT NULL,
    [identity_name]  VARCHAR (20) NOT NULL,
    [identity_value] VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_FARM_IDENTITIES] PRIMARY KEY CLUSTERED ([site_id] ASC, [identity_name] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_FARM_IDENTITIES_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

