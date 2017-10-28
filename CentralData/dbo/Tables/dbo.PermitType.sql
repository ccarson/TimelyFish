CREATE TABLE [dbo].[PermitType] (
    [PermitTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PermitTypeDescription] VARCHAR (50) NOT NULL,
    [PermitLength]          INT          NULL,
    [PermitLengthUOM]       VARCHAR (50) NULL,
    [RenewalLeadDays]       INT          CONSTRAINT [DF_PermitType_RenewalLeadDays] DEFAULT (0) NOT NULL,
    CONSTRAINT [PK_PermitType] PRIMARY KEY CLUSTERED ([PermitTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Description]
    ON [dbo].[PermitType]([PermitTypeDescription] ASC) WITH (FILLFACTOR = 90);

