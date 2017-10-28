CREATE TABLE [dbo].[cftEmpRRHist] (
    [Comment]       CHAR (50)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [EmpID]         INT           NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [RewardID]      CHAR (2)      NOT NULL,
    [SentDate]      SMALLDATETIME NOT NULL,
    [ServiceYear]   SMALLINT      NOT NULL,
    [tstamp]        ROWVERSION    NULL
);

