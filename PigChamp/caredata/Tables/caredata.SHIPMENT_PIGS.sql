CREATE TABLE [caredata].[SHIPMENT_PIGS] (
    [ticket_id]             INT          NOT NULL,
    [to_site_id]            INT          NULL,
    [destination_id]        INT          NULL,
    [receipt_date]          DATETIME     NULL,
    [pigs_received]         SMALLINT     NULL,
    [pigs_rejected]         SMALLINT     NULL,
    [pigs_doa]              SMALLINT     NULL,
    [pigs_substandard]      SMALLINT     NULL,
    [prrs_status_src]       BIT          CONSTRAINT [DF_SHIPMENT_PIGS_prrs_status_src] DEFAULT ((0)) NOT NULL,
    [prrs_status]           VARCHAR (1)  NULL,
    [prrs_vac_src]          BIT          CONSTRAINT [DF_SHIPMENT_PIGS_prrs_vac_src] DEFAULT ((0)) NOT NULL,
    [prrs_vac]              TINYINT      NULL,
    [mycoplasma_vac_src]    BIT          CONSTRAINT [DF_SHIPMENT_PIGS_mycoplasma_vac_src] DEFAULT ((0)) NOT NULL,
    [mycoplasma_vac]        TINYINT      NULL,
    [app_vac_src]           BIT          CONSTRAINT [DF_SHIPMENT_PIGS_app_vac_src] DEFAULT ((0)) NOT NULL,
    [app_vac]               TINYINT      NULL,
    [circovirus_vac_src]    BIT          CONSTRAINT [DF_SHIPMENT_PIGS_circovirus_vac_src] DEFAULT ((0)) NOT NULL,
    [circovirus_vac]        TINYINT      NULL,
    [purchased_in]          BIT          CONSTRAINT [DF_SHIPMENT_PIGS_purchased_in] DEFAULT ((0)) NOT NULL,
    [value]                 FLOAT (53)   NULL,
    [currency_unit]         VARCHAR (3)  NULL,
    [receipt_supervisor_id] INT          NULL,
    [shipment_type]         VARCHAR (1)  NULL,
    [fms_upload_id]         INT          NULL,
    [creation_date]         DATETIME     CONSTRAINT [DF_SHIPMENT_PIGS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]            VARCHAR (15) CONSTRAINT [DF_SHIPMENT_PIGS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date]      DATETIME     NULL,
    [last_update_by]        VARCHAR (15) NULL,
    [deletion_date]         DATETIME     NULL,
    [deleted_by]            VARCHAR (15) NULL,
    CONSTRAINT [PK_SHIPMENT_PIGS] PRIMARY KEY NONCLUSTERED ([ticket_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SHIPMENT_PIGS_EXTERNAL_FARMS_2] FOREIGN KEY ([destination_id]) REFERENCES [caredata].[EXTERNAL_FARMS] ([farm_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_SHIPMENT_PIGS_SHIPMENT_TICKETS_0] FOREIGN KEY ([ticket_id]) REFERENCES [caredata].[SHIPMENT_TICKETS] ([ticket_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_SHIPMENT_PIGS_SITES_1] FOREIGN KEY ([to_site_id]) REFERENCES [careglobal].[SITES] ([site_id]),
    CONSTRAINT [FK_SHIPMENT_PIGS_SUPERVISORS_3] FOREIGN KEY ([receipt_supervisor_id]) REFERENCES [caredata].[SUPERVISORS] ([supervisor_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_SHIPMENT_PIGS_0]
    ON [caredata].[SHIPMENT_PIGS]([receipt_supervisor_id] ASC) WITH (FILLFACTOR = 90);

