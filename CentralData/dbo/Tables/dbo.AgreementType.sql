CREATE TABLE [dbo].[AgreementType] (
    [AgreementTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]     VARCHAR (30) NULL,
    CONSTRAINT [PK_AgreementType] PRIMARY KEY CLUSTERED ([AgreementTypeID] ASC) WITH (FILLFACTOR = 90)
);

