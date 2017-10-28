CREATE TABLE [stage].[FARMS] (
    [site_id]               INT              NOT NULL,
    [farm_number]           VARCHAR (4)      NOT NULL,
    [farm_name]             VARCHAR (30)     NULL,
    [premise_name]          VARCHAR (30)     NULL,
    [farm_type]             TINYINT          NOT NULL,
    [tattoo_length]         TINYINT          NOT NULL,
    [main_site_id]          INT              NOT NULL,
    [farm_guid]             UNIQUEIDENTIFIER NOT NULL,
--    [SequentialGUID]        UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]            AS               (CONVERT([nvarchar](36),[farm_guid])),
    CONSTRAINT [PK_FARMS] PRIMARY KEY CLUSTERED ([site_id] ASC)
);



