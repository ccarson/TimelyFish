
 CREATE PROCEDURE Get_RateTable_Rate_PJTIMDET @Project VARCHAR(16), @DocNbr VARCHAR(10), @LineNbr SmallInt, 
                                              @Get_RateTable_Rate FLOAT OUTPUT, @Errglabor_ratetable_id VARCHAR(4) OUTPUT,
                                              @Errlabor_rate_type VARCHAR(2) OUTPUT
                                              
AS           
  SET @Errglabor_ratetable_id = ''
  SET @Errlabor_rate_type = ''
  DECLARE @RateTableID VARCHAR(4)
  DECLARE @RateType VARCHAR(2)
  DECLARE @KEY1 VARCHAR(255) 
  DECLARE @KEY2 VARCHAR(255)
  DECLARE @KEY3 VARCHAR(255)
  DECLARE @LEVEL VARCHAR(2) 
 
  DECLARE @gRate_lookup_method VARCHAR(1)
  DECLARE @gLabor_rate_type VARCHAR(2)
  DECLARE @gCost_Labor_When VARCHAR(1)
  DECLARE @glabor_ratetable_id VARCHAR(4)
  DECLARE @RATE FLOAT
  
  DECLARE @TABLENAME VARCHAR(40)
  DECLARE @FIELDNAME VARCHAR(40)  
  DECLARE @DBSOURCE VARCHAR(40)
  DECLARE @rate_key_value1 VARCHAR(32)   
  DECLARE @rate_key_value2 VARCHAR(32)
  DECLARE @rate_key_value3 VARCHAR(32)
  
  DECLARE @TimDetEmployee VARCHAR(10)
  DECLARE @TimDetGLSubAcct VARCHAR(24)
  DECLARE @TimDetProject VARCHAR(16)
  DECLARE @TimDetTask VARCHAR(32)
  DECLARE @TimDetLABOR_CLASS_CD VARCHAR(4)
  DECLARE @TimDetLD_ID11 VARCHAR(30)
  DECLARE @TimDetWORK_TYPE VARCHAR(2)
  DECLARE @TimDetUSER1 VARCHAR(30)
  DECLARE @TimDetUSER2 VARCHAR(30)
  DECLARE @TimDetDate SmallDateTime
  
 DECLARE @PJProjContract VARCHAR(16)
 DECLARE @PJProjContrat_Type VARCHAR(4)
 DECLARE @PJProjCustomer VARCHAR(15)
 DECLARE @PJProjGL_Subacct VARCHAR(24)
 DECLARE @PJProjPMID01 VARCHAR(30)
 DECLARE @PJProjPMID02 VARCHAR(30)
 DECLARE @PJProjPMID03 VARCHAR(16)
 DECLARE @PJProjPMID04 VARCHAR(16)
 DECLARE @PJProjPMID05 VARCHAR(4)  
 
 DECLARE @PJPentContrat_Type VARCHAR(4)
 DECLARE @PJPentPEID01 VARCHAR(30)
 DECLARE @PJPentPEID02 VARCHAR(30)
 DECLARE @PJPentPEID03 VARCHAR(16)
 DECLARE @PJPentPEID04 VARCHAR(16)
 DECLARE @PJPentPEID05 VARCHAR(4)
 
 DECLARE @PJEmployGL_SubAcct VARCHAR(24)
 DECLARE @PJEmployEMID01 VARCHAR(30)
 DECLARE @PJEmployEMID02 VARCHAR(30)
 DECLARE @PJEmployEMID03 VARCHAR(50)
 DECLARE @PJEmployEMID04 VARCHAR(16)
 DECLARE @PJEmployEMID05 VARCHAR(4)
  
  SELECT @gRate_lookup_method = LEFT(c.control_data,1), @gLabor_rate_type = SUBSTRING(c.control_data,2,2),
         @gCost_Labor_When = SUBSTRING(c.control_data,4,1)  
   FROM PJCONTRL c WITH(NOLOCK)
  WHERE c.control_type = 'TM' AND c.control_code = 'RATE-OPTIONS'  
  
  SELECT @glabor_ratetable_id = rate_table_labor
    FROM PJPROJEX
   WHERE project = @Project
   IF @glabor_ratetable_id IS NULL
      SET @glabor_ratetable_id = ''
      
   IF RTRIM(@glabor_ratetable_id) = '' OR RTRIM(@gLabor_rate_type) = ''
      BEGIN
         SET @Get_RateTable_Rate = 0
         GOTO FINISH
      END
 
   SET @Get_RateTable_Rate = -1
   
   EXEC WSL_ProjectRateKeys_OutPut @Project, @LEVEL OUTPUT, @KEY1 OUTPUT, @KEY2 OUTPUT, @KEY3 OUTPUT, @RateTableID OUTPUT, @RateType OUTPUT
   --SELECT @LEVEL, @KEY1, @KEY2, @KEY3, @RateTableID, @RateType

   IF RTRIM(@LEVEL) = '-1'
      BEGIN
        SET @Get_RateTable_Rate = '-1'
        SET @Errglabor_ratetable_id = @glabor_ratetable_id
        SET @Errlabor_rate_type = @glabor_rate_type
        GOTO FINISH
      END
   
   SELECT @TimDetEmployee = t.employee, @TimDetGLSubAcct = t.gl_subacct, @TimDetProject = t.project, @TimDetTask = t.pjt_entity, @TimDetDate = t.tl_date,
          @TimDetLABOR_CLASS_CD = t.labor_class_cd, @TimDetLD_ID11 = t.tl_id11, @TimDetWORK_TYPE = t.work_type, @TimDetUSER1 = t.user1, @TimDetUSER2 = t.user2
     FROM PJTIMDET t WITH(NOLOCK)
    WHERE t.docnbr = @DocNbr
      AND t.linenbr = @LineNbr
    
    SELECT @PJProjContract = p.contract, @PJProjContrat_Type = p.contract_type, @PJProjCustomer = p.customer, @PJProjGL_Subacct = p.gl_subacct, 
           @PJProjPMID01 = p.pm_id01, @PJProjPMID02 = p.pm_id02, @PJProjPMID03 = p.pm_id03, @PJProjPMID04 = p.pm_id04, @PJProjPMID05 = p.pm_id05
      FROM PJPROJ p WITH(NOLOCK)
     WHERE project = @TimDetProject

    SELECT @PJPentContrat_Type = p.contract_type, @PJPentPEID01 = p.pe_id01, @PJPentPEID02 = p.pe_id02, @PJPentPEID03 = p.pe_id03, 
           @PJPentPEID04 = p.pe_id04, @PJPentPEID05 = p.pe_id05
      FROM PJPENT p WITH(NOLOCK)
     WHERE project = @TimDetProject 
       and pjt_entity = @TimDetTask

    SELECT @PJEmployGL_SubAcct = e.gl_subacct, @PJEmployEMID01 = e.em_id01, @PJEmployEMID02 = e.em_id02, @PJEmployEMID03 = e.em_id03, 
           @PJEmployEMID04 = e.em_id04, @PJEmployEMID05 = e.em_id05
      FROM PJEMPLOY e WITH(NOLOCK)
     WHERE EMPLOYEE = @TimDetEmployee

   SET @rate_key_value1 = ''
   IF RTRIM(LTRIM(@KEY1)) <> ''
   BEGIN
     --GET KEYS   
      SELECT @DBSOURCE = SUBSTRING(@KEY1,48, 40)
      SELECT @TABLENAME = LEFT(@DBSOURCE, CHARINDEX('.',@DBSOURCE) -1), @FIELDNAME = RIGHT(@DBSOURCE, 40 - CHARINDEX('.',@DBSOURCE))
      SET @rate_key_value1 = CASE UPPER(@TABLENAME) WHEN 'PJLABDET' THEN CASE UPPER(@FIELDNAME) WHEN 'EMPLOYEE' THEN @TimDetEmployee
                                                                                                WHEN 'GL_SUBACCT' THEN @TimDetGLSubAcct
                                                                                                WHEN 'LABOR_CLASS_CD' THEN @TimDetLABOR_CLASS_CD
                                                                                                WHEN 'LD_ID01' THEN @TimDetLD_ID11
                                                                                                WHEN 'WORK_TYPE' THEN @TimDetWORK_TYPE
                                                                                                WHEN 'PROJECT' THEN @TimDetProject
                                                                                                WHEN 'PJT_ENTITY' THEN @TimDetTask
                                                                                                WHEN 'USER1' THEN @TimDetUSER1
                                                                                                WHEN 'USER2' THEN @TimDetUSER2
                                                                                                ELSE '' END
                                                    WHEN 'PJPROJ' THEN CASE UPPER(@FIELDNAME) WHEN 'CONTRACT' THEN @PJProjContract
                                                                                              WHEN 'CONTRACT_TYPE' THEN @PJProjContrat_Type
                                                                                              WHEN 'CUSTOMER' THEN @PJProjCustomer
                                                                                              WHEN 'GL_SUBACCT' THEN @PJProjGL_Subacct
                                                                                              WHEN 'PM_ID01' THEN @PJProjPMID01
                                                                                              WHEN 'PM_ID02' THEN @PJProjPMID02
                                                                                              WHEN 'PM_ID03' THEN @PJProjPMID03
                                                                                              WHEN 'PM_ID04' THEN @PJProjPMID04
                                                                                              WHEN 'PM_ID05' THEN @PJProjPMID05
                                                                                              ELSE '' END
                                                    WHEN 'PJPENT' THEN CASE UPPER(@FIELDNAME) WHEN 'CONTRACT_TYPE' THEN @PJPentContrat_Type
                                                                                              WHEN 'PE_ID01' THEN @PJPentPEID01
                                                                                              WHEN 'PE_ID02' THEN @PJPentPEID02
                                                                                              WHEN 'PE_ID03' THEN @PJPentPEID03
                                                                                              WHEN 'PE_ID04' THEN @PJPentPEID04
                                                                                              WHEN 'PE_ID05' THEN @PJPentPEID05 
                                                                                              ELSE '' END                                                
                                                    WHEN 'PJEMPLOY' THEN CASE UPPER(@FIELDNAME) WHEN 'GL_SUBACCT' THEN @PJEmployGL_SubAcct
                                                                                                WHEN 'EM_ID01' THEN @PJEmployEMID01
                                                                                                WHEN 'EM_ID02' THEN @PJEmployEMID02
                                                                                                WHEN 'EM_ID03' THEN @PJEmployEMID03
                                                                                                WHEN 'EM_ID04' THEN @PJEmployEMID04
                                                                                                WHEN 'EM_ID05' THEN @PJEmployEMID05
                                                                                                ELSE '' END
                                                    ELSE '' END
     SET @rate_key_value1 = SUBSTRING(@rate_key_value1, CAST(SUBSTRING(@KEY1,88,2) AS INT), CAST(SUBSTRING(@KEY1,1,2) AS INT))                                                        
  END
  
   SET @rate_key_value2 = ''
   IF RTRIM(LTRIM(@KEY1)) <> ''
   BEGIN  
      SELECT @DBSOURCE = SUBSTRING(@KEY2,48, 40)
      SELECT @TABLENAME = LEFT(@DBSOURCE, CHARINDEX('.',@DBSOURCE) -1), @FIELDNAME = RIGHT(@DBSOURCE, 40 - CHARINDEX('.',@DBSOURCE))
      SET @rate_key_value2 = CASE UPPER(@TABLENAME) WHEN 'PJLABDET' THEN CASE UPPER(@FIELDNAME) WHEN 'EMPLOYEE' THEN @TimDetEmployee
                                                                                                WHEN 'GL_SUBACCT' THEN @TimDetGLSubAcct
                                                                                                WHEN 'LABOR_CLASS_CD' THEN @TimDetLABOR_CLASS_CD
                                                                                                WHEN 'LD_ID01' THEN @TimDetLD_ID11
                                                                                                WHEN 'WORK_TYPE' THEN @TimDetWORK_TYPE
                                                                                                WHEN 'PROJECT' THEN @TimDetProject
                                                                                                WHEN 'PJT_ENTITY' THEN @TimDetTask
                                                                                                WHEN 'USER1' THEN @TimDetUSER1
                                                                                                WHEN 'USER2' THEN @TimDetUSER2
                                                                                                ELSE '' END
                                                    WHEN 'PJPROJ' THEN CASE UPPER(@FIELDNAME) WHEN 'CONTRACT' THEN @PJProjContract
                                                                                              WHEN 'CONTRACT_TYPE' THEN @PJProjContrat_Type
                                                                                              WHEN 'CUSTOMER' THEN @PJProjCustomer
                                                                                              WHEN 'GL_SUBACCT' THEN @PJProjGL_Subacct
                                                                                              WHEN 'PM_ID01' THEN @PJProjPMID01
                                                                                              WHEN 'PM_ID02' THEN @PJProjPMID02
                                                                                              WHEN 'PM_ID03' THEN @PJProjPMID03
                                                                                              WHEN 'PM_ID04' THEN @PJProjPMID04
                                                                                              WHEN 'PM_ID05' THEN @PJProjPMID05
                                                                                              ELSE '' END
                                                    WHEN 'PJPENT' THEN CASE UPPER(@FIELDNAME) WHEN 'CONTRACT_TYPE' THEN @PJPentContrat_Type
                                                                                              WHEN 'PE_ID01' THEN @PJPentPEID01
                                                                                              WHEN 'PE_ID02' THEN @PJPentPEID02
                                                                                              WHEN 'PE_ID03' THEN @PJPentPEID03
                                                                                              WHEN 'PE_ID04' THEN @PJPentPEID04
                                                                                              WHEN 'PE_ID05' THEN @PJPentPEID05 
                                                                                              ELSE '' END                                                
                                                    WHEN 'PJEMPLOY' THEN CASE UPPER(@FIELDNAME) WHEN 'GL_SUBACCT' THEN @PJEmployGL_SubAcct
                                                                                                WHEN 'EM_ID01' THEN @PJEmployEMID01
                                                                                                WHEN 'EM_ID02' THEN @PJEmployEMID02
                                                                                                WHEN 'EM_ID03' THEN @PJEmployEMID03
                                                                                                WHEN 'EM_ID04' THEN @PJEmployEMID04
                                                                                                WHEN 'EM_ID05' THEN @PJEmployEMID05
                                                                                                ELSE '' END
                                                    ELSE '' END  
      SET @rate_key_value2 = SUBSTRING(@rate_key_value2, CAST(SUBSTRING(@KEY2,88,2) AS INT), CAST(SUBSTRING(@KEY2,1,2) AS INT))                                                      
   END
    
   SET @rate_key_value3 = ''
   IF RTRIM(LTRIM(@KEY1)) <> ''
   BEGIN      
      SELECT @DBSOURCE = SUBSTRING(@KEY3,48, 40)
      SELECT @TABLENAME = LEFT(@DBSOURCE, CHARINDEX('.',@DBSOURCE) -1), @FIELDNAME = RIGHT(@DBSOURCE, 40 - CHARINDEX('.',@DBSOURCE))
      SET @rate_key_value3 = CASE UPPER(@TABLENAME) WHEN 'PJLABDET' THEN CASE UPPER(@FIELDNAME) WHEN 'EMPLOYEE' THEN @TimDetEmployee
                                                                                                WHEN 'GL_SUBACCT' THEN @TimDetGLSubAcct
                                                                                                WHEN 'LABOR_CLASS_CD' THEN @TimDetLABOR_CLASS_CD
                                                                                                WHEN 'LD_ID01' THEN @TimDetLD_ID11
                                                                                                WHEN 'WORK_TYPE' THEN @TimDetWORK_TYPE
                                                                                                WHEN 'PROJECT' THEN @TimDetProject
                                                                                                WHEN 'PJT_ENTITY' THEN @TimDetTask
                                                                                                WHEN 'USER1' THEN @TimDetUSER1
                                                                                                WHEN 'USER2' THEN @TimDetUSER2
                                                                                                ELSE '' END
                                                    WHEN 'PJPROJ' THEN CASE UPPER(@FIELDNAME) WHEN 'CONTRACT' THEN @PJProjContract
                                                                                              WHEN 'CONTRACT_TYPE' THEN @PJProjContrat_Type
                                                                                              WHEN 'CUSTOMER' THEN @PJProjCustomer
                                                                                              WHEN 'GL_SUBACCT' THEN @PJProjGL_Subacct
                                                                                              WHEN 'PM_ID01' THEN @PJProjPMID01
                                                                                              WHEN 'PM_ID02' THEN @PJProjPMID02
                                                                                              WHEN 'PM_ID03' THEN @PJProjPMID03
                                                                                              WHEN 'PM_ID04' THEN @PJProjPMID04
                                                                                              WHEN 'PM_ID05' THEN @PJProjPMID05
                                                                                              ELSE '' END
                                                    WHEN 'PJPENT' THEN CASE UPPER(@FIELDNAME) WHEN 'CONTRACT_TYPE' THEN @PJPentContrat_Type
                                                                                              WHEN 'PE_ID01' THEN @PJPentPEID01
                                                                                              WHEN 'PE_ID02' THEN @PJPentPEID02
                                                                                              WHEN 'PE_ID03' THEN @PJPentPEID03
                                                                                              WHEN 'PE_ID04' THEN @PJPentPEID04
                                                                                              WHEN 'PE_ID05' THEN @PJPentPEID05 
                                                                                              ELSE '' END                                                
                                                    WHEN 'PJEMPLOY' THEN CASE UPPER(@FIELDNAME) WHEN 'GL_SUBACCT' THEN @PJEmployGL_SubAcct
                                                                                                WHEN 'EM_ID01' THEN @PJEmployEMID01
                                                                                                WHEN 'EM_ID02' THEN @PJEmployEMID02
                                                                                                WHEN 'EM_ID03' THEN @PJEmployEMID03
                                                                                                WHEN 'EM_ID04' THEN @PJEmployEMID04
                                                                                                WHEN 'EM_ID05' THEN @PJEmployEMID05
                                                                                                ELSE '' END
                                                    ELSE '' END
      SET @rate_key_value3 = SUBSTRING(@rate_key_value3, CAST(SUBSTRING(@KEY3,88,2) AS INT), CAST(SUBSTRING(@KEY3,1,2) AS INT))                                                    
   END                                                    
                                                    
   SELECT  TOP 1 @RATE = rate 
     FROM PJRATE
    WHERE rate_table_id = @RateTableID
      and rate_type_cd = @RateType
      and rate_level = @LEVEL
      and rate_key_value1 = @rate_key_value1
      and rate_key_value2 = @rate_key_value2
      and rate_key_value3 = @rate_key_value3
      and effect_date <= @TimDetDate
     ORDER BY rate_table_id, rate_type_cd, rate_level, rate_key_value1, rate_key_value2, rate_key_value3, effect_date desc
     IF @RATE IS NOT NULL
        SET @Get_RateTable_Rate = @Rate
        
     IF @Get_RateTable_Rate = -1
     BEGIN
        SET @Errglabor_ratetable_id = @glabor_ratetable_id
        SET @Errlabor_rate_type = @glabor_rate_type 
     END   
 GOTO FINISH

  FINISH:
 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Get_RateTable_Rate_PJTIMDET] TO [MSDSL]
    AS [dbo];

