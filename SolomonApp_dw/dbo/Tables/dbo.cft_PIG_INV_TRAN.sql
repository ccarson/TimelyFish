CREATE TABLE [dbo].[cft_PIG_INV_TRAN] (
    [PigGroupID]    CHAR (10) NOT NULL,
    [Source]        CHAR (10) NULL,
    [TranSubTypeID] CHAR (2)  NULL,
    [Qty]           INT       NULL
);


GO
CREATE NONCLUSTERED INDEX [NC_NU_cft_PG_INV_TRAN_Source]
    ON [dbo].[cft_PIG_INV_TRAN]([PigGroupID] ASC);

