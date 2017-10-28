CREATE TABLE [dbo].[cft_GPA_MOISTURE_CHARGE_DETAIL] (
    [GPAMoistureChargeDetailID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [GPAMoistureChargeID]       INT             NOT NULL,
    [Increment]                 DECIMAL (5, 2)  NOT NULL,
    [RangeFrom]                 DECIMAL (5, 2)  NOT NULL,
    [RangeTo]                   DECIMAL (5, 2)  NOT NULL,
    [Value]                     DECIMAL (14, 6) NOT NULL,
    [CreatedDateTime]           DATETIME        CONSTRAINT [DF_cft_GPA_MOISTURE_CHARGE_DETAIL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                 VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]           DATETIME        NULL,
    [UpdatedBy]                 VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_GPA_MOISTURE_CHARGE_DETAIL] PRIMARY KEY CLUSTERED ([GPAMoistureChargeDetailID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_GPA_MOISTURE_CHARGE_DETAIL_cft_GPA_MOISTURE_CHARGE] FOREIGN KEY ([GPAMoistureChargeID]) REFERENCES [dbo].[cft_GPA_MOISTURE_CHARGE] ([GPAMoistureChargeID])
);

