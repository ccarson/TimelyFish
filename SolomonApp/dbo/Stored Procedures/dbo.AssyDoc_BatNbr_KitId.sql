 /****** Object:  Stored Procedure dbo.AssyDoc_BatNbr_KitId    Script Date: 4/17/98 10:58:16 AM ******/
/****** Object:  Stored Procedure dbo.AssyDoc_BatNbr_KitId    Script Date: 4/16/98 7:41:51 PM ******/
Create Proc AssyDoc_BatNbr_KitId @parm1 varchar ( 10), @parm2 varchar ( 30) as
    Select * from AssyDoc
                where BatNbr = @parm1
                and KitId like @parm2
                order by BatNbr, KitId


