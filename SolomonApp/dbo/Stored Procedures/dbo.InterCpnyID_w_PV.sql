CREATE PROCEDURE dbo.InterCpnyID_w_PV
	@FromCompany varchar ( 10), 
        @ToCompany varchar(10), 
        @Screen varchar ( 5), 
        @Module varchar ( 2), 
        @parm5 varchar ( 10), 
        @parm6 varchar ( 10), 
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1) , 
        @Max int AS


        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                       BEGIN

                                SELECT COUNT(DISTINCT(tocompany)) 
                                FROM vs_InterCompany, vs_Company 
				WHERE FromCompany = @FromCompany AND 
                                      CpnyID = ToCompany AND 
                                      ToCompany LIKE @ToCompany AND 
                                      (screen = @Screen OR 
                                          (Screen = 'ALL  ' AND 
                                           Module = @Module) OR 
                                          (screen = 'ALL  ' AND 
                                           Module = '**') OR 
                                          (Module = 'ZZ' AND 
                                           @parm5 LIKE @parm6)) 

                       END
               ELSE
                       BEGIN
                                EXEC("Select count(distinct(tocompany)) 
                                      FROM vs_InterCompany, vs_Company 
				WHERE ( FromCompany = '"+@FromCompany+"' AND 
                                        CpnyID = ToCompany AND 
                                        ToCompany LIKE '"+@ToCompany+"' AND 
                                        (screen = '"+@Screen+"' OR 
                                          (Screen = 'ALL  ' AND 
                                           Module = '"+@Module+"')OR
                                          (screen = 'ALL  ' AND 
                                           Module = '**') OR 
                                          (Module = 'ZZ' AND 
                                           '"+@parm5+"' LIKE '"+@parm6+"')) ) AND 
                                         " + @Filter)
                       END		
              END
          ELSE

              BEGIN
                    set rowcount @Max
                IF @Filter  = '' 
                       BEGIN

                               EXEC("SELECT DISTINCT(tocompany), cpnyname
                                     FROM vs_InterCompany, vs_Company 
                                     WHERE FromCompany = '"+@FromCompany+"' AND 
                                           CpnyID = ToCompany AND 
                                           ToCompany LIKE '"+@ToCompany+"' AND 
                                           (screen = '"+@Screen+"' OR
                                            (Screen = 'ALL  ' AND 
                                             Module = '"+@Module+"') OR 
                                            (screen = 'ALL  ' AND 
                                             Module = '**') OR 
                                            (Module = 'ZZ' AND 
                                             "+@parm5+" LIKE '"+@parm6+"')) 
                                     ORDER BY " + @SortCol ) 

                       END
		
                ELSE
                       BEGIN
                               EXEC("SELECT DISTINCT(tocompany), cpnyname
                                     FROM vs_InterCompany, vs_Company 
                                     WHERE (FromCompany = '"+@FromCompany+"' AND 
                                            CpnyID = ToCompany AND 
                                            ToCompany LIKE '"+@ToCompany+"' AND 
                                            (screen = '"+@Screen+"' OR 
                                            (Screen = 'ALL  ' AND 
                                             Module = '"+@Module+"') OR 
                                            (screen = 'ALL  ' AND 
                                             Module = '**') OR 
                                            (Module = 'ZZ' AND 
                                             "+@parm5+" LIKE '"+@parm6+"')) ) AND 
                                            (" +@Filter+ ") 
                                     ORDER BY " + @SortCol ) 
		       END
                END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[InterCpnyID_w_PV] TO [MSDSL]
    AS [dbo];

