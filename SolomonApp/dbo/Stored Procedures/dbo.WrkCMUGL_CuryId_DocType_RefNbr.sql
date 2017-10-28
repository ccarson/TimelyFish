 /****** Object:  Stored Procedure dbo.WrkCMUGL_CuryId_DocType_RefNbr    Script Date: 4/7/98 12:43:41 PM ******/
Create Proc  WrkCMUGL_CuryId_DocType_RefNbr @parm1 varchar ( 4), @parm2 varchar ( 2), @parm3 varchar ( 10), @parm4 smallint as
       Select * from WrkCMUGL
           where CuryId like @parm1
           and DocType like @parm2
           and RefNbr like @parm3
           and RI_ID like @parm4	 
           order by CuryId, DocType, RefNbr 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkCMUGL_CuryId_DocType_RefNbr] TO [MSDSL]
    AS [dbo];

