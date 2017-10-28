CREATE TABLE [dimension].[Date] (
    [DateKey]        INT      NOT NULL,
    [FullDate]       DATETIME NOT NULL,
    [PICCycle]       AS       (CONVERT([int],datediff(day,'1971-09-27',[FullDate])/(1000))),
    [PICDay]         AS       (CONVERT([int],datediff(day,'1971-09-27',[FullDate])%(1000))),
    [PICCycleAndDay] AS       (CONVERT([nvarchar](10),(CONVERT([nvarchar](8),datediff(day,'1971-09-27',[FullDate])/(1000))+N'-')+CONVERT([nvarchar](8),datediff(day,'1971-09-27',[FullDate])%(1000)))),
    CONSTRAINT [PK_Date] PRIMARY KEY CLUSTERED ([DateKey] ASC)
);







