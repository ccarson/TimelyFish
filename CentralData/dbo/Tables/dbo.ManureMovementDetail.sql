CREATE TABLE [dbo].[ManureMovementDetail] (
    [LineNbr]                         INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureMovementID]                INT           NOT NULL,
    [MovementDate]                    SMALLDATETIME NULL,
    [ApplicationFirmID]               INT           NULL,
    [ApplicationFirmRepresentativeID] INT           NULL,
    [Qty]                             FLOAT (53)    NULL,
    [WindSpeed]                       VARCHAR (20)  NULL,
    [WindDirection]                   VARCHAR (30)  NULL,
    [Temperature]                     VARCHAR (20)  NULL,
    [Humidity]                        VARCHAR (10)  NULL,
    [SoilConditions]                  VARCHAR (30)  NULL,
    [Comment]                         VARCHAR (60)  NULL,
    [Rain]                            VARCHAR (20)  NULL,
    [EquipmentChecklist]              VARCHAR (20)  NULL,
    CONSTRAINT [PK_ManureMovementDetail] PRIMARY KEY CLUSTERED ([LineNbr] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ManureMovementDetail_ManureMovement] FOREIGN KEY ([ManureMovementID]) REFERENCES [dbo].[ManureMovement] ([ManureMovementID]) ON DELETE CASCADE
);

