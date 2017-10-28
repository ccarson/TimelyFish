CREATE TABLE [caredata].[FEEDING_STATIONS] (
    [station_id]       INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT          NOT NULL,
    [shortname]        VARCHAR (12) NOT NULL,
    [longname]         VARCHAR (30) NOT NULL,
    [disabled]         BIT          CONSTRAINT [DF_FEEDING_STATIONS_disabled] DEFAULT ((0)) NOT NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_FEEDING_STATIONS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_FEEDING_STATIONS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_FEEDING_STATIONS] PRIMARY KEY CLUSTERED ([station_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_FEEDING_STATIONS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_FEEDING_STATIONS_0]
    ON [caredata].[FEEDING_STATIONS]([shortname] ASC, [site_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 90);

