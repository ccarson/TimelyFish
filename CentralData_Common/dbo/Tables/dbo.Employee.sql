CREATE TABLE [dbo].[Employee] (
    [ContactID]  INT          NOT NULL,
    [UserID]     VARCHAR (20) NULL,
    [EmployeeID] VARCHAR (10) NULL,
    [Division]   CHAR (2)     NULL,
    [Dept]       CHAR (2)     NULL,
    [Location]   CHAR (4)     NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Employee_Contact] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Contact] ([ContactID]) ON DELETE CASCADE
);

GO
GRANT SELECT
    ON OBJECT::[dbo].[Employee] TO [hybridconnectionlogin_permissions]
    AS [dbo];

