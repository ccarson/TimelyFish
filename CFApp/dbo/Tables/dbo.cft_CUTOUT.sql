CREATE TABLE [dbo].[cft_CUTOUT] (
    [CutoutID]        INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [EffectiveDate]   DATETIME        NULL,
    [LoadValue]       DECIMAL (10, 4) NULL,
    [CutValue]        DECIMAL (10, 4) NULL,
    [TrimValue]       DECIMAL (10, 4) NULL,
    [CarcassValue]    DECIMAL (10, 4) NULL,
    [LoinValue]       DECIMAL (10, 4) NULL,
    [ButtValue]       DECIMAL (10, 4) NULL,
    [PicValue]        DECIMAL (10, 4) NULL,
    [RibValue]        DECIMAL (10, 4) NULL,
    [HamValue]        DECIMAL (10, 4) NULL,
    [BellyValue]      DECIMAL (10, 4) NULL,
    [CreatedDateTime] DATETIME        CONSTRAINT [DF_cft_CUTOUT_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50)    NOT NULL,
    [UpdatedDateTime] DATETIME        NULL,
    [UpdatedBy]       VARCHAR (50)    NULL,
    CONSTRAINT [PK_CUTOUT] PRIMARY KEY CLUSTERED ([CutoutID] ASC) WITH (FILLFACTOR = 90)
);

