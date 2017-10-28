 
 CREATE PROCEDURE Get_Account_Category @gl_acct VarChar(10), @AcctCategoryResult VARCHAR(16) OUTPUT                         
AS
  DECLARE @AcctCategory VARCHAR(16)
  
  SELECT @AcctCategory = acct
    FROM PJ_Account WITH(NOLOCK)
   WHERE gl_acct = @gl_acct

  IF @AcctCategory is Null
     BEGIN
        SET @AcctCategoryResult = ''
     END
  ELSE
    BEGIN
       SET @AcctCategoryResult = @AcctCategory
    END  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Get_Account_Category] TO [MSDSL]
    AS [dbo];

