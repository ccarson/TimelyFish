CREATE PROCEDURE dbo.EarnType_Id1_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(*) FROM EarnType
                                Where ETType <> 'G'
                   
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(*) FROM EarnType
                                      WHERE (ETType <> 'G')
					   AND " + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN

                                EXEC ("SELECT TOP " + @Max + " Id, Descr FROM EarnType
                                         WHERE (ETType <> 'G')
                              		ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " Id, Descr FROM EarnType
                                     WHERE (ETType <> 'G') AND
                                     " + @Filter +" 
                              		ORDER BY " + @SortCol )

                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnType_Id1_w_PV] TO [MSDSL]
    AS [dbo];

