 
 CREATE PROCEDURE Get_UZPeriod @project VarChar(16), @Employee VarChar(10), @Account VARCHAR(16), @PostPeriod VARCHAR(6), 
                               @UZPeriod VARCHAR(6), @TranDate SmallDateTime, @UZPeriodResult VARCHAR(6) OUTPUT                         
AS
  DECLARE @gUZActive INTEGER
  DECLARE @ProjProject VARCHAR(16)
  DECLARE @ProjPMID37 VARCHAR(4)
  DECLARE @PJAcctAcct VARCHAR(16)
  DECLARE @PJAcctID5_sw VARCHAR(1)
  DECLARE @Location Integer
  DECLARE @PJFiscalFiscoNo VARCHAR(6)
  DECLARE @PJFiscalStartDate SmallDateTime
  DECLARE @PJFiscalEndDate SmallDateTime
  DECLARE @UZpost_date SmallDateTime
  DECLARE @Period VARCHAR(6)

  SELECT @gUZActive = CASE LTRIM(RTRIM(c.control_data)) WHEN 'Y' THEN 1 ELSE 0 END
    FROM PJCONTRL c WITH(NOLOCK)
   WHERE c.control_type = 'PA' AND c.control_code = 'UZ-ROLLUP'

  SELECT @UZPeriodResult = ''
  
  IF @gUZActive = 1 AND RTRIM(@Employee) <> ''
    BEGIN
        SELECT @ProjProject = Project, @ProjPMID37 = pm_id37
          FROM PJPROJ WITH(NOLOCK)
         WHERE project = @project 

         IF @ProjProject IS NULL
           BEGIN
              GOTO FINISH
           END
           
         IF RTRIM(@ProjPMID37) <> ''  
           BEGIN
             SELECT @PJAcctAcct = acct, @PJAcctID5_sw = id5_sw 
               FROM PJACCT WITH(NOLOCK) 
              WHERE acct = @Account
              
              If @PJAcctAcct IS NULL
                BEGIN
                   GOTO FINISH
                END  
                
              SELECT @Location = CHARINDEX (RTRIM(@PJAcctID5_sw),'LRAX')              
              IF @Location = 0
                BEGIN
                   GOTO FINISH
                END
              
              IF RTrim(@UZPeriod) = ''
                BEGIN
                   SELECT @PJFiscalFiscoNo = p.fiscalno, @PJFiscalStartDate = p.start_date, @PJFiscalEndDate  = p.end_date
                     FROM pjfiscal p WITH(NOLOCK) 
                    WHERE p.fiscalno = @PostPeriod  
                   IF @PJFiscalFiscoNo IS NULL
                     BEGIN
                        GOTO FINISH
                     END
                   
                   If @PJFiscalStartDate <= @TranDate AND @PJFiscalEndDate >= @TranDate 
                     BEGIN
                        SET @UZpost_date = @TranDate
                     END
                   ELSE
                     BEGIN
                        If @PJFiscalStartDate > @TranDate
                          BEGIN
                             SET @UZpost_date = @PJFiscalStartDate
                          END
                        ELSE
                          BEGIN
                             SET @UZpost_date = @PJFiscalEndDate
                          END
                     END
                   
                   SELECT @Period = r.period 
                     FROM PJUTPER r WITH(NOLOCK)  
                    WHERE r.start_date <= @UZpost_date  
                      AND r.end_date >= @UZpost_date  
                   
                   IF @Period IS NULL
                     BEGIN
                        GOTO FINISH
                     END
                   ELSE
                     BEGIN
                        SELECT @UZPeriodResult = @Period
                     END
                END
              ELSE
                BEGIN
                   SELECT @UZPeriodResult = @UZPeriod
                END  
           END
    END
    
  FINISH:
   

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Get_UZPeriod] TO [MSDSL]
    AS [dbo];

