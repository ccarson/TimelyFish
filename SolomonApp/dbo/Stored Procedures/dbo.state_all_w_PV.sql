
CREATE PROCEDURE dbo.state_all_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(stateprovid) FROM state 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(stateprovid) FROM state 
                                      WHERE " + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                exec("SELECT TOP " + @Max + " stateprovid, descr from state 
                                      ORDER BY " + @SortCol) 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " stateprovid, descr  
                                      from state 
                                      WHERE " + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[state_all_w_PV] TO [MSDSL]
    AS [dbo];

