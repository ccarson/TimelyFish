CREATE TABLE [dbo].[MTECHLOADORDERS] (
    [Infinity Rec No]       VARCHAR (20)  NULL,
    [Bin Feed Amount 1]     FLOAT (53)    NULL,
    [Bin Feed Amount 2]     FLOAT (53)    NULL,
    [Bin Feed Amount 3]     FLOAT (53)    NULL,
    [Bin Feed Amount 4]     FLOAT (53)    NULL,
    [Creation Date]         VARCHAR (40)  NULL,
    [Farm No]               VARCHAR (20)  NULL,
    [Farm Type]             VARCHAR (255) NULL,
    [Feed Delivery Area]    VARCHAR (255) NULL,
    [Feed Mill Code]        VARCHAR (20)  NOT NULL,
    [Feed Type]             VARCHAR (20)  NULL,
    [Flock Type]            VARCHAR (20)  NULL,
    [Formula No]            VARCHAR (255) NULL,
    [House No]              VARCHAR (255) NULL,
    [Last Mod Date]         VARCHAR (40)  NULL,
    [Load Date]             VARCHAR (50)  NULL,
    [Load No]               VARCHAR (20)  NULL,
    [Miscellaneous]         VARCHAR (255) NULL,
    [Pen No]                VARCHAR (255) NULL,
    [Projection Flag]       VARCHAR (20)  NULL,
    [Projection Rec No]     VARCHAR (20)  NULL,
    [Ref No]                VARCHAR (20)  NULL,
    [Replica Source ID]     VARCHAR (20)  NULL,
    [Replication Date Time] VARCHAR (40)  NULL,
    [Sflock No]             VARCHAR (20)  NULL,
    [Shipping Flag]         VARCHAR (20)  NULL,
    [Ticket Comment]        VARCHAR (255) NULL,
    [User ID]               VARCHAR (20)  NOT NULL,
    [ts]                    VARCHAR (40)  NULL,
    [DeliveryDate]          VARCHAR (50)  NULL,
    [Gross]                 FLOAT (53)    NULL,
    [FeedLoadInfinityRecNo] VARCHAR (255) NULL,
    [Miles]                 VARCHAR (20)  NULL,
    [Tare]                  VARCHAR (20)  NULL,
    [TruckNo]               VARCHAR (20)  NULL,
    [DriverNo]              VARCHAR (20)  NULL,
    [InvoiceNo]             VARCHAR (20)  NULL,
    [ScaleOperator]         VARCHAR (40)  NULL,
    [Void]                  VARCHAR (20)  NULL,
    [Processed]             VARCHAR (20)  NULL,
    [C1]                    VARCHAR (20)  NULL,
    [C2]                    VARCHAR (20)  NULL,
    [C3]                    VARCHAR (20)  NULL,
    [C4]                    VARCHAR (20)  NULL,
    [C5]                    VARCHAR (20)  NULL,
    [C6]                    VARCHAR (20)  NULL,
    [C7]                    VARCHAR (20)  NULL,
    [C8]                    VARCHAR (20)  NULL,
    [C9]                    VARCHAR (20)  NULL,
    [C10]                   VARCHAR (20)  NULL,
    [SQLTransferDTime]      DATETIME      NULL,
    [SQLRowCounter]         INT           NULL,
    [RowSeqNum_IO]          INT           NOT NULL,
    [SQLRowVersion]         ROWVERSION    NULL,
    [CreatedDateTime]       DATETIME      CONSTRAINT [DF_MTECHLOADORDERS_CreatedDateTime] DEFAULT (getdate()) NULL,
    CONSTRAINT [MTECHLOADORDER1_RowSeqNum_IO] PRIMARY KEY CLUSTERED ([RowSeqNum_IO] ASC, [Feed Mill Code] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [MTECHLOADORDERS_LoadDate]
    ON [dbo].[MTECHLOADORDERS]([Load Date] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [MTECHLOADORDERS_FeedOrder]
    ON [dbo].[MTECHLOADORDERS]([Ticket Comment] ASC) WITH (FILLFACTOR = 100);

