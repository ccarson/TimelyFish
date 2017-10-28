CREATE TABLE [dbo].[Sample] (
    [SampleID]               INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteOrField]            INT           NULL,
    [SiteContactID]          INT           NULL,
    [SiteID]                 VARCHAR (4)   NULL,
    [FieldID]                INT           NULL,
    [EntityTypeID]           INT           NULL,
    [OtherEntityDescription] VARCHAR (30)  NULL,
    [DateSampled]            SMALLDATETIME NULL,
    [DateReceived]           SMALLDATETIME NULL,
    [LabSampleID]            VARCHAR (30)  NULL,
    [LabReportDate]          SMALLDATETIME NULL,
    [TestingLab]             INT           NULL,
    [OurPONbr]               VARCHAR (30)  NULL,
    [SampleDescription]      VARCHAR (30)  NULL,
    [SampleFormID]           INT           NULL,
    [SampleFormDescription]  VARCHAR (30)  NULL,
    [SamplingMethodID]       INT           NULL,
    [SampleTypeID]           INT           NULL,
    CONSTRAINT [PK_TestSample] PRIMARY KEY CLUSTERED ([SampleID] ASC) WITH (FILLFACTOR = 90)
);

