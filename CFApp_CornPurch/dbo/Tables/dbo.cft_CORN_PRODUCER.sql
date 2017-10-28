CREATE TABLE [dbo].[cft_CORN_PRODUCER] (
    [CornProducerID]        VARCHAR (15)   NOT NULL,
    [ContactID]             INT            NOT NULL,
    [DefaultFeedMillID]     CHAR (10)      NULL,
    [DefaultCornMarketerID] INT            NULL,
    [Active]                BIT            NULL,
    [CornCheckoff]          BIT            CONSTRAINT [DF_cft_CORN_PRODUCER_CornCheckoff] DEFAULT (0) NULL,
    [EthanolCheckoff]       BIT            CONSTRAINT [DF_cft_CORN_PRODUCER_EthanolCheckoff] DEFAULT (0) NULL,
    [ReceiveCornBidSheet]   BIT            CONSTRAINT [DF_cft_CORN_PRODUCER_ReceiveCornBidSheet] DEFAULT (0) NULL,
    [HasLien]               BIT            NULL,
    [Comments]              VARCHAR (5000) NULL,
    [TicketReminderNote]    VARCHAR (2000) NULL,
    [CreatedDateTime]       DATETIME       CONSTRAINT [DF_cft_CORN_PRODUCER_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (50)   NOT NULL,
    [UpdatedDateTime]       DATETIME       NULL,
    [UpdatedBy]             VARCHAR (50)   NULL,
    [Elevator]              BIT            NULL,
    CONSTRAINT [PK_CORN_PRODUCER] PRIMARY KEY CLUSTERED ([CornProducerID] ASC) WITH (FILLFACTOR = 90)
);

