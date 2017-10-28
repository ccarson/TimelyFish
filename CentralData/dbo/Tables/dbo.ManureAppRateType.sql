CREATE TABLE [dbo].[ManureAppRateType] (
    [ManureAppRateTypeID]           INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureApplRateTypeDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_ManureAppRateType] PRIMARY KEY CLUSTERED ([ManureAppRateTypeID] ASC) WITH (FILLFACTOR = 90)
);

