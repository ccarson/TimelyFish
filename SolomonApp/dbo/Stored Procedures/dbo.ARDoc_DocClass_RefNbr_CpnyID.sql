 /****** Object:  Stored Procedure dbo.ARDoc_DocClass_RefNbr_CpnyID    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_DocClass_RefNbr_CpnyID @parm1 varchar ( 10), @parm2 varchar ( 1), @parm3 varchar ( 10) as
    Select * from ARDoc where CpnyId = @parm1 and DocClass = @parm2
                          and refnbr like @parm3  and doctype <> 'VT'
     order by CpnyId, DocClass, RefNbr


