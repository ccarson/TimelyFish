CREATE TABLE [dbo].[ManureApplicationPlanAnalyteDetail] (
    [ManureApplicationPlanID] INT        NOT NULL,
    [AnalyteID]               INT        NOT NULL,
    [AnalyteValue]            FLOAT (53) NULL,
    [AnalyteAvailFactor]      FLOAT (53) CONSTRAINT [DF_ManureApplicationPlanAnalyteDetail_AnalyteAvailFactor] DEFAULT (0) NOT NULL,
    [AnalyteAvailPer1000Ga]   FLOAT (53) NULL,
    [MarketValue]             FLOAT (53) CONSTRAINT [DF_ManureApplicationPlanAnalyteDetail_MarketValue] DEFAULT (0) NOT NULL,
    CONSTRAINT [PK_ManureApplicationPlanAnalyteDetail] PRIMARY KEY CLUSTERED ([ManureApplicationPlanID] ASC, [AnalyteID] ASC) WITH (FILLFACTOR = 90)
);

