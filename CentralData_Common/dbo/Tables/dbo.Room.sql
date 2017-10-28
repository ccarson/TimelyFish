CREATE TABLE [dbo].[Room] (
    [RoomID]              INT          IDENTITY (5000, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]           INT          NOT NULL,
    [BarnID]              INT          NOT NULL,
    [RoomNbr]             VARCHAR (10) NOT NULL,
    [RoomDescription]     VARCHAR (30) NULL,
    [FacilityTypeID]      INT          NULL,
    [StatusTypeID]        INT          CONSTRAINT [DF_Room_StatusTypeID] DEFAULT (1) NULL,
    [BarnCapPercentage]   FLOAT (53)   NULL,
    [FinFile]             VARCHAR (30) NULL,
    [WFFinFile2]          VARCHAR (30) NULL,
    [Width]               FLOAT (53)   NULL,
    [Length]              FLOAT (53)   NULL,
    [Height]              FLOAT (53)   NULL,
    [DefaultGenderTypeID] VARCHAR (50) NULL,
    [DefaultFeedPlanID]   INT          NULL,
    [PigChampLocationID]  VARCHAR (4)  NULL,
    CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED ([RoomID] ASC) WITH (FILLFACTOR = 90)
);

