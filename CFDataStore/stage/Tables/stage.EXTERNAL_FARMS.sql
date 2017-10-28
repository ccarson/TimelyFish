CREATE TABLE [stage].[EXTERNAL_FARMS] (
    [farm_id]          INT              NOT NULL,
    [site_id]          INT              NULL,
    [shortname]        VARCHAR (12)     NOT NULL,
    [longname]         VARCHAR (30)     NOT NULL,
    [address]          VARCHAR (20)     NULL,
    [city]             VARCHAR (20)     NULL,
    [state]            VARCHAR (20)     NULL,
    [postalcode]       VARCHAR (12)     NULL,
    [country]          VARCHAR (20)     NULL,
    [contact]          VARCHAR (20)     NULL,
    [phone]            VARCHAR (20)     NULL,
    [fax]              VARCHAR (20)     NULL,
    [email]            VARCHAR (50)     NULL,
    [premise_name]     VARCHAR (30)     NULL,
    [disabled]         BIT              NOT NULL,
    [synonym]          VARCHAR (5)      NULL,
    [creation_date]    DATETIME         NOT NULL,
    [created_by]       VARCHAR (15)     NOT NULL,
    [last_update_date] DATETIME         NULL,
    [last_update_by]   VARCHAR (15)     NULL,
    [deletion_date]    DATETIME         NULL,
    [deleted_by]       VARCHAR (15)     NULL,
    [SequentialGUID]   UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]       AS               (CONVERT([nvarchar](36),[SequentialGUID])),
    PRIMARY KEY CLUSTERED ([farm_id] ASC)
);



