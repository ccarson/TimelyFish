 /****** Object:  Stored Procedure dbo.ARDoc_DocClass_RefNbr    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_DocClass_RefNbr @parm1 varchar ( 1), @parm2 varchar ( 10) as
    Select * from ARDoc where DocClass = @parm1
                          and refnbr like @parm2 order by RefNbr


