 Create Proc AssyDoc_BatNbr_RefNbr
    @parm1 varchar ( 10),
    @parm2 varchar ( 15)
as
Select * from AssyDoc
    where BatNbr = @parm1
       and RefNbr like @parm2
    order by BatNbr, RefNbr


