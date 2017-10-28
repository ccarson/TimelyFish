CREATE PROCEDURE xapcheck_all @BatNbr varchar(10) AS
Select * from XAPCheck where BatNbr like @BatNbr and Printed = 1 order by BatNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[xapcheck_all] TO [MSDSL]
    AS [dbo];

