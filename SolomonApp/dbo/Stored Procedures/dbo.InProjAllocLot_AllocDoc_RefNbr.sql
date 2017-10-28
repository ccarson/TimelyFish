Create Proc InProjAllocLot_AllocDoc_RefNbr  @parm1 varchar (15) as
    Select * from InProjAllocLot where RefNbr = @parm1
                  order by RefNbr
