CREATE TABLE [dbo].[ManureValuePaymentAgreementType] (
    [ManureValuePaymentAgreementTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureValuePaymentAgreementTypeDescription] VARCHAR (30) NOT NULL,
    CONSTRAINT [PK_ManureValueAgreementPaymentType] PRIMARY KEY CLUSTERED ([ManureValuePaymentAgreementTypeID] ASC) WITH (FILLFACTOR = 90)
);

