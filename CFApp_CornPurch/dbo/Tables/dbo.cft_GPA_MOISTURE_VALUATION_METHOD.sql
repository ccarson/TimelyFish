CREATE TABLE [dbo].[cft_GPA_MOISTURE_VALUATION_METHOD] (
    [GPAMoistureValuationMethodID] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]                         VARCHAR (100) NOT NULL,
    [CreatedDateTime]              DATETIME      CONSTRAINT [DF_cft_GPA_MOISTURE_VALUATION_METHOD_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                    VARCHAR (50)  NOT NULL,
    [UpdatedDateTime]              DATETIME      NULL,
    [UpdatedBy]                    VARCHAR (50)  NULL,
    CONSTRAINT [PK_cft_GPA_MOISTURE_VALUATION_METHOD] PRIMARY KEY CLUSTERED ([GPAMoistureValuationMethodID] ASC) WITH (FILLFACTOR = 90)
);

