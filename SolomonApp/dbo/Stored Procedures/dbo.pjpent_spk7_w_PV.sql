
CREATE PROCEDURE dbo.pjpent_spk7_w_PV
        @project char(16),
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(pjt_entity) FROM PJPENT
                                WHERE project =   @project AND
                                      Status_PA = 'A' AND
                                      status_lb = 'A'

                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(pjt_entity) FROM PJPENT 
                                      WHERE (project =  '" + @project + "' AND
                                             Status_PA = 'A' AND
                                             status_lb = 'A') AND " 
                                             + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC ("SELECT TOP " + @Max + " pjt_entity, pjt_entity_desc FROM PJPENT
                                      WHERE  project =  '" + @project + "' AND
                                             Status_PA = 'A' AND
                                             status_lb = 'A'
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " pjt_entity, pjt_entity_desc FROM PJPENT
                                      WHERE (project =  '" + @project +"' AND
                                             Status_PA = 'A' AND
                                             status_lb = 'A') AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjpent_spk7_w_PV] TO [MSDSL]
    AS [dbo];

