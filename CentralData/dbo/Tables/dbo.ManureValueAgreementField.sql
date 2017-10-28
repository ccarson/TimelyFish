CREATE TABLE [dbo].[ManureValueAgreementField] (
    [ManureValueAgreementID] INT NOT NULL,
    [FieldID]                INT NOT NULL,
    CONSTRAINT [PK_ManureValueAgreementFields] PRIMARY KEY CLUSTERED ([ManureValueAgreementID] ASC, [FieldID] ASC) WITH (FILLFACTOR = 90)
);

