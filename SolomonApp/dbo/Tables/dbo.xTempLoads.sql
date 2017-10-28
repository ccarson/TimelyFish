CREATE TABLE [dbo].[xTempLoads] (
    [LoadNumber] CHAR (10)      NULL,
    [ContactID]  NVARCHAR (255) NULL,
    [Name]       NVARCHAR (255) NULL,
    [Barn]       FLOAT (53)     NULL,
    [Bin]        FLOAT (53)     NULL,
    [PigGroup]   FLOAT (53)     NULL,
    [DateReq]    SMALLDATETIME  NULL,
    [Comment]    NVARCHAR (255) NULL,
    [Ord]        FLOAT (53)     NULL,
    [QtyOrd]     FLOAT (53)     NULL,
    [InvtIdOrd]  NVARCHAR (255) NULL,
    [TruckID]    CHAR (10)      NULL,
    [DriverID]   CHAR (10)      NULL
);

