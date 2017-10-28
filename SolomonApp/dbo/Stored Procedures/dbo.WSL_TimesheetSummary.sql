
CREATE PROCEDURE [dbo].[WSL_TimesheetSummary]
 @parm1 char (10), -- Document number
  @page  int       --Unused
 ,@size  int       --Unused
 ,@sort   nvarchar(200)--Unused
AS
  SET NOCOUNT ON

  SELECT h.docnbr,
 	SUM(ISNULL(d.ot1_hours, 0)) + SUM(ISNULL(d.ot2_hours, 0)) + SUM(ISNULL(d.reg_hours, 0)) AS [TotalHours]
  FROM PJTIMHDR h LEFT OUTER JOIN PJTIMDET d ON h.docnbr = d.docnbr
  WHERE h.docnbr = @parm1
  GROUP BY h.docnbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TimesheetSummary] TO [MSDSL]
    AS [dbo];

