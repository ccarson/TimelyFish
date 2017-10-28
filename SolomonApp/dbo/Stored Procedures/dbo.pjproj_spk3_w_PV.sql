
CREATE PROCEDURE dbo.pjproj_spk3_w_PV
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(Project) FROM PJPROJ
                                WHERE Status_PA = 'A' AND 
                                       Status_AP = 'A'

                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(Project) FROM PJPROJ 
                                      WHERE (Status_PA = 'A' AND 
                                             Status_AP = 'A') AND " 
                                             + @Filter)
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN

                                EXEC("SELECT TOP " + @Max + " Project, Project_desc, GL_SubAcct FROM PJPROJ
                                      WHERE  Status_PA = 'A' AND 
                                             Status_AP = 'A'
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " Project, Project_desc, GL_SubAcct FROM PJPROJ
                                      WHERE (Status_PA = 'A' AND 
                                             Status_AP = 'A') AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
          END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjproj_spk3_w_PV] TO [MSDSL]
    AS [dbo];

