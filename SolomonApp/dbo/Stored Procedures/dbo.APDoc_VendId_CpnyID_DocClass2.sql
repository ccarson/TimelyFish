 /****** Object:  Stored Procedure dbo.APDoc_VendId_CpnyID_DocClass2    Script Date: 3/9/00 12:19:55 PM ******/
Create Procedure APDoc_VendId_CpnyID_DocClass2 @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 10) As
Select * from APDoc where VendId = @parm1
and CpnyID like @parm2
and RefNbr like @parm3
and DocClass = 'N'
and DocType in ('VO', 'AC')
and OpenDoc = 1
and Rlsed = 1
and Selected = 0
Order by RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_VendId_CpnyID_DocClass2] TO [MSDSL]
    AS [dbo];

