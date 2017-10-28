CREATE TABLE [dbo].[cft_ROLE_TYPE] (
    [RoleTypeID]          INT          IDENTITY (500, 1) NOT FOR REPLICATION NOT NULL,
    [RoleTypeDescription] VARCHAR (50) NULL,
    [CreatedDateTime]     DATETIME     CONSTRAINT [DF_cft_ROLE_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50) NOT NULL,
    [UpdatedDateTime]     DATETIME     NULL,
    [UpdatedBy]           VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_ROLE_TYPE] PRIMARY KEY CLUSTERED ([RoleTypeID] ASC) WITH (FILLFACTOR = 90)
);

