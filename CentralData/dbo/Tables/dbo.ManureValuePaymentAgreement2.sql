CREATE TABLE [dbo].[ManureValuePaymentAgreement2] (
    [ManureValuePaymentID]   INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureValueAgreementID] INT           NOT NULL,
    [PaymentTypeID]          INT           NOT NULL,
    [PaymentType]            VARCHAR (30)  NULL,
    [PaymentComment]         VARCHAR (100) NULL,
    [PercentageRate]         FLOAT (53)    NULL,
    [FixedAmount]            FLOAT (53)    NULL,
    [RatePerAcre]            FLOAT (53)    NULL,
    [RatePerGallon]          FLOAT (53)    NULL,
    [MaxAmount]              FLOAT (53)    NULL,
    [OptionalRate]           FLOAT (53)    NULL,
    [OptionalPer]            VARCHAR (50)  NULL,
    CONSTRAINT [PK_ManureValuePaymentAgreement2] PRIMARY KEY CLUSTERED ([ManureValueAgreementID] ASC, [PaymentTypeID] ASC) WITH (FILLFACTOR = 90)
);

