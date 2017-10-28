
CREATE PROCEDURE [dbo].[WSL_ProjectAddressList]
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'addr_key, addr_key_cd'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT PJADDR.addr_key [Project], PJADDR.addr_type_cd [Type], pjcode.code_value_desc [Description], PJADDR.comp_name, PJADDR.individual, PJADDR.title, PJADDR.addr1, PJADDR.addr2, PJADDR.city, PJADDR.[state], PJADDR.zip, PJADDR.phone, PJADDR.country, PJADDR.fax, PJADDR.email
			 FROM PJADDR,PJCODE (nolock)
			 where PJADDR.addr_key = ' + quotename(@parm1,'''') + ' And pjcode.code_type = ''ADTY'' and pjcode.code_value = pjaddr.addr_type_cd 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') PJADDR.addr_key [Project], PJADDR.addr_type_cd [Type], pjcode.code_value_desc [Description], PJADDR.comp_name, PJADDR.individual, PJADDR.title, PJADDR.addr1, PJADDR.addr2, PJADDR.city, PJADDR.[state], PJADDR.zip, PJADDR.phone, PJADDR.country, PJADDR.fax, PJADDR.email 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				 FROM PJADDR,PJCODE (nolock)
				 where PJADDR.addr_key = ' + quotename(@parm1,'''') + ' And pjcode.code_type = ''ADTY'' and pjcode.code_value = pjaddr.addr_type_cd 
				) 
				SELECT [Project], [Type], Description, comp_name, individual, title, addr1, addr2, city, [state], zip, phone, country, fax, email  
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectAddressList] TO [MSDSL]
    AS [dbo];

