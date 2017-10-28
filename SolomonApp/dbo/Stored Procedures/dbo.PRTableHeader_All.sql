 Create Proc  PRTableHeader_All @parm1 varchar ( 4) as
       Select * from PRTableHeader
           where PayTblId like @parm1
           order by PayTblId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTableHeader_All] TO [MSDSL]
    AS [dbo];

