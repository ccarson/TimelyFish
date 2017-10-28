 CREATE PROCEDURE ARTran_UTran_CustID  @CustID AS VARCHAR (15) AS
   SELECT * FROM ARTran WHERE CustID = @CustID and DrCr = 'U'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTran_UTran_CustID] TO [MSDSL]
    AS [dbo];

