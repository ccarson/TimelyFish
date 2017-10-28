CREATE PROCEDURE dbo.Employ_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(*) FROM EMPLOYEE
                                
                   
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(*) FROM EMPLOYEE 
                                      WHERE" + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN

                                EXEC ("SELECT TOP " + @Max + " EmpID, Name FROM EMPLOYEE
                                     
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " EmpID, Name FROM EMPLOYEE
                                      WHERE" + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Employ_w_PV] TO [MSDSL]
    AS [dbo];

