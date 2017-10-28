
CREATE VIEW [QQ_ComMessagesRetyped]
AS

SELECT			msg_status [Status], Destination, Sender, Subject, msg_text [Message],
				CASE
					WHEN LTRIM(RTRIM(exe_type1)) = '' THEN
						CASE
							WHEN EXISTS(SELECT * from vs_webappmappings where RichClientScreens like '%' + LTRIM(RTRIM(exe_name1)) + '%') THEN exe_caption1
							WHEN EXISTS(SELECT * from vs_screen where Number = '' + LTRIM(RTRIM(exe_name1)) + '') THEN exe_caption1
							ELSE ''
						END
					WHEN LTRIM(RTRIM(exe_type1)) = 'W' THEN
						CASE
							WHEN LTRIM(RTRIM(exe_name1)) = 'TMWTR00' THEN
								CASE
									WHEN EXISTS(SELECT * from vs_webappmappings where RichClientScreens like '%' + LTRIM(RTRIM(exe_name1)) + '%') THEN exe_caption1
									ELSE ''
								END
							ELSE
								CASE
									WHEN EXISTS(SELECT * from vs_webappmappings where WebAppScreen = '' + LTRIM(RTRIM(exe_name1)) + '') THEN exe_caption1
									ELSE ''
								END
						END
					WHEN LTRIM(RTRIM(exe_type1)) = 'U' THEN exe_caption1
					ELSE ''
			   END [Caption1],
			   CASE
					WHEN LTRIM(RTRIM(exe_type1)) = '' THEN
						CASE
							WHEN EXISTS(SELECT * from vs_webappmappings where RichCLientScreens like '%' + LTRIM(RTRIM(exe_name1)) + '%') THEN 'W'
							ELSE ''
						END
					ELSE exe_type1
			   END [Type1],
			   CASE
					WHEN LTRIM(RTRIM(exe_type2)) = '' THEN
						CASE
							WHEN EXISTS(SELECT * from vs_webappmappings where RichClientScreens like '%' + LTRIM(RTRIM(exe_name2)) + '%') THEN exe_caption2
							WHEN EXISTS(SELECT * from vs_screen where Number = '' + LTRIM(RTRIM(exe_name2)) + '''') THEN exe_caption2
							ELSE ''
						END
					WHEN LTRIM(RTRIM(exe_type2)) = 'W' THEN
						CASE
							WHEN LTRIM(RTRIM(exe_name2)) = 'TMWTR00' THEN
								CASE
									WHEN EXISTS(SELECT * from vs_webappmappings where RichClientScreens like '%' + LTRIM(RTRIM(exe_name2)) + '%') THEN exe_caption2
									ELSE ''
								END
							ELSE
								CASE
									WHEN EXISTS(SELECT * from vs_webappmappings where WebAppScreen = '' + LTRIM(RTRIM(exe_name2)) + '') THEN exe_caption2
									ELSE ''
								END
						END
					WHEN LTRIM(RTRIM(exe_type2)) = 'U' THEN exe_caption2
					ELSE ''
			   END [Caption2],
			   CASE
					WHEN LTRIM(RTRIM(exe_type2)) = '' THEN
						CASE
							WHEN EXISTS(SELECT * from vs_webappmappings where RichCLientScreens like '%' + LTRIM(RTRIM(exe_name2)) + '%') THEN 'W'
							ELSE ''
						END
					ELSE exe_type2
			   END [Type2],
			   CASE
					WHEN LTRIM(RTRIM(exe_type3)) = '' THEN
						CASE
							WHEN EXISTS(SELECT * from vs_webappmappings where RichClientScreens like '%' + LTRIM(RTRIM(exe_name3)) + '%') THEN exe_caption3
							WHEN EXISTS(SELECT * from vs_screen where Number = '' + LTRIM(RTRIM(exe_name3)) + '') THEN exe_caption3
							ELSE ''
						END
					WHEN LTRIM(RTRIM(exe_type3)) = 'W' THEN
						CASE
							WHEN LTRIM(RTRIM(exe_name3)) = 'TMWTR00' THEN
								CASE
									WHEN EXISTS(SELECT * from vs_webappmappings where RichClientScreens like '%' + LTRIM(RTRIM(exe_name3)) + '%') THEN exe_caption3
									ELSE ''
								END
							ELSE
								CASE
									WHEN EXISTS(SELECT * from vs_webappmappings where WebAppScreen = '' + LTRIM(RTRIM(exe_name3)) + '') THEN exe_caption3
									ELSE ''
								END
						END
					WHEN LTRIM(RTRIM(exe_type3)) = 'U' THEN exe_caption3
					ELSE ''
			   END [Caption3],
			   CASE
					WHEN LTRIM(RTRIM(exe_type3)) = '' THEN
						CASE
							WHEN EXISTS(SELECT * FROM vs_webappmappings where RichClientScreens like '%' + LTRIM(RTRIM(exe_name3)) + '%') THEN 'W'
							ELSE ''
						END
					ELSE exe_type3
			   END [Type3],
			   msg_key [MessageKey], msg_suffix [MessageSuffix],
			   crtd_datetime, source_function, lupd_user, lupd_datetime,
			   msg_type [MessageType]
FROM			PJCOMMUN

