
CREATE PROCEDURE dbo.PJEmploy_SActive_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(*) FROM PJEMPLOY
                                WHERE Emp_Status = 'A'
                   
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(*) FROM PJEMPLOY 
                                      WHERE (Emp_Status = 'A') AND " 
                                             + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN

                                EXEC ("SELECT TOP " + @Max + " Employee, Emp_Name FROM PJEmploy
                                      WHERE  Emp_Status = 'A' 
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " Employee, Emp_Name FROM PJEmploy
                                      WHERE (Emp_Status = 'A') AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEmploy_SActive_w_PV] TO [MSDSL]
    AS [dbo];

