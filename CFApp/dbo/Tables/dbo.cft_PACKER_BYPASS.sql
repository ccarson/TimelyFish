CREATE TABLE [dbo].[cft_PACKER_BYPASS] (
    [BypassID]        INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]       INT            NOT NULL,
    [FeedRation]      VARCHAR (1000) NULL,
    [PigProdPodID]    VARCHAR (3)    NOT NULL,
    [CreatedDateTime] DATETIME       CONSTRAINT [DF_cft_PACKER_BYPASS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)   NOT NULL,
    [UpdatedDateTime] DATETIME       NULL,
    [UpdatedBy]       VARCHAR (50)   NULL,
    CONSTRAINT [PK_cft_PACKER_BYPASS] PRIMARY KEY CLUSTERED ([BypassID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_PACKER_BYPASS] TO [master]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_PACKER_BYPASS] TO [07718158D19D4f5f9D23B55DBF5DF1]
    AS [dbo];

