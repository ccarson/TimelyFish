CREATE TABLE [dbo].[cftEmpUpdateHist] (
    [ChangeType]    CHAR (1)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [EmpID]         INT           NOT NULL,
    [FieldName]     CHAR (20)     NOT NULL,
    [ID]            INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_user]     CHAR (10)     NOT NULL,
    [NewValue]      CHAR (30)     NOT NULL,
    [OldValue]      CHAR (30)     NOT NULL,
    [UpdateFlg]     SMALLINT      NOT NULL,
    [UpdateStatus]  SMALLINT      NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftEmpUpdateHist0] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);

