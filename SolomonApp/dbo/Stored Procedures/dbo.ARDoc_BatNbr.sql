 /****** Object:  Stored Procedure dbo.ARDoc_BatNbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_BatNbr @parm1 varchar ( 10) as
    Select * from ARDoc where BatNbr = @parm1
        and DocType <> 'RC'
        order by BatNbr, BatSeq



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_BatNbr] TO [MSDSL]
    AS [dbo];

