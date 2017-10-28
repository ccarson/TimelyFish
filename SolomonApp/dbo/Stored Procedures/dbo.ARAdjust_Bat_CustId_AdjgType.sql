 /****** Object:  Stored Procedure dbo.ARAdjust_Bat_CustId_AdjgType    Script Date: 4/7/98 12:30:32 PM ******/
Create Proc ARAdjust_Bat_CustId_AdjgType @parm1 varchar ( 10), @parm2 varchar (15),  @parm3 varchar ( 10), @parm4 varchar ( 10) as
    Select * from ARAdjust where AdjBatnbr = @parm1
          and CustId = @parm2
           and AdjgDocType IN ('RP', 'NS')
           and AdjgRefNbr = @parm3
           and AdjdRefnbr = @parm4
           order by CustId, AdjgDocType,AdjgRefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARAdjust_Bat_CustId_AdjgType] TO [MSDSL]
    AS [dbo];

