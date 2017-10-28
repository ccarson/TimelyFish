 Create Procedure ARDoc_DocClasses_RefNbr_CpnyID @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar (10) as
    Select * from ARDoc where CpnyId = @parm1 and DocClass = 'P' and Custid = @parm2
                          and refnbr like @parm3 order by CpnyId, DocClass, RefNbr


