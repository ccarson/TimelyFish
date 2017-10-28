CREATE TABLE [dbo].[PCUploadFormHeader] (
    [Form_Id]        INT          NULL,
    [FormSerialID]   INT          NULL,
    [FarmID]         VARCHAR (3)  NULL,
    [CurrentDate]    VARCHAR (3)  NULL,
    [Verify_Wks]     VARCHAR (30) NULL,
    [TransferStatus] SMALLINT     NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_PCUploadFormHeader1]
    ON [dbo].[PCUploadFormHeader]([Form_Id] ASC, [FormSerialID] ASC, [FarmID] ASC, [TransferStatus] ASC);

