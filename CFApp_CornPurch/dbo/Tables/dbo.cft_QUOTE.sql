CREATE TABLE [dbo].[cft_QUOTE] (
    [QuoteID]         INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CornProducerID]  VARCHAR (15)    NOT NULL,
    [Price]           MONEY           NOT NULL,
    [Active]          BIT             NOT NULL,
    [NumberOfLoads]   INT             NOT NULL,
    [EffectiveDate]   DATETIME        NOT NULL,
    [EffectiveDateTo] DATETIME        NOT NULL,
    [Futures]         DECIMAL (18, 4) NOT NULL,
    [Basis]           DECIMAL (18, 4) NOT NULL,
    [CreatedDateTime] DATETIME        CONSTRAINT [DF_cft_QUOTE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)    NOT NULL,
    [UpdatedDateTime] DATETIME        NULL,
    [UpdatedBy]       VARCHAR (50)    NULL,
    [FeedMillID]      CHAR (10)       DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_cft_QUOTE] PRIMARY KEY CLUSTERED ([QuoteID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_QUOTE_cft_CORN_PRODUCER] FOREIGN KEY ([CornProducerID]) REFERENCES [dbo].[cft_CORN_PRODUCER] ([CornProducerID])
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_QUOTE_CornProducerID]
    ON [dbo].[cft_QUOTE]([CornProducerID] ASC) WITH (FILLFACTOR = 90);

