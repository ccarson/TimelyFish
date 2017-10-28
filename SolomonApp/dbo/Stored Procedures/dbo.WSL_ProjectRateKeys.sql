
CREATE PROC WSL_ProjectRateKeys @ProjParm AS VARCHAR(16)
AS
    DECLARE @PJR_Parm1 VARCHAR(4)
    DECLARE @PJR_Parm2 VARCHAR(2)
    DECLARE @PJR_Result VARCHAR(10)
    DECLARE @Select_Level VARCHAR(2)
    DECLARE @KeyVal_1 VARCHAR(255)
    DECLARE @KeyVal_2 VARCHAR(255)
    DECLARE @KeyVal_3 VARCHAR(255)
    DECLARE @PJR_Rate_Table TABLE (
      Rate_Level VARCHAR(2),
      Rate_Key1  VARCHAR(255),
      Rate_Key2  VARCHAR(255),
      Rate_Key3  VARCHAR(255))

    SELECT @PJR_Parm1 = rate_table_labor
    FROM   PJPROJEX
    WHERE  project = @ProjParm

    SELECT @PJR_Parm2 = SUBSTRING(control_data, 2,2)
    FROM   PJCONTRL
    WHERE  control_type = 'TM'
           AND control_code = 'RATE-OPTIONS'

    --If Blank, don't continue and return -1
    IF ( Rtrim(@PJR_Parm1) = ''
          OR Rtrim(@PJR_Parm2) = '' )
      BEGIN
          SET @Select_Level = '-1'
          SET @KeyVal_1 = '-1'
          SET @KeyVal_2 = '-1'
          SET @KeyVal_3 = '-1'
          Set @PJR_Parm1 = '-1'
		  Set @PJR_Parm2 = '-1'
		  
          GOTO FINISH
      END

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '1',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l1_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l1_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l1_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '2',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l2_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l2_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l2_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '3',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l3_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l3_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l3_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '4',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l4_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l4_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l4_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '5',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l5_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l5_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l5_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '6',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l6_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l6_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l6_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '7',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l7_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l7_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l7_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '8',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l8_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l8_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l8_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    INSERT @PJR_Rate_Table
           (Rate_Level,
            Rate_Key1,
            Rate_Key2,
            Rate_Key3)
    SELECT '9',
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l9_rate_key1_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l9_rate_key2_cd),
           (SELECT PJCONTRL.control_data
            FROM   PJCONTRL
            WHERE  PJCONTRL.control_type = 'RK'
                   AND PJCONTRL.control_code = PJRTAB.l9_rate_key3_cd)
    FROM   PJRTAB
    WHERE  PJRTAB.rate_table_id = @PJR_Parm1
           AND PJRTAB.rate_type_cd = @PJR_Parm2

    -- Put Max Level and the Keys in variables
    SELECT TOP (1) @Select_Level = Rate_Level,
                   @KeyVal_1 = Rate_Key1,
                   @KeyVal_2 = Rate_Key2,
                   @KeyVal_3 = Rate_Key3
    FROM   @PJR_Rate_Table
    WHERE  Rate_Key1 IS NOT NULL
    ORDER  BY Rate_Level ASC

    FINISH:

    SELECT @Select_Level           'Rate Level',
           Isnull(@KeyVal_1, '-1') 'Rate Key 1',
           Isnull(@KeyVal_2, '-1') 'Rate Key 2',
           Isnull(@KeyVal_3, '-1') 'Rate Key 3',
           @PJR_Parm1              'Rate Table ID',
           @PJR_Parm2              'Rate Type'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectRateKeys] TO [MSDSL]
    AS [dbo];

