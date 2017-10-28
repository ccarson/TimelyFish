CREATE TABLE [dbo].[cft_DATA_DEFINITION] (
    [DataDefinitionID]    INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DataElement]         VARCHAR (50)     NOT NULL,
    [DataDefinition]      TEXT             NULL,
    [Calculation]         TEXT             NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_DATA_DEFINITION] PRIMARY KEY CLUSTERED ([DataDefinitionID] ASC) WITH (FILLFACTOR = 90)
);

