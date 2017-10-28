CREATE TABLE [dbo].[cft_GL] (
    [GlID]            INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [GlTypeID]        INT          NOT NULL,
    [FeedMillID]      CHAR (10)    NOT NULL,
    [ExpenseAccount]  VARCHAR (50) NULL,
    [SubAccount]      VARCHAR (50) NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_GL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_GL] PRIMARY KEY CLUSTERED ([GlID] ASC) WITH (FILLFACTOR = 90)
);

