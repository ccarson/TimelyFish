 /****** Object:  Stored Procedure dbo.Currncy_All    Script Date: 4/7/98 12:43:41 PM ******/
Create Proc Currncy_All @parm1 varchar ( 4) as
    Select * from Currncy where CuryId like @parm1 order by CuryId


