CREATE TABLE [dbo].[cft_TRANSPORTATION_SCHEDULE_DELIVERY_TYPE] (
    [ScheduleDeliveryTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ScheduleDeliveryTypeDescription] VARCHAR (50) NULL,
    [CreatedDateTime]                 DATETIME     CONSTRAINT [DF_cft_TRANSPORTATION_SCHEDULE_DELIVERY_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                       VARCHAR (50) NOT NULL,
    [UpdatedDateTime]                 DATETIME     NULL,
    [UpdatedBy]                       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_TRANSPORTATION_SCHEDULE_DELIVERY_TYPE] PRIMARY KEY CLUSTERED ([ScheduleDeliveryTypeID] ASC) WITH (FILLFACTOR = 90)
);

