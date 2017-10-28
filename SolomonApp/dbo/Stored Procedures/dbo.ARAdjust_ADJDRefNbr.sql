 /****** Object:  Stored Procedure dbo.ARAdjust_ADJDRefNbr    Script Date: 4/7/98 12:49:19 PM ******/
Create proc ARAdjust_ADJDRefNbr @parm1 varchar ( 10) As
Select * from Aradjust
where Aradjust.AdjBatNbr like @parm1


