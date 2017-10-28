CREATE TABLE [dbo].[cftPMSchedStatus] (
    [Crtd_Date]       SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [Desc]            CHAR (20)     NOT NULL,
    [Lupd_Date]       SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [PMSchedStatusID] CHAR (2)      NOT NULL,
    [Sequence]        INT           NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    PRIMARY KEY CLUSTERED ([PMSchedStatusID] ASC) WITH (FILLFACTOR = 90)
);

