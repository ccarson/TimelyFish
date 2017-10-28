
CREATE PROCEDURE dbo.PJCode_SPK0_w_PV
        @code_type varchar(4),
	@SortCol varchar(60), 
        @Filter varchar(255), 
        @GetCount char(1), 
        @Max char(5) AS

        IF @GetCount = 'Y'
           BEGIN
                IF @Filter  = ''
                        BEGIN

                                SELECT COUNT(*) FROM PJCode
                   		Where code_type = @code_type
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT COUNT(*) FROM PJCode 
                                      WHERE code_type = '"+ @code_type +"' AND " 
					+ @Filter)
                        END		
           END

        ELSE

           BEGIN

                IF @Filter  = '' 
                        BEGIN

                                EXEC ("SELECT TOP " + @Max + " Code_Value, Code_Value_Desc, Code_Type 
                                       FROM  PJCode
                                       WHERE Code_Type = '"+ @code_type+"' 
                                       ORDER BY " + @SortCol )
                        END
                ELSE
                        BEGIN
                                EXEC("SELECT TOP " + @Max + " Code_Value, Code_Value_Desc, Code_Type 
                                      FROM  PJCode 
                                      WHERE code_type = '"+ @code_type +"' AND " 
                                            + @Filter + " 
                                      ORDER BY " + @SortCol )
                        END
           END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCode_SPK0_w_PV] TO [MSDSL]
    AS [dbo];

