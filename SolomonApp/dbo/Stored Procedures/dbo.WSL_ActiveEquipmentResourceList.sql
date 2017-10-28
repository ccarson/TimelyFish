
CREATE PROCEDURE WSL_ActiveEquipmentResourceList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Equipment ID

AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'PJEQUIP.equip_id'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
          'SELECT PJEQUIP.equip_id [Equip/Resource ID], PJEQUIP.cpnyId [Company], 
                  PJEQUIP.equip_desc [Description], PJEQUIP.status [Status]				     
			 FROM PJEQUIP (nolock)
            WHERE PJEQUIP.equip_id like ' + quotename(@parm1,'''') + '
              AND PJEQUIP.status = ''A'' 
  			ORDER BY ' + @sort
	  END		 
  ELSE
	  BEGIN
			IF @page < 1 SET @page = 1
			IF @size < 1 SET @size = 1
			SET @lbound = (@page-1) * @size
			SET @ubound = @page * @size + 1
			SET @STMT = 
				'WITH PagingCTE AS
				(
                 SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') PJEQUIP.equip_id, 
                 PJEQUIP.cpnyId, PJEQUIP.equip_desc, PJEQUIP.status                 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
			       FROM PJEQUIP (nolock)
                  WHERE PJEQUIP.equip_id like ' + quotename(@parm1,'''') + '
                    AND PJEQUIP.status = ''A''  
				) 
				SELECT equip_id [Equip/Resource ID], cpnyId [Company], 
                       equip_desc [Description], status [Status]	
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ActiveEquipmentResourceList] TO [MSDSL]
    AS [dbo];

