 /****** Object:  Stored Procedure dbo.APDoc_RefNbr_All    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_RefNbr_All @parm1 varchar(10), @parm2 varchar ( 10) as
Select * From APDoc
Where CpnyId Like @parm1 and RefNbr LIKE @parm2
Order by RefNbr DESC


