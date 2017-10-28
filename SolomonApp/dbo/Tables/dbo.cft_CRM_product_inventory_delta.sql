CREATE TABLE [dbo].[cft_CRM_product_inventory_delta] (
    [invtid]         CHAR (30)     NOT NULL,
    [lupd_datetime]  SMALLDATETIME NOT NULL,
    [descr]          CHAR (60)     NOT NULL,
    [invtype]        VARCHAR (13)  NOT NULL,
    [transtatuscode] CHAR (2)      NOT NULL,
    [dfltsounit]     CHAR (6)      NOT NULL,
    [cost]           FLOAT (53)    NULL
);

