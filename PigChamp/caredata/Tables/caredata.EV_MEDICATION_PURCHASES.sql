CREATE TABLE [caredata].[EV_MEDICATION_PURCHASES] (
    [purchase_id]      INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT          NOT NULL,
    [treatment_id]     INT          NOT NULL,
    [purchase_date]    DATETIME     NOT NULL,
    [expiry_date]      DATETIME     NULL,
    [cost]             FLOAT (53)   NOT NULL,
    [quantity_in]      SMALLINT     NOT NULL,
    [supervisor_id]    INT          NULL,
    [supplier_id]      INT          NULL,
    [invoice_number]   VARCHAR (20) NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EV_MEDICATION_PURCHASES_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EV_MEDICATION_PURCHASES_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EV_MEDICATION_PURCHASES] PRIMARY KEY NONCLUSTERED ([purchase_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EV_MEDICATION_PURCHASES_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]),
    CONSTRAINT [FK_EV_MEDICATION_PURCHASES_SUPERVISORS_2] FOREIGN KEY ([supervisor_id]) REFERENCES [caredata].[SUPERVISORS] ([supervisor_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_MEDICATION_PURCHASES_SUPPLIERS_3] FOREIGN KEY ([supplier_id]) REFERENCES [caredata].[SUPPLIERS] ([supplier_id]) ON UPDATE CASCADE,
    CONSTRAINT [FK_EV_MEDICATION_PURCHASES_TREATMENTS_1] FOREIGN KEY ([treatment_id]) REFERENCES [caredata].[TREATMENTS] ([treatment_id]) ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IDX_EV_MEDICATION_PURCHASES_0]
    ON [caredata].[EV_MEDICATION_PURCHASES]([supervisor_id] ASC) WITH (FILLFACTOR = 90);

