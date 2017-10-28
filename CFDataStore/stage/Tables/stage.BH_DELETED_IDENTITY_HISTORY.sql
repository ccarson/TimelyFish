CREATE TABLE [stage].[BH_DELETED_IDENTITY_HISTORY] (
    [site_id]          INT          NOT NULL,
    [is_current_site]  BIT          NOT NULL,
    [identity_id]      INT          NOT NULL,
    [identity_type]    VARCHAR (1)  NOT NULL,
    [primary_identity] VARCHAR (15) NOT NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_BH_DELETED_IDENTITY_HISTORY] PRIMARY KEY CLUSTERED ([site_id] ASC, [identity_id] ASC) WITH (FILLFACTOR = 100)
);







