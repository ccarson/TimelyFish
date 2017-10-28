 /****** Object:  Stored Procedure dbo.SlSTaxCat_All    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc SlSTaxCat_All @parm1 varchar ( 10) As
     Select * from SlsTaxCat
     where CatId like @parm1 order by CatID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlSTaxCat_All] TO [MSDSL]
    AS [dbo];

