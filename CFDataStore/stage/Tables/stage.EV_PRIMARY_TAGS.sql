CREATE TABLE [stage].[EV_PRIMARY_TAGS] (
    [identity_id]      INT              NOT NULL,
    [site_id]          INT              NOT NULL,
    [primary_identity] VARCHAR (15)     NULL,
    [is_current_site]  BIT              NOT NULL,
    [deletion_date]    DATETIME         NULL,
    [SequentialGUID]   UNIQUEIDENTIFIER DEFAULT (newsequentialid()) NOT NULL,
    [SourceGUID]       AS               (CONVERT([nvarchar](36),[SequentialGUID])) PERSISTED,
    CONSTRAINT [PK_EV_PRIMARY_TAGS] PRIMARY KEY CLUSTERED ([identity_id] ASC, [site_id] ASC)
);













