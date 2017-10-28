 Create Proc  PRTableHeader_All2 @parm1 varchar ( 4), @parm2 varchar ( 4) as
       Select * from PRTableHeader
           where CalYr = @parm1
             and PayTblId like @parm2
           order by PayTblId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTableHeader_All2] TO [MSDSL]
    AS [dbo];

