 /****** Object:  Stored Procedure dbo.ARAdjust_CustId_AdjdType_Ref    Script Date: 4/7/98 12:30:32 PM ******/
Create Proc ARAdjust_CustId_AdjdType_Ref @parm1 varchar ( 15), @parm2 varchar ( 2), @parm3 varchar ( 10) as
    Select * from ARAdjust where CustId like @parm1
           and AdjdDocType = @parm2
           and AdjdRefNbr = @parm3
           order by CustId, AdjdDocType, AdjdRefNbr, AdjgDocDate


