
CREATE PROCEDURE dbo.AcctSub_DB_Sub_w_PV
        @Acct VarChar ( 10), 
        @SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

	SELECT	@Filter = REPLACE(REPLACE(REPLACE(REPLACE(@Filter, '[Sub]', '[vs_AcctSub].[Sub]'), '[Acct]', '[vs_AcctSub].[Acct]'), '[CpnyID]', '[vs_AcctSub].[CpnyID]'), '[Descr]', '[vs_AcctSub].[Descr]')

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(Sub) FROM vs_AcctSub, vs_Company 
                                WHERE vs_AcctSub.CpnyID = vs_Company.CpnyID AND 
                                      vs_AcctSub.Active = 1 AND 
                                      vs_Company.DatabaseName = DB_NAME() AND 
                                      vs_AcctSub.Acct LIKE @Acct 
                        END
                ELSE
                        BEGIN
                                EXEC('SELECT COUNT(Sub) FROM vs_AcctSub, vs_Company 
                                      WHERE (vs_AcctSub.CpnyID = vs_Company.CpnyID AND 
                                             vs_AcctSub.Active = 1 AND 
                                             vs_Company.DatabaseName = DB_NAME() AND 
                                             vs_AcctSub.Acct LIKE ''' + @Acct + ''') AND ('
                                             + @Filter + ')')
                        END		
           END

        ELSE

          BEGIN

                IF @Filter  = '' 
                        BEGIN
                                EXEC('SELECT TOP ' + @Max + ' vs_AcctSub.Sub AS Sub, vs_AcctSub.Acct AS Acct, vs_AcctSub.CpnyID AS CpnyID, vs_AcctSub.Descr AS Descr FROM vs_AcctSub, vs_Company 
                                      WHERE  vs_AcctSub.CpnyID = vs_Company.CpnyID AND 
                                             vs_AcctSub.Active = 1 AND 
                                             vs_Company.DatabaseName = DB_NAME() AND 
                                             vs_AcctSub.Acct LIKE ''' + @Acct + ''' 
                                      ORDER BY ' + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC('SELECT TOP ' + @Max + ' vs_AcctSub.Sub AS Sub, vs_AcctSub.Acct AS Acct, vs_AcctSub.CpnyID AS CpnyID, vs_AcctSub.Descr AS Descr FROM vs_AcctSub, vs_Company 
                                      WHERE (vs_AcctSub.CpnyID = vs_Company.CpnyID AND 
                                             vs_AcctSub.Active = 1 AND 
                                             vs_Company.DatabaseName = DB_NAME() AND 
                                             vs_AcctSub.Acct LIKE ''' + @Acct + ''') AND ('
                                            + @Filter + ') 
                                      ORDER BY ' + @SortCol )
                        END
          END
