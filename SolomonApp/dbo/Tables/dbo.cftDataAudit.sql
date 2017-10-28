CREATE TABLE [dbo].[cftDataAudit] (
    [ID]            BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AuditEvent]    CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (50)     NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [OldValue]      CHAR (20)     NOT NULL,
    [NewValue]      CHAR (20)     NOT NULL,
    CONSTRAINT [cftDataAudit0] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

