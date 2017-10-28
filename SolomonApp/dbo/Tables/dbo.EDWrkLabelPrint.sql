CREATE TABLE [dbo].[EDWrkLabelPrint] (
    [ContainerID]   CHAR (10)     CONSTRAINT [DF_EDWrkLabelPrint_ContainerID] DEFAULT (' ') NOT NULL,
    [CpnyID]        CHAR (10)     CONSTRAINT [DF_EDWrkLabelPrint_CpnyID] DEFAULT (' ') NOT NULL,
    [DataFile]      CHAR (255)    CONSTRAINT [DF_EDWrkLabelPrint_DataFile] DEFAULT (' ') NOT NULL,
    [IniFileName]   CHAR (255)    CONSTRAINT [DF_EDWrkLabelPrint_IniFileName] DEFAULT (' ') NOT NULL,
    [LabelDBPath]   CHAR (255)    CONSTRAINT [DF_EDWrkLabelPrint_LabelDBPath] DEFAULT (' ') NOT NULL,
    [LabelFileName] CHAR (255)    CONSTRAINT [DF_EDWrkLabelPrint_LabelFileName] DEFAULT (' ') NOT NULL,
    [NbrCopy]       SMALLINT      CONSTRAINT [DF_EDWrkLabelPrint_NbrCopy] DEFAULT ((0)) NOT NULL,
    [Printed]       SMALLDATETIME CONSTRAINT [DF_EDWrkLabelPrint_Printed] DEFAULT ('01/01/1900') NOT NULL,
    [PrinterName]   CHAR (20)     CONSTRAINT [DF_EDWrkLabelPrint_PrinterName] DEFAULT (' ') NOT NULL,
    [ShipperID]     CHAR (15)     CONSTRAINT [DF_EDWrkLabelPrint_ShipperID] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_EDWrkLabelPrint_SiteID] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [EDWrkLabelPrint0] PRIMARY KEY CLUSTERED ([ContainerID] ASC) WITH (FILLFACTOR = 90)
);

