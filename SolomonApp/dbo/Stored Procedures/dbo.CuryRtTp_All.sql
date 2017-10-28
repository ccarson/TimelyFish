 /****** Object:  Stored Procedure dbo.CuryRtTp_All    Script Date: 4/7/98 12:43:41 PM ******/
Create Proc CuryRtTp_All @parm1 varchar ( 6) as
    Select * from CuryRtTp where RateTypeId like @parm1 order by RateTypeId


