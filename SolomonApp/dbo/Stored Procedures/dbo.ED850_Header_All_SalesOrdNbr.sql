 CREATE PROCEDURE ED850_Header_All_SalesOrdNbr  @parm1 varchar(15)  As Select * from Ed850Header where OrdNbr = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850_Header_All_SalesOrdNbr] TO [MSDSL]
    AS [dbo];

