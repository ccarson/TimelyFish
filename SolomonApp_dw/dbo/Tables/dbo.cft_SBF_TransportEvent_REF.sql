CREATE TABLE [dbo].[cft_SBF_TransportEvent_REF] (
    [PigMovementID]       INT          NOT NULL,
    [PigTruckLoadID]      INT          NOT NULL,
    [SourcePigGroupID]    CHAR (10)    NOT NULL,
    [DestPigGroupID]      CHAR (10)    NOT NULL,
    [LoadPickupDateTime]  DATETIME     NULL,
    [SBF_SourceContactID] VARCHAR (5)  NULL,
    [SourceBarnNbr]       VARCHAR (5)  NULL,
    [SourceRoomNbr]       VARCHAR (8)  NULL,
    [SBF_DestContactID]   VARCHAR (5)  NULL,
    [DestBarnNbr]         VARCHAR (5)  NULL,
    [DestRoomNbr]         VARCHAR (8)  NULL,
    [EstimatedQty]        INT          NULL,
    [Split]               CHAR (1)     NULL,
    [Weans]               CHAR (1)     NULL,
    [MailAction]          VARCHAR (20) NULL,
    [MailedDate]          DATETIME     NULL,
    CONSTRAINT [PK_cft_SBF_TransportEvent_REF] PRIMARY KEY CLUSTERED ([PigMovementID] ASC, [PigTruckLoadID] ASC) WITH (FILLFACTOR = 90)
);

