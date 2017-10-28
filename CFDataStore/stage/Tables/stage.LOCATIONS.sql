CREATE TABLE [stage].[LOCATIONS] (
    [ID]               INT              IDENTITY (1, 1) NOT NULL,
    [location_id]      INT              NOT NULL,
    [site_id]          INT              NOT NULL,
    [barn]             VARCHAR (10)     NOT NULL,
    [room]             VARCHAR (10)     NULL,
    [pen]              VARCHAR (10)     NULL,
    [station_id]       INT              NULL,
    [creation_date]    DATETIME         NOT NULL,
    [created_by]       VARCHAR (15)     NOT NULL,
    [last_update_date] DATETIME         NULL,
    [last_update_by]   VARCHAR (15)     NULL,
    [deletion_date]    DATETIME         NULL,
    [deleted_by]       VARCHAR (15)     NULL,
    [SequentialGUID]   UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]       AS               (CONVERT([nvarchar](36),[SequentialGUID])),
    PRIMARY KEY CLUSTERED ([ID] ASC)
);



