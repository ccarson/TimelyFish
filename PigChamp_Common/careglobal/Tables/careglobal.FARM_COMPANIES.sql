CREATE TABLE [careglobal].[FARM_COMPANIES] (
    [site_id]      INT           NOT NULL,
    [company_name] VARCHAR (30)  NOT NULL,
    [address1]     NVARCHAR (35) NULL,
    [address2]     NVARCHAR (35) NULL,
    [address3]     NVARCHAR (35) NULL,
    [address4]     NVARCHAR (35) NULL,
    [address5]     NVARCHAR (35) NULL,
    [phone]        VARCHAR (30)  NULL,
    [fax]          VARCHAR (30)  NULL,
    CONSTRAINT [PK_FARM_COMPANIES] PRIMARY KEY CLUSTERED ([site_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_FARM_COMPANIES_SITES_0] FOREIGN KEY ([site_id]) REFERENCES [careglobal].[SITES] ([site_id]) ON DELETE CASCADE
);

