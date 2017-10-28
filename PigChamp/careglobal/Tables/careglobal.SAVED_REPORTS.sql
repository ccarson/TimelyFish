CREATE TABLE [careglobal].[SAVED_REPORTS] (
    [saved_id]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]    INT          NULL,
    [report_id]  INT          NOT NULL,
    [tablename]  VARCHAR (40) NOT NULL,
    [saved_date] DATETIME     NOT NULL,
    [saved_by]   VARCHAR (15) NOT NULL,
    [localdb]    BIT          CONSTRAINT [DF_SAVED_REPORTS_localdb] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_SAVED_REPORTS] PRIMARY KEY CLUSTERED ([saved_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SAVED_REPORTS_REPORTS_1] FOREIGN KEY ([report_id]) REFERENCES [careglobal].[REPORTS] ([report_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_SAVED_REPORTS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

