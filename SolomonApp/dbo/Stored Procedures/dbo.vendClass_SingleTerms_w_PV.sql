
CREATE PROCEDURE dbo.vendClass_SingleTerms_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                select count(ClassID) from vendClass, terms
					where termsid = terms and Termstype = 'S'  
                        END
                ELSE
                        BEGIN
                                EXEC("select count(ClassID) from vendClass, terms
					where (termsid = terms and Termstype = 'S') 
					AND " + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                  BEGIN
                        EXEC("SELECT TOP " + @Max + " ClassID, terms, APAcct, APSub, ExpAcct, ExpSub, VC.Descr
					from vendClass VC, terms 
                              where termsid = terms and Termstype = 'S'
                              ORDER BY " + @SortCol )
                   END
                ELSE
                   BEGIN
                        EXEC("SELECT TOP " + @Max + " ClassID, terms, APAcct, APSub, ExpAcct, ExpSub, VC.Descr
					from vendClass VC, terms 
                              WHERE (termsid = terms and Termstype = 'S') AND 
                                     " + @Filter +" 
                              ORDER BY " + @SortCol )
		   END
         END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vendClass_SingleTerms_w_PV] TO [MSDSL]
    AS [dbo];

