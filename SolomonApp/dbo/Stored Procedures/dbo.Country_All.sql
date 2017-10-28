 /****** Object:  Stored Procedure dbo.Country_All    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc Country_All @parm1 varchar ( 3) as
    Select * from Country where CountryId like @parm1 order by CountryId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Country_All] TO [MSDSL]
    AS [dbo];

