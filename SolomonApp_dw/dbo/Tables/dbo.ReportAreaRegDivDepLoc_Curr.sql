CREATE TABLE [dbo].[ReportAreaRegDivDepLoc_Curr] (
    [Area]                  VARCHAR (20)   NULL,
    [region]                NVARCHAR (255) NULL,
    [DivisionID]            INT            NOT NULL,
    [DivisionCode]          NVARCHAR (5)   NULL,
    [DivisionDescription]   NVARCHAR (43)  NULL,
    [DepartmentID]          INT            NOT NULL,
    [DepartmentCode]        NVARCHAR (5)   NULL,
    [DepartmentDescription] NVARCHAR (43)  NULL,
    [LocationID]            INT            NOT NULL,
    [LocationCode]          NCHAR (20)     NOT NULL,
    [LocationDescription]   NVARCHAR (40)  NOT NULL
);

