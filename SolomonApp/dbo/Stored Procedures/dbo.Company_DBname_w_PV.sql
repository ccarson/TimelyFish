
CREATE PROCEDURE dbo.Company_DBname_w_PV
        @DBName varchar ( 50), 

        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(CpnyID) FROM vs_Company
                                WHERE DatabaseName = @DBName 
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(CpnyID) FROM vs_Company
                                WHERE (DatabaseName = '"+ @DBName+"' AND " 
                                       + @Filter)
                        END		
           END
        ELSE
          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " CpnyID, Active, CpnyName, CpnyCOA, CpnySub FROM vs_Company
                                      WHERE DatabaseName = '"+ @DBName+"' 
                                      ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " CpnyID, Active, CpnyName, CpnyCOA, CpnySub FROM vs_Company 
                                      WHERE (DatabaseName = '"+ @DBName+"' AND 
                                            "+ @Filter + "
                                      ORDER BY " + @SortCol )
                        END
          END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Company_DBname_w_PV] TO [MSDSL]
    AS [dbo];

