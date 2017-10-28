CREATE TABLE [dimension].[Genetics] (
    [GeneticsKey]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [GeneticsName]    NVARCHAR (30) NOT NULL,
    [Sex]             NCHAR (1)     NOT NULL,
    [IsDisabled]      BIT           DEFAULT ((0)) NOT NULL,
    [IsSystem]        BIT           DEFAULT ((0)) NOT NULL,
    [GeneticsSynonym] NVARCHAR (5)  NULL,
    [CreatedDate]     DATETIME      DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]       INT           DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]     DATETIME      NULL,
    [UpdatedBy]       INT           NULL,
    [DeletedDate]     DATETIME      NULL,
    [DeletedBy]       INT           NULL,
    [SourceID]        INT           NOT NULL,
    [SourceGUID]      NVARCHAR (36) NOT NULL,
    CONSTRAINT [PK_Genetics] PRIMARY KEY CLUSTERED ([GeneticsKey] ASC)
);

