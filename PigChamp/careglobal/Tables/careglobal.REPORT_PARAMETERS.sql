CREATE TABLE [careglobal].[REPORT_PARAMETERS] (
    [group_id]    INT           NULL,
    [report_id]   INT           NOT NULL,
    [site_id]     INT           NULL,
    [param_name]  VARCHAR (80)  NOT NULL,
    [param_value] VARCHAR (600) NULL,
    CONSTRAINT [FK_REPORT_PARAMETERS_REPORT_GROUPS_0] FOREIGN KEY ([group_id]) REFERENCES [careglobal].[REPORT_GROUPS] ([group_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_REPORT_PARAMETERS_REPORTS_1] FOREIGN KEY ([report_id]) REFERENCES [careglobal].[REPORTS] ([report_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_REPORT_PARAMETERS_SITES_2] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);


GO
CREATE CLUSTERED INDEX [IDX_REPORT_PARAMETERS_0]
    ON [careglobal].[REPORT_PARAMETERS]([site_id] ASC, [group_id] ASC, [report_id] ASC) WITH (FILLFACTOR = 80);

