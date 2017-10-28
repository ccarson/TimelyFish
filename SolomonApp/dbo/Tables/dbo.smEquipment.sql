CREATE TABLE [dbo].[smEquipment] (
    [Crdt_Prog]           CHAR (8)      NOT NULL,
    [Crtd_DateTime]       SMALLDATETIME NOT NULL,
    [Crtd_User]           CHAR (10)     NOT NULL,
    [EquipLocationType]   CHAR (1)      NOT NULL,
    [EquipmentCondDate]   SMALLDATETIME NOT NULL,
    [EquipmentCondition]  CHAR (1)      NOT NULL,
    [EquipmentDesc]       CHAR (30)     NOT NULL,
    [EquipmentEmployeeID] CHAR (10)     NOT NULL,
    [EquipmentID]         CHAR (10)     NOT NULL,
    [EquipmentMake]       CHAR (16)     NOT NULL,
    [EquipmentModel]      CHAR (16)     NOT NULL,
    [EquipmentPurDate]    SMALLDATETIME NOT NULL,
    [EquipmentSiteID]     CHAR (10)     NOT NULL,
    [EquipmentUsageID]    CHAR (10)     NOT NULL,
    [EquipmentVIN]        CHAR (16)     NOT NULL,
    [EquipmentYear]       CHAR (4)      NOT NULL,
    [Lupd_DateTime]       SMALLDATETIME NOT NULL,
    [Lupd_Prog]           CHAR (8)      NOT NULL,
    [Lupd_User]           CHAR (10)     NOT NULL,
    [User1]               CHAR (30)     NOT NULL,
    [User2]               CHAR (30)     NOT NULL,
    [User3]               FLOAT (53)    NOT NULL,
    [User4]               FLOAT (53)    NOT NULL,
    [User5]               CHAR (10)     NOT NULL,
    [User6]               CHAR (10)     NOT NULL,
    [User7]               SMALLDATETIME NOT NULL,
    [User8]               SMALLDATETIME NOT NULL,
    [tstamp]              ROWVERSION    NOT NULL,
    CONSTRAINT [smEquipment0] PRIMARY KEY CLUSTERED ([EquipmentID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smEquipment1]
    ON [dbo].[smEquipment]([EquipmentSiteID] ASC, [EquipmentCondition] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smEquipment2]
    ON [dbo].[smEquipment]([EquipmentEmployeeID] ASC, [EquipmentID] ASC) WITH (FILLFACTOR = 90);

