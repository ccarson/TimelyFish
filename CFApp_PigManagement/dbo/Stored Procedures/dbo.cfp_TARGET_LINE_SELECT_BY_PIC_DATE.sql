-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 11/11/2009
-- Description:	Selects target lines by pic date
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_SELECT_BY_PIC_DATE]
(
	@FlowDate smalldatetime
,	@TargetLineMasterTypeID int
,	@PicYear int
,	@PicWeek int
)
AS
BEGIN

WHILE 1 = 0 
BEGIN
	SELEcT ID = 1 INTO ##TargetLineData WHERE 1 = 0 ; 
END

DECLARE @CreateTable varchar(8000)
set @CreateTable = ''

-- dynamically create the target line columns
DECLARE @TargetLineTypeID int
DECLARE @TargetLineTypeDescription varchar(50)
DECLARE target_line_table_build CURSOR FOR
SELECT TargetLineTypeID, TargetLineTypeDescription
FROM dbo.cft_TARGET_LINE_TYPE (NOLOCK)
WHERE TargetLineMasterTypeID = @TargetLineMasterTypeID

OPEN target_line_table_build

FETCH NEXT FROM target_line_table_build
INTO @TargetLineTypeID, @TargetLineTypeDescription

WHILE @@FETCH_STATUS = 0
BEGIN
-- create columns
	SET @CreateTable = @CreateTable + ',[' + @TargetLineTypeDescription + '] VARCHAR(1000) NULL '

FETCH NEXT FROM target_line_table_build
INTO @TargetLineTypeID, @TargetLineTypeDescription
END

CLOSE target_line_table_build
DEALLOCATE target_line_table_build

--build table
SET @CreateTable = @CreateTable + ')'
--print @CreateTable

EXEC ('CREATE TABLE ##TargetLineData
(     TargetLineMasterTypeID int
,     PigFlowID int
,     PigFlowDescription varchar(100) ' + @CreateTable)

-- insert the valid pig flows
EXEC ('INSERT INTO ##TargetLineData (TargetLineMasterTypeID, PigFlowID, PigFlowDescription)
SELECT ' + @TargetLineMasterTypeID + ', PigFlowID, PigFlowDescription '
+ 'FROM dbo.cft_PIG_FLOW (NOLOCK)
WHERE ''' + @FlowDate + ''' BETWEEN PigFlowFromDate AND ISNULL(PigFlowToDate,''1/1/3000'')')


DECLARE target_line_data CURSOR FOR
SELECT TargetLineTypeID, TargetLineTypeDescription
FROM dbo.cft_TARGET_LINE_TYPE (NOLOCK)
WHERE TargetLineMasterTypeID = @TargetLineMasterTypeID

OPEN target_line_data

FETCH NEXT FROM target_line_data
INTO @TargetLineTypeID, @TargetLineTypeDescription

WHILE @@FETCH_STATUS = 0
BEGIN

-- fill data for this column
EXEC('UPDATE ##TargetLineData SET [' + @TargetLineTypeDescription + '] = tl.TargetLineValue '
      + 'FROM dbo.cft_TARGET_LINE tl (NOLOCK) '
      + 'JOIN ##TargetLineData tld ON tld.PigFlowID = tl.PigFlowID '
      + 'WHERE tl.TargetLineTypeID = ' + @TargetLineTypeID
      + ' AND tl.PicYear = ' + @PicYear + ' AND tl.PicWeek = ' + @PicWeek
      + ' AND tl.PigFlowID = tld.PigFlowID')

FETCH NEXT FROM target_line_data
INTO @TargetLineTypeID, @TargetLineTypeDescription
END

CLOSE target_line_data
DEALLOCATE target_line_data


SELECT * FROM ##TargetLineData
DROP TABLE ##TargetLineData
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_SELECT_BY_PIC_DATE] TO [db_sp_exec]
    AS [dbo];

