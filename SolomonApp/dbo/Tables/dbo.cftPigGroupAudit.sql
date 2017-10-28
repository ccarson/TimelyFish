CREATE TABLE [dbo].[cftPigGroupAudit] (
    [ID]            BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [AttributeName] CHAR (20)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [OldValue]      CHAR (20)     NOT NULL,
    [NewValue]      CHAR (20)     NOT NULL,
    [PGStatusID]    CHAR (2)      NOT NULL,
    [PigGroupID]    CHAR (10)     NOT NULL,
    [tstamp]        BINARY (8)    NULL,
    CONSTRAINT [cftPigGroupAudit0] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

