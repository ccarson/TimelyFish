CREATE TABLE [dbo].[SiteEmployee] (
    [SiteContactID]     INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EmployeeContactID] INT NOT NULL,
    [PositionID]        INT NULL,
    CONSTRAINT [PK_SiteEmployee] PRIMARY KEY CLUSTERED ([SiteContactID] ASC, [EmployeeContactID] ASC) WITH (FILLFACTOR = 90)
);

