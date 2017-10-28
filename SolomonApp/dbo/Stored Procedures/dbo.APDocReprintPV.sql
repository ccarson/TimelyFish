 /****** Object:  Stored Procedure dbo.APDocReprintPV    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDocReprintPV @parm1 varchar(10), @parm2 varchar(10) As
Select * from APCheck
Where BatNbr = @parm1 and
CheckNbr LIKE @parm1
Order by CheckNbr


