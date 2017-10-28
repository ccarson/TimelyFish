 /****** Object:  Stored Procedure dbo.ARDoc_BatNbr_CustId_RefNbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_BatNbr_CustId_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 15),
                                            @parm3 varchar ( 10), @parm4 varchar(2) AS
    Select * from ARDoc where BatNbr = @parm1
        and CustId = @parm2
        and RefNbr = @parm3
        and DocType = @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_BatNbr_CustId_RefNbr] TO [MSDSL]
    AS [dbo];

