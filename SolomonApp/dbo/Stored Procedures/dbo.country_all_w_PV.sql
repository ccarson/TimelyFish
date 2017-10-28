
CREATE PROCEDURE dbo.country_all_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(countryID) FROM country 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(countryID) FROM country 
                                      WHERE " + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                exec("SELECT TOP " + @Max + " countryID, descr from country 
                                      ORDER BY " + @SortCol) 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " countryID, descr 
					from country
                                      WHERE " + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[country_all_w_PV] TO [MSDSL]
    AS [dbo];

