CREATE TABLE [dbo].[cftRoleType] (
    [RoleTypeDescription] VARCHAR (50) NULL,
    [RoleTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [tstamp]              ROWVERSION   NOT NULL,
    PRIMARY KEY CLUSTERED ([RoleTypeID] ASC) WITH (FILLFACTOR = 90)
);

