 Create Proc ARadjust_Reversal @parm1 varchar ( 10), @parm2 varchar (15),  @parm3 varchar ( 10), @parm4 varchar ( 10) as
    Select * from ARAdjust where AdjBatnbr = @parm1
           and CustId = @parm2
           and AdjgDocType = "RP"
           and AdjgRefNbr = @parm3
           and AdjdRefnbr = @parm4


