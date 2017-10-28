CREATE TABLE [careimport].[IMPORT_PACKER_DETAIL] (
    [row_id]         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [import_id]      INT           NOT NULL,
    [packing_plant]  VARCHAR (30)  NULL,
    [tattoo]         VARCHAR (15)  NULL,
    [receipt_date]   DATETIME      NULL,
    [carcass_weight] FLOAT (53)    NULL,
    [liveweight]     FLOAT (53)    NULL,
    [value]          FLOAT (53)    NULL,
    [error_date]     DATETIME      NULL,
    [error_code]     SMALLINT      NULL,
    [error_message]  VARCHAR (250) NULL,
    CONSTRAINT [PK_IMPORT_PACKER_DETAIL] PRIMARY KEY CLUSTERED ([row_id] ASC) WITH (FILLFACTOR = 90)
);

