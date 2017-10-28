 Create Proc EDSetup_InboundOptions As
Select InDataDir, InTranslatorVerify From EDSetup



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSetup_InboundOptions] TO [MSDSL]
    AS [dbo];

