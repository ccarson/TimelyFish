 CREATE Procedure RQvendeval_dbnav @parm1 Varchar(10), @Parm2 Varchar(60), @parm3 varchar(15) as
Select * from RQvendeval where reqnbr = @parm1
and Name Like @parm2
and VendID like @parm3
Order by reqnbr, Name, Vendid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQvendeval_dbnav] TO [MSDSL]
    AS [dbo];

