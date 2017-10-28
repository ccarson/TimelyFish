CREATE TABLE [dbo].[ManureValueAgreementAnalyteSpecificDetail] (
    [ManureValueAgreementID] INT        NOT NULL,
    [AnalyteID]              INT        NOT NULL,
    [AvailablityOptionID]    INT        NOT NULL,
    [Percentage]             FLOAT (53) NOT NULL,
    CONSTRAINT [PK_ManureValueAgreementAnalyteSpecificDetail] PRIMARY KEY CLUSTERED ([ManureValueAgreementID] ASC, [AnalyteID] ASC) WITH (FILLFACTOR = 90)
);

