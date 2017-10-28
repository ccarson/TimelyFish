CREATE TABLE [dbo].[cftSDPriority] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DaysPromised]  INT           NOT NULL,
    [PriorityDescr] CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [SDPriority]    INT           NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);

