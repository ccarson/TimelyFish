 Create procedure CheckFor_DocTerms @parm1 varchar (10), @parm2 varchar(2) as
       Select *
         From Docterms
           Where Refnbr = @parm1
             and doctype = @parm2


