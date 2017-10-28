CREATE TABLE [dbo].[cftEmployeeDetail] (
    [ContactID]        INT          NOT NULL,
    [EmployeeID]       VARCHAR (50) NULL,
    [MAS90CompanyID]   INT          NOT NULL,
    [MAS90EmployeeID]  VARCHAR (7)  NULL,
    [ReportingDefault] SMALLINT     NULL,
    [Terminated]       SMALLINT     NULL,
    [Crtd_DateTime]    DATETIME     NOT NULL,
    [Crtd_User]        DATETIME     NOT NULL,
    [Lupd_User]        DATETIME     NOT NULL,
    [Crtd_Prog]        DATETIME     NOT NULL,
    [Lupd_Prog]        DATETIME     NOT NULL,
    [Lupd_DateTime]    DATETIME     NOT NULL
);

