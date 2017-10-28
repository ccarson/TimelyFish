CREATE TABLE [caredata].[EXTERNAL_FARMS] (
    [farm_id]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [site_id]          INT          NULL,
    [shortname]        VARCHAR (12) NOT NULL,
    [longname]         VARCHAR (30) NOT NULL,
    [address]          VARCHAR (20) NULL,
    [city]             VARCHAR (20) NULL,
    [state]            VARCHAR (20) NULL,
    [postalcode]       VARCHAR (12) NULL,
    [country]          VARCHAR (20) NULL,
    [contact]          VARCHAR (20) NULL,
    [phone]            VARCHAR (20) NULL,
    [fax]              VARCHAR (20) NULL,
    [email]            VARCHAR (50) NULL,
    [premise_name]     VARCHAR (30) NULL,
    [disabled]         BIT          CONSTRAINT [DF_EXTERNAL_FARMS_disabled] DEFAULT ((0)) NOT NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_EXTERNAL_FARMS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_EXTERNAL_FARMS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_EXTERNAL_FARMS] PRIMARY KEY CLUSTERED ([farm_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_EXTERNAL_FARMS_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_EXTERNAL_FARMS_0]
    ON [caredata].[EXTERNAL_FARMS]([shortname] ASC, [site_id] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 80);

