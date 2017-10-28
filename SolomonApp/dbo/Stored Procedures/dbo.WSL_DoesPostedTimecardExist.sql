
CREATE PROCEDURE WSL_DoesPostedTimecardExist 
  @parm1 smalldatetime -- Post Date
 ,@parm2 varchar(10) -- Employee ID 
 AS  
  SET NOCOUNT ON  
  DECLARE  
    @STMT nvarchar(max),
	@status varchar(1) = 'P' 
  SET @STMT =   
   'SELECT docnbr [Doc Number]  
    FROM PJLABHDR(nolock)  
    where pe_date = ' + quotename(@parm1,'''') + '
		and employee = ' + quotename(@parm2,'''') + '
		and le_status = ' + quotename(@status,'''')

  EXEC (@STMT)   


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_DoesPostedTimecardExist] TO [MSDSL]
    AS [dbo];

