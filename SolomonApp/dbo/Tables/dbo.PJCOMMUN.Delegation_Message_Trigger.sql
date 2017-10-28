
CREATE TRIGGER Delegation_Message_Trigger
ON PJCOMMUN
FOR INSERT, UPDATE
AS 
      SET NOCOUNT ON

      Declare @delegate_from varchar(50),
            @delegate_to varchar(10),
            @orig_msg_key varchar(48),
            @msg_key varchar(48),
            @document_type varchar(6),
            @sender varchar(50),
            @tmtcs_type varchar(100)

      -- Select the values from the INSERTED table
      select @delegate_from = destination, 
               @document_type = msg_type,
               @orig_msg_key = msg_key,
               @sender = sender,
               @tmtcs_type = exe_name1
      from INSERTED
      
      SET @delegate_to = ''
      
      -- Note: all start and end dates are dates only and contain no time element
      if @document_type = 'TMCARD' OR (@document_type = 'TMSTAT' and @tmtcs_type = 'TMTRA00') --timecard and timecard status alert
            BEGIN
                  SELECT @delegate_to = (select delegate_to_ID from pjdeleg 
                                                      where Doc_type = 'PTIM' and Employee = @delegate_from
                                                        and date_start <= CONVERT(date, getdate()) and date_end >= CONVERT(date, getdate())
                                                      and delegate_flag = 'Y')
            END
      ELSE
      if @document_type = 'TEREPT' --project expense
            BEGIN
                  SELECT @delegate_to = (select delegate_to_ID from pjdeleg 
                                                      where Doc_type = 'PEXP' 
                                                        and Employee = @delegate_from
                                                        and delegate_to_ID != @sender --No pjcommun msg if delegating to self
                                                        and date_start <= CONVERT(date, getdate()) and date_end >= CONVERT(date, getdate())
                                                      and delegate_flag = 'Y')
            END
      ELSE
      if @document_type = 'WTRREQ' -- T&E Line Items
            BEGIN
                  SELECT @delegate_to = (select delegate_to_ID from pjdeleg 
                                                      where Doc_type = 'PITM' and Employee = @delegate_from
                                                        and date_start <= CONVERT(date, getdate()) and date_end >= CONVERT(date, getdate())
                                                      and delegate_flag = 'Y')
            END
      ELSE
      if @document_type = 'BUDREV' or  @document_type = 'BUDFWD'-- Budget
            BEGIN
                  SELECT @delegate_to = (select delegate_to_ID from pjdeleg 
                                                      where Doc_type = 'PBUD' and Employee = @delegate_from
                                                        and date_start <= CONVERT(date, getdate()) and date_end >= CONVERT(date, getdate())
                                                      and delegate_flag = 'Y')
            END
      ELSE
      if @document_type = 'BIINV'-- project invoices
            BEGIN
                  SELECT @delegate_to = (select delegate_to_ID from pjdeleg 
                                                      where Doc_type = 'PINV' and Employee = @delegate_from
                                                        and date_start <= CONVERT(date, getdate()) and date_end >= CONVERT(date, getdate())
                                                      and delegate_flag = 'Y')
            END

      If @delegate_to != '' 
        BEGIN
            SET @msg_key = @delegate_to
            if @document_type = 'BIINV'-- project invoices
                  BEGIN
                        SELECT @msg_key = RTRIM(@msg_key) + RIGHT(RTRIM(@orig_msg_key),10) --msg key for invoices contains draft_num so we need to concat dest+draft#.
                  END
            If Not Exists (   Select destination From PJCOMMUN Where msg_type = @document_type and msg_key = @msg_key and msg_suffix = '00')
                  BEGIN
                        Insert Into PJCOMMUN 
                           ([crtd_datetime]
                           ,[crtd_prog]
                           ,[crtd_user]
                           ,[destination]
                           ,[destination_type]
                           ,[email_address]
                           ,[exe_caption1]
                           ,[exe_caption2]
                           ,[exe_caption3]
                           ,[exe_name1]
                           ,[exe_name2]
                           ,[exe_name3]
                           ,[exe_parm1]
                           ,[exe_parm2]
                           ,[exe_parm3]
                           ,[exe_type1]
                           ,[exe_type2]
                           ,[exe_type3]
                           ,[lupd_datetime]
                           ,[lupd_prog]
                           ,[lupd_user]
                           ,[mail_flag]
                           ,[msg_key]
                           ,[msg_status]
                           ,[msg_suffix]
                           ,[msg_text]
                           ,[msg_type]
                           ,[sender]
                           ,[source_function]
                           ,[subject])
                        Select
                              Inserted.Crtd_DateTime 'Crtd_Datetime', 
                              Inserted.Crtd_Prog 'Crtd_Prog', 
                              Inserted.Crtd_User 'Crtd_User', 
                              @delegate_to 'destination',
                              Inserted.destination_type 'destination_type',
                              Inserted.email_address 'email_address',
                              Inserted.exe_caption1 'exe_caption1',
                              Inserted.exe_caption2 'exe_caption2',
                              Inserted.exe_caption3 'exe_caption3',
                              Inserted.exe_name1 'exe_name1',
                              Inserted.exe_name2 'exe_name2',
                              Inserted.exe_name3 'exe_name3',
                              Inserted.exe_parm1      'exe_parm1',
                              Inserted.exe_parm2      'exe_parm2',
                              Inserted.exe_parm3      'exe_parm3',
                              Inserted.exe_type1      'exe_type1',
                              Inserted.exe_type2      'exe_type2',
                              Inserted.exe_type3      'exe_type3',
                              Inserted.lupd_datetime 'lupd_datetime',
                              Inserted.lupd_prog      'lupd_prog',
                              Inserted.lupd_user      'lupd_user',
                              Inserted.mail_flag      'mail_flag',
                              @msg_key 'msg_key',
                              Inserted.msg_status     'msg_status',
                              '00'  'msg_suffix', 
                              Inserted.msg_text 'msg_text',
                              @document_type 'msg_type',
                              Inserted.sender   'sender',
                              Inserted.source_function 'source_function',
                              Inserted.subject
                        From Inserted
                  END
            ELSE
                  update pjcommun set lupd_datetime = getdate() Where msg_type = @document_type and msg_key = @msg_key and msg_suffix = '00'
            END
