CREATE TABLE [dbo].[InsuranceProgram] (
    [InsuranceProgramID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [InsuranceProgramDescription] VARCHAR (15) NOT NULL,
    CONSTRAINT [PK_InsuranceProgram] PRIMARY KEY CLUSTERED ([InsuranceProgramID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER trInsInsuranceProgram ON [dbo].[InsuranceProgram] 
FOR INSERT
AS
Insert into [$(SolomonApp)].dbo.cftInsuranceProgram
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
InsuranceProgramID,
Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 

getdate(),'','SYSADMIN',
isnull(InsuranceProgramDescription,''),
InsuranceProgramID=replicate('0',2-len(rtrim(convert(char(2),InsuranceProgramID)))) + rtrim(convert(char(2),InsuranceProgramID)),
getdate(),'','SYSADMIN'
	FROM Inserted

GO
CREATE TRIGGER trDelInsuranceProgram ON [dbo].[InsuranceProgram] 
FOR DELETE
AS
Delete [$(SolomonApp)].dbo.cftInsuranceProgram
FROM [$(SolomonApp)].dbo.cftInsuranceProgram a
JOIN Deleted d on 
a.InsuranceProgramID=replicate('0',2-len(rtrim(convert(char(2),d.InsuranceProgramID))))
	 + rtrim(convert(char(2),d.InsuranceProgramID))

GO
CREATE TRIGGER trUpdInsuranceProgram ON [dbo].[InsuranceProgram] 
FOR UPDATE
AS
BEGIN TRAN
Delete [$(SolomonApp)].dbo.cftInsuranceProgram
FROM [$(SolomonApp)].dbo.cftInsuranceProgram a
JOIN Deleted d on 
a.InsuranceProgramID=replicate('0',2-len(rtrim(convert(char(2),d.InsuranceProgramID))))
	 + rtrim(convert(char(2),d.InsuranceProgramID))

Insert into [$(SolomonApp)].dbo.cftInsuranceProgram
(Crtd_DateTime,Crtd_Prog,Crtd_User,
Description,
InsuranceProgramID,
Lupd_DateTime,Lupd_Prog,Lupd_User
)
Select 

getdate(),'','SYSADMIN',
isnull(InsuranceProgramDescription,''),
InsuranceProgramID=replicate('0',2-len(rtrim(convert(char(2),InsuranceProgramID)))) + rtrim(convert(char(2),InsuranceProgramID)),
getdate(),'','SYSADMIN'
	FROM Inserted


COMMIT TRAN

