
CREATE PROCEDURE [dbo].[WSL_PAFlexKey]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 nvarchar(30)
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int

      IF @sort = '' SET @sort = 'control_code'
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
	'SELECT control_code [Code],
		 SUBSTRING(control_data,1,1) as [Segments],
	     SUBSTRING(control_data,2,16) as [Caption],
	     SUBSTRING(control_data,18,1) as [Delimiter],
	     SUBSTRING(control_data,19,12) as [Caption1],
	     SUBSTRING(control_data,31,2) as [Seg1Len],
	     SUBSTRING(control_data,33,1) as [Mask1],
	     SUBSTRING(control_data,34,4) as [CodeType1],
		 case len(SUBSTRING(control_data,34,4)) when 0 then 
				SUBSTRING(control_data,38,20) else ''none'' end as [Values1],
	     SUBSTRING(control_data,58,12) as [Caption2],
	     SUBSTRING(control_data,70,2) as [Seg2Len],
	     SUBSTRING(control_data,72,1) as [Mask2],
	     SUBSTRING(control_data,73,4) as [CodeType2],
		 case len(SUBSTRING(control_data,73,4)) when 0 then 
				SUBSTRING(control_data,77,20) else  ''none'' end as [Values2],
	     SUBSTRING(control_data,97,12) as [Caption3],
	     SUBSTRING(control_data,109,2) as [Seg3Len],
	     SUBSTRING(control_data,111,1) as [Mask3],
	     SUBSTRING(control_data,112,4) as [CodeType3],
		 case len(SUBSTRING(control_data,112,4)) when 0 then 
				SUBSTRING(control_data,116,20) else  ''none'' end as [Values3],
	     SUBSTRING(control_data,136,12) as [Caption4],
	     SUBSTRING(control_data,148,2) as [Seg4Len],
	     SUBSTRING(control_data,150,1) as [Mask4],
	     SUBSTRING(control_data,151,4) as [CodeType4],
		 case len(SUBSTRING(control_data,151,4)) when 0 then 
				SUBSTRING(control_data,155,20) else  ''none'' end as [Values4],
	     SUBSTRING(control_data,175,12) as [Caption5],
	     SUBSTRING(control_data,187,2) as [Seg5Len],
	     SUBSTRING(control_data,189,1) as [Mask5],
	     SUBSTRING(control_data,190,4) as [CodeType5],
		 case len(SUBSTRING(control_data,190,4)) when 0 then 
				SUBSTRING(control_data,194,20) else  ''none'' end as [Values5],
	     SUBSTRING(control_data,214,12) as [Caption6],
	     SUBSTRING(control_data,226,2) as [Seg6Len],
	     SUBSTRING(control_data,228,1) as [Mask6],
	     SUBSTRING(control_data,229,4) as [CodeType6],
		 case len(SUBSTRING(control_data,229,4)) when 0 then 
				SUBSTRING(control_data,233,20) else  ''none'' end as [Values6]
			  FROM PJCONTRL (nolock)
			WHERE (control_code = ' +  quotename(@parm1,'''') +  ' or ' + quotename(@parm1,'''') +  ' = '''') and control_type = ''FK''
			ORDER BY ' + @sort
	  END	
  ELSE
	  BEGIN
			IF @page < 1 SET @page = 1
			IF @size < 1 SET @size = 1
			SET @lbound = (@page-1) * @size
			SET @ubound = @page * @size + 1
			SET @STMT = 'WITH PagingCTE AS
				( SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') control_code [Code],
		 SUBSTRING(control_data,1,1) as [Segments],
	     SUBSTRING(control_data,2,16) as [Caption],
	     SUBSTRING(control_data,18,1) as [Delimiter],
	     SUBSTRING(control_data,19,12) as [Caption1],
	     SUBSTRING(control_data,31,2) as [Seg1Len],
	     SUBSTRING(control_data,33,1) as [Mask1],
	     SUBSTRING(control_data,34,4) as [CodeType1],
		 case len(SUBSTRING(control_data,34,4)) when 0 then 
				SUBSTRING(control_data,38,20) else ''none'' end as [Values1],
	     SUBSTRING(control_data,58,12) as [Caption2],
	     SUBSTRING(control_data,70,2) as [Seg2Len],
	     SUBSTRING(control_data,72,1) as [Mask2],
	     SUBSTRING(control_data,73,4) as [CodeType2],
		 case len(SUBSTRING(control_data,73,4)) when 0 then 
				SUBSTRING(control_data,77,20) else  ''none'' end as [Values2],
	     SUBSTRING(control_data,97,12) as [Caption3],
	     SUBSTRING(control_data,109,2) as [Seg3Len],
	     SUBSTRING(control_data,111,1) as [Mask3],
	     SUBSTRING(control_data,112,4) as [CodeType3],
		 case len(SUBSTRING(control_data,112,4)) when 0 then 
				SUBSTRING(control_data,116,20) else  ''none'' end as [Values3],
	     SUBSTRING(control_data,136,12) as [Caption4],
	     SUBSTRING(control_data,148,2) as [Seg4Len],
	     SUBSTRING(control_data,150,1) as [Mask4],
	     SUBSTRING(control_data,151,4) as [CodeType4],
		 case len(SUBSTRING(control_data,151,4)) when 0 then 
				SUBSTRING(control_data,155,20) else  ''none'' end as [Values4],
	     SUBSTRING(control_data,175,12) as [Caption5],
	     SUBSTRING(control_data,187,2) as [Seg5Len],
	     SUBSTRING(control_data,189,1) as [Mask5],
	     SUBSTRING(control_data,190,4) as [CodeType5],
		 case len(SUBSTRING(control_data,190,4)) when 0 then 
				SUBSTRING(control_data,194,20) else  ''none'' end as [Values5],
	     SUBSTRING(control_data,214,12) as [Caption6],
	     SUBSTRING(control_data,226,2) as [Seg6Len],
	     SUBSTRING(control_data,228,1) as [Mask6],
	     SUBSTRING(control_data,229,4) as [CodeType6],
		 case len(SUBSTRING(control_data,229,4)) when 0 then 
				SUBSTRING(control_data,233,20) else  ''none'' end as [Values6]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
			  FROM PJCONTRL (nolock) 
			WHERE (control_code = ' +  quotename(@parm1,'''') +  ' or ' + quotename(@parm1,'''') +  ' = '''') and control_type = ''FK'' )
			SELECT Code,Segments,Caption,Delimiter,
				Caption1,Seg1Len,Mask1,CodeType1,Values1,	  	 
				Caption2,Seg2Len,Mask2,CodeType2,Values2,	  	 
				Caption3,Seg3Len,Mask3,CodeType3,Values3,	  	 
				Caption4,Seg4Len,Mask4,CodeType4,Values4,	  	 
				Caption5,Seg5Len,Mask5,CodeType5,Values5,	  	 
				Caption6,Seg6Len,Mask6,CodeType6,Values6	
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	END			   	 
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_PAFlexKey] TO [MSDSL]
    AS [dbo];

