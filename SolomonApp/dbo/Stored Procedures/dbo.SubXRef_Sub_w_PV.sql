
CREATE procedure dbo.SubXRef_Sub_w_PV
        @CpnyID varchar ( 10) , 
        @SortCol varchar(60), 
        @Filter varchar(255) , 
        @GetCount char(1) , 
        @Max char(5) AS

         IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(vs_SubXRef.Sub) FROM vs_SubXRef, vs_Company WHERE 
                                        vs_Company.CpnyID = @CpnyID AND vs_SubXRef.CpnyID = vs_Company.CpnySub
                                       and  vs_SubXRef.Active = 1
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(vs_SubXRef.Sub) FROM vs_SubXRef, vs_Company  
                                      WHERE ( vs_Company.CpnyID =  '"+@CpnyID+"' AND  vs_SubXRef.CpnyID = vs_Company.CpnySub
                                             and  vs_SubXRef.Active = 1) AND
                                             " + @Filter)
                        END		
            END
        ELSE

            BEGIN

                IF @Filter  = '' 
                   BEGIN
			EXEC("SELECT TOP " + @Max + " vs_SubXRef.Sub, vs_SubXRef.Descr FROM vs_SubXRef, vs_Company 
                              WHERE vs_Company.CpnyID =  '" + @CpnyID + "' AND  vs_SubXRef.CpnyID = vs_Company.CpnySub
                                             and  vs_SubXRef.Active = 1
                              ORDER BY " + @SortCol )
                   END
                ELSE
                   BEGIN
                        EXEC("SELECT TOP " + @Max + " vs_SubXRef.Sub, vs_SubXRef.Descr FROM vs_SubXRef, vs_Company 
                              WHERE (vs_Company.CpnyID = '" + @CpnyID + "' AND  vs_SubXRef.CpnyID = vs_Company.CpnySub
                                             and  vs_SubXRef.Active = 1) AND 
                                     " + @Filter + " 
                              ORDER BY " + @SortCol )
		  END

            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SubXRef_Sub_w_PV] TO [MSDSL]
    AS [dbo];

