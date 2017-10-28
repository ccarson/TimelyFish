CREATE TABLE [dbo].[CRMtoCDEntity] (
    [ID]            INT              IDENTITY (1, 1) NOT NULL,
    [EntityType]    VARCHAR (20)     NOT NULL,
    [CDContactID]   INT              NULL,
    [CDName]        VARCHAR (50)     NULL,
    [CRMEntityType] INT              NULL,
    [CRMGuid]       UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_CRMtoCDEntity] PRIMARY KEY CLUSTERED ([ID] ASC)
);

