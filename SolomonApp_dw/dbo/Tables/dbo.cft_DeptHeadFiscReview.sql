CREATE TABLE [dbo].[cft_DeptHeadFiscReview] (
    [Sub]         CHAR (24)    NULL,
    [Location]    CHAR (30)    NULL,
    [WherePeriod] CHAR (6)     NULL,
    [GroupPeriod] VARCHAR (20) NULL,
    [Descr]       CHAR (30)    NULL,
    [TranDesc]    CHAR (30)    NULL,
    [Amt]         FLOAT (53)   NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_DeptHeadFiscReview] TO [SE\ANALYSTS]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_DeptHeadFiscReview] TO [WTFReports]
    AS [dbo];

