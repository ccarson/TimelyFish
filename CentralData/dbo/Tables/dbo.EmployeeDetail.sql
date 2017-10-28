CREATE TABLE [dbo].[EmployeeDetail] (
    [ContactID]        INT          NOT NULL,
    [MAS90CompanyID]   INT          NULL,
    [Terminated]       SMALLINT     CONSTRAINT [DF_EmployeeDetail_Terminated] DEFAULT (0) NULL,
    [MAS90EmployeeID]  VARCHAR (7)  NULL,
    [ReportingDefault] SMALLINT     NULL,
    [EmployeeID]       VARCHAR (50) NULL,
    CONSTRAINT [PK_EmployeeDetail] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

