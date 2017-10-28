CREATE TABLE [dbo].[ROSSOpenGroupInput] (
    [Factory]        VARCHAR (3)   NOT NULL,
    [JobNumber]      VARCHAR (10)  NOT NULL,
    [ProcessStage]   VARCHAR (6)   NOT NULL,
    [SiteNumber]     VARCHAR (6)   NOT NULL,
    [BldgRoom]       VARCHAR (6)   NOT NULL,
    [PMDate]         SMALLDATETIME NOT NULL,
    [PartCode]       VARCHAR (30)  NOT NULL,
    [ICLotNumber]    VARCHAR (20)  NOT NULL,
    [CostCategory]   VARCHAR (2)   NOT NULL,
    [Description]    VARCHAR (30)  NOT NULL,
    [InputQtyActual] FLOAT (53)    NOT NULL,
    [UnitCost]       FLOAT (53)    NOT NULL,
    [TotalCost]      FLOAT (53)    NOT NULL
);

