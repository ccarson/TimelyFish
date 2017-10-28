CREATE TABLE [dbo].[cft_CONTACT_RECURRING_EVENT] (
    [RecurringEventID]         INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]                INT            NOT NULL,
    [EventType]                INT            NOT NULL,
    [Recurring]                BIT            CONSTRAINT [DF_cft_CONTACT_RECURRING_EVENT_Recurring] DEFAULT (0) NULL,
    [RecurringWeeklyDay]       INT            NULL,
    [RecurringMonthlyDay]      INT            NULL,
    [RecurringNumberOfBushels] INT            NULL,
    [SingleEventDate]          DATETIME       NULL,
    [Comments]                 VARCHAR (2000) NULL,
    [CreatedDateTime]          DATETIME       CONSTRAINT [DF_cft_CONTACT_RECURRING_EVENT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                VARCHAR (50)   NOT NULL,
    [UpdatedDateTime]          DATETIME       NULL,
    [UpdatedBy]                VARCHAR (50)   NULL,
    CONSTRAINT [PK_cft_CONTACT_RECURRING_EVENT] PRIMARY KEY CLUSTERED ([RecurringEventID] ASC) WITH (FILLFACTOR = 90)
);

