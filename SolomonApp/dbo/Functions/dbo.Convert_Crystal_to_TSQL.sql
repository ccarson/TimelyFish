
Create Function Convert_Crystal_to_TSQL (@parm1 varchar(1000)) 
returns Varchar(1000)
as
Begin
  -- This function will take a selection criteria that is formatted using Crystal syntax
  -- and created by the Dynamics SL ROI Screen
  -- and convert it to SQL Server Syntax
  -- Test String --'{gltran.TRandate = #2012-02-29# and {gltran.TranDesc} startswith ''44'' and {gltran.cramt} <> 0 and {gltran.dramt} in [23, 56, 76] AND isnull ( {Gltran.perpost} )  and {gltran.acct} IN ''44?44'' TO ''666*6666'''
  Declare @New_Where varchar(1000)
  Declare @Str_Len int
  Declare @Inquote int
  Declare @i int
  Declare @Single_Char varchar(1)
  Declare @Char_is_processed int
  DECLARE @Words TABLE ( value VARCHAR(500) )    
  Declare @Word varchar(500)
  Declare @TempWord varchar(500)
  Declare @ValueLen int

  Set @Str_Len = Len(@parm1)
  Set @InQuote = 0
  Set @Char_is_processed = 0
  Set @i = 0
  Set @Single_Char = ' '
  set @Char_is_processed = 0
  Set @New_Where = ' '
  While( @i <= @Str_Len )
  Begin

    -- Check to see if we are inside a quoted string
    Set @Single_Char = Substring(@parm1, @i, 1 )

	-- Is is a single quote
    if( @Single_Char = '''' )
	Begin
	    if( @InQuote > 0 )
			Set @InQuote = 0
		else
			Set @InQuote = 1
		Set @New_Where = @New_Where + @Single_Char
		Set @Char_is_processed = 1
	End

	if( @Char_is_processed = 0 )
	Begin
	    -- Not in quoted string
	    if( @InQuote = 0 )
		Begin
		  If @Single_Char = '{'
            Set @New_Where = @New_Where +  ''
          Else If @Single_Char = '}'
            Set @New_Where = @New_Where +   ''
          Else If @Single_Char = ']'
            Set @New_Where = @New_Where +   ')'
          Else If @Single_Char = '#' 
            Set @New_Where = @New_Where +   ''''
          Else If @Single_Char = '['
            Set @New_Where = @New_Where +   '('
          Else
            Set @New_Where = @New_Where +  @Single_Char
		End
		Else -- In quoted string
		Begin
          -- We are inside a quoted string
          If @Single_Char = '*'
            Set @New_Where = @New_Where +   '%'
          Else If @Single_Char = '?'
            Set @New_Where = @New_Where +   '_'
          Else
            Set @New_Where = @New_Where +  @Single_Char
		End
	End
	
    Set @i = @i + 1
    Set @Char_is_processed = 0

  End -- While

  Select @New_Where = REPLACE( @New_Where, '(', ' ( ' )
  Select @New_Where = REPLACE( @New_Where, ')', ' ) ' )

  Set @Str_Len = Len(@New_Where)
  Set @InQuote = 0
  Set @Char_is_processed = 0
  Set @i = 0
  Set @Word = ''
  While( @i <= @Str_Len )
  Begin
      Set @Single_Char = Substring(@New_Where, @i, 1 )
      if @Single_Char = ' '
	  Begin
	      Insert into @Words Values( @Word )
		  Set @Word = ''
	  End
      else
	      Set @Word = @Word + @Single_Char

	  Set @i = @i + 1
  End
  Insert into @Words Values( @Word )
  
  Set @Single_Char = ' '
 
  Declare wordlist Cursor Local SCROLL for ( select * from @Words where value > '' )
  Set @New_Where = ''
  OPEN wordlist
  FETCH NEXT FROM wordlist INTO @Word
  while @@FETCH_STATUS = 0
  begin
      if( Left(@Word, 1 ) = '''' )
	      Set @InQuote = 1

      if( Right(@Word, 1 ) = '''' )
	      Set @InQuote = 0

      if( @InQuote = 0 )
	  Begin
	    if( @word = 'in' )
	    begin
		  Set @Word = 'in'
		  FETCH NEXT FROM wordlist INTO @TempWord
		  FETCH NEXT FROM wordlist INTO @Word
		  if( @Word = 'to' )
		  Begin
		    FETCH NEXT FROM wordlist INTO @Word
		    Set @New_Where = @New_Where + ' between ' + @TempWord + ' and ' + @Word
		  End
		  else
		  Begin
			FETCH RELATIVE -2 FROM wordlist INTO @Word
			Set @New_Where = @New_Where + @Single_Char + @Word
		  End
  	    end
	    else if ( Left(@Word, 6 ) = 'isnull' )
	    Begin
	      -- Crystal ( isnull ( {Account.Descr} ) )
          -- Crystal  where isnull ( {Account.Descr} ) 
		  -- SQL      where Account.Descr is null
		  -- 
		  FETCH NEXT FROM wordlist INTO @Word -- Blow off (
		  FETCH NEXT FROM wordlist INTO @Word -- get the fieldname
  		  Set @New_Where = @New_Where + @Single_Char + @Word + ' is null'
		  FETCH NEXT FROM wordlist INTO @Word -- Blow off )
	    End
	    else if ( @word = '<>' )
	    Begin
		  Set @Word = '!='
		  Set @New_Where = @New_Where + @Single_Char + @Word 
	    End
	    else if ( @Word = 'startswith' )
	    Begin
		  -- You have to put the % on the end of the value
		  Set @Word = 'like '
		  Set @New_Where = @New_Where + @Single_Char + @Word
		  FETCH NEXT FROM wordlist INTO @Word
		  Set @ValueLen = Len(RTRIM(@Word))

		  Set @New_Where = @New_Where + substring( @Word, 1, @ValueLen - 1)
		  Set @New_Where = @New_Where + '%''' 
	    End
	    else
		Begin
  		  Set @New_Where = @New_Where + @Single_Char + @Word
		End
	  End
	  else
	  Begin
	    -- This would be the first word of a string, write it out
	    Set @New_Where = @New_Where + @Single_Char + @Word
	  End
	  
      FETCH NEXT FROM wordlist INTO @Word
  End
  Close wordlist
  Deallocate wordlist

  return( @New_Where )
End
