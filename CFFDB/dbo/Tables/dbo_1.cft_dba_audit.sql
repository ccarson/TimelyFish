CREATE TABLE [dbo].[cft_dba_audit] (
    [crtd_ts]    DATETIME      NOT NULL,
    [audit_desc] VARCHAR (100) NOT NULL,
    [value]      INT           NOT NULL,
    CONSTRAINT [PK_cft_dba_audit] PRIMARY KEY CLUSTERED ([crtd_ts] ASC, [audit_desc] ASC) WITH (FILLFACTOR = 90)
);

