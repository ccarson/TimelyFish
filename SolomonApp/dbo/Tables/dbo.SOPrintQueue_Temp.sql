CREATE TABLE [dbo].[SOPrintQueue_Temp] (
    [CpnyID]     CHAR (10) CONSTRAINT [DF_SOPrintQueue_Temp_CpnyID] DEFAULT (' ') NOT NULL,
    [DeviceName] CHAR (40) CONSTRAINT [DF_SOPrintQueue_Temp_DeviceName] DEFAULT (' ') NOT NULL,
    [InvcNbr]    CHAR (15) CONSTRAINT [DF_SOPrintQueue_Temp_InvcNbr] DEFAULT (' ') NOT NULL,
    [NotesOn]    SMALLINT  CONSTRAINT [DF_SOPrintQueue_Temp_NotesOn] DEFAULT ((0)) NOT NULL,
    [OrdNbr]     CHAR (15) CONSTRAINT [DF_SOPrintQueue_Temp_OrdNbr] DEFAULT (' ') NOT NULL,
    [ReportName] CHAR (30) CONSTRAINT [DF_SOPrintQueue_Temp_ReportName] DEFAULT (' ') NOT NULL,
    [Reprint]    SMALLINT  CONSTRAINT [DF_SOPrintQueue_Temp_Reprint] DEFAULT ((0)) NOT NULL,
    [RI_ID]      SMALLINT  CONSTRAINT [DF_SOPrintQueue_Temp_RI_ID] DEFAULT ((0)) NOT NULL,
    [Seq]        CHAR (4)  CONSTRAINT [DF_SOPrintQueue_Temp_Seq] DEFAULT (' ') NOT NULL,
    [ShipperID]  CHAR (15) CONSTRAINT [DF_SOPrintQueue_Temp_ShipperID] DEFAULT (' ') NOT NULL,
    [SiteID]     CHAR (10) CONSTRAINT [DF_SOPrintQueue_Temp_SiteID] DEFAULT (' ') NOT NULL,
    [SOTypeID]   CHAR (4)  CONSTRAINT [DF_SOPrintQueue_Temp_SOTypeID] DEFAULT (' ') NOT NULL,
    CONSTRAINT [SOPrintQueue_Temp0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [CpnyID] ASC, [OrdNbr] ASC, [ShipperID] ASC) WITH (FILLFACTOR = 90)
);

