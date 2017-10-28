CREATE TABLE [careglobal].[TARGETS] (
    [site_id]      INT          NOT NULL,
    [target_name]  VARCHAR (50) NOT NULL,
    [target_value] FLOAT (53)   NOT NULL,
    [valid_until]  DATETIME     NULL,
    CONSTRAINT [FK_TARGETS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);


GO
CREATE CLUSTERED INDEX [IDX_TARGETS_0]
    ON [careglobal].[TARGETS]([site_id] ASC) WITH (FILLFACTOR = 80);

