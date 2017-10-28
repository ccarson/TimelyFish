
CREATE PROCEDURE [dbo].[WSL_Equipment]
 @parm1 char (10), -- Equipment ID
 @parm2 smalldatetime, -- Date of Timesheet Detail
 @parm3 char (10), -- Project ID
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
AS
  SET NOCOUNT ON

 	DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int

  IF @sort = '' SET @sort = 'EquipmentID'
  IF @page < 1 SET @page = 1
  IF @size < 1 SET @size = 1
  SET @lbound = (@page-1) * @size
  SET @ubound = @page * @size + 1
  SET @STMT = 
 	 	'WITH PagingCTE AS
 	 	(
 	 	SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ') e.equip_id [EquipmentID], e.equip_desc [EquipmentDescription], r.unit_of_measure [UOM], SUBSTRING(e.er_id05, 2, 1) [PostToGL]
 	 	,ROW_NUMBER() OVER(
 	 	ORDER BY e.equip_id) AS row
 	 	FROM PJEQUIP e INNER JOIN PJEQRATE r ON e.equip_id = r.equip_id where e.equip_id like ' + quotename(RTRIM(@parm1),'''') + ' AND (r.project = ''NA'' OR r.project like ' + quotename(RTRIM(@parm3),'''') + ')
 	 	AND r.effect_date = (SELECT MAX(effect_date) FROM PJEQRATE WHERE effect_date <= ''' + RTRIM(REPLACE(@parm2,'''','')) + ''' AND equip_id like ' + quotename(RTRIM(@parm1),'''') + ' AND (r.project = ''NA'' OR r.project like ' + quotename(RTRIM(@parm3),'''') + '))
 	 	) 
 	 	SELECT *
 	 	FROM PagingCTE                     
 	 	WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
 	 	 	 	row <  ' + CONVERT(varchar(9), @ubound) + '
 	 	ORDER BY ' + @sort 	 	 	 	
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_Equipment] TO [MSDSL]
    AS [dbo];

