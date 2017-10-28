
CREATE PROCEDURE dbo.Terms_Single_ApplyTo_w_PV
        @ApplyTo varchar (1),
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(TermsID) FROM Terms
                                WHERE TermsType = 'S' AND
                                      ApplyTo IN ('"+ @ApplyTo +"','B') 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(TermsID) FROM Terms 
                                      WHERE (TermsType = 'S' AND 
                                            ApplyTo IN ('"+ @ApplyTo +"','B')) AND " 
                                            + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " TermsID, Descr FROM Terms 
                                      WHERE TermsType = 'S' AND 
                                            ApplyTo IN ('"+ @ApplyTo +"','B')
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " TermsID, Descr FROM Terms 
                                      WHERE (TermsType = 'S' AND 
                                            ApplyTo IN ('"+ @ApplyTo +"','B')) AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Terms_Single_ApplyTo_w_PV] TO [MSDSL]
    AS [dbo];

