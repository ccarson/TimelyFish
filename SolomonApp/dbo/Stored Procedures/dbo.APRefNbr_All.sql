 /****** Object:  Stored Procedure dbo.APRefNbr_All    Script Date: 4/7/98 12:19:55 PM ******/
Create Proc APRefNbr_All @parm1 varchar ( 10) as
            Select * from APRefNbr where RefNbr like @parm1
                    order by RefNbr DESC


