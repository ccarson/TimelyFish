 /****** Object:  Stored Procedure dbo.APDoc_QCPP_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_QCPP_RefNbr @parm1 varchar(1), @parm2 varchar ( 10), @parm3 varchar(10) as
Select * From APDoc
Where DocClass = @parm1 and CpnyID = @parm2 and (APDoc.DocType = 'VO' OR APDoc.DocType = 'PP')
and APDoc.RefNbr LIKE @parm3 and Status <> 'V'
Order by RefNbr


