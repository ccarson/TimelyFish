CREATE PROCEDURE dbo.WorkLoc_WrkLocId_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(*) FROM WorkLoc
                                
                   
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(*) FROM WorkLoc
                                      WHERE" + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN

                                EXEC ("SELECT TOP " + @Max + " WrkLocId, Descr FROM WorkLoc
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " WrkLocId, Descr FROM WorkLoc
                                      WHERE" + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WorkLoc_WrkLocId_w_PV] TO [MSDSL]
    AS [dbo];

