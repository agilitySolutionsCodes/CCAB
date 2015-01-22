/******************************************************************************
**		File: SP_J_EnviaEmail
**		Name: SP_J_EnviaEmail
**		Desc: Seleciona os registros na tabela SolicitacaoEnvioEmail e efetiva
**            o envio do E-mail
**		Auth: Jorge Cruz
**		Date: Jan 23 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_J_EnviaEmail]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_J_EnviaEmail]
END
GO

CREATE  PROCEDURE SP_J_EnviaEmail
		
AS

	BEGIN
	
		-- Definicao de Variaveis para utilizacao do template do e-mail
		DECLARE @cdSolicitacaoEnvioEmailSEQ bigint
		DECLARE @desEmailSolicitacaoEnvioEmail varchar(70)
		DECLARE @desTextoSolicitacaoEnvioEmail varchar(8000)
		DECLARE @desAssuntoSolicitacaoEnvioEmail varchar(70)
		DECLARE @desEmailCopiaOculta varchar(255)
		
		DECLARE @FETCH_Email int

		DECLARE @NOME_PROFILE varchar(70)
		SET @NOME_PROFILE = 'CCAB - Portal de Negócios'

		-- Definicao do Cursor de Email 
		DECLARE CS_SolicitacaoEnvioEmail CURSOR FOR
		SELECT	cdSolicitacaoEnvioEmailSEQ,
				desEmailSolicitacaoEnvioEmail,
				desTextoSolicitacaoEnvioEmail,
				desAssuntoSolicitacaoEnvioEmail,
				desEmailCopiaOculta
		FROM	SolicitacaoEnvioEmail
		WHERE   cdIndicadorStatusSolicitacaoEnvioEmail in (1,2) -- Pendente e Erro
	
		OPEN CS_SolicitacaoEnvioEmail                                
		FETCH NEXT FROM CS_SolicitacaoEnvioEmail
		INTO 	@cdSolicitacaoEnvioEmailSEQ,
				@desEmailSolicitacaoEnvioEmail,
				@desTextoSolicitacaoEnvioEmail,
                @desAssuntoSolicitacaoEnvioEmail,
                @desEmailCopiaOculta
				
		SET @FETCH_Email = @@FETCH_STATUS
			
		WHILE @FETCH_Email = 0
		BEGIN 
			
			BEGIN TRY

				-- Envia E-mail
				EXEC msdb.dbo.sp_send_dbmail
					@profile_name = @NOME_PROFILE,
					@recipients = @desEmailSolicitacaoEnvioEmail,
					@blind_copy_recipients = @desEmailCopiaOculta,
					@body = @desTExtoSolicitacaoEnvioEmail,
					@subject = @desAssuntoSolicitacaoEnvioEmail,
					@body_format = 'HTML'

			END TRY

			BEGIN CATCH

				declare @nuErro bigint
				declare @desErro nvarchar(4000)
				declare @desStateErro int
				declare @desSeverityErro int

				SELECT @nuErro = error_number(),
					   @desErro = error_message(),
					   @desStateErro = error_state(),
					   @desSeverityErro = error_severity()

				PRINT 'ERRO NO ENVIO DA SOLICITACAO DE EMAIL !!!' 
				CLOSE CS_SolicitacaoEnvioEmail
				DEALLOCATE CS_SolicitacaoEnvioEmail

				Update SolicitacaoEnvioEmail
				Set cdIndicadorStatusSolicitacaoEnvioEmail = 2, -- Erro
				    desErroEnvioSolicitacaoEnvioEmail = @desErro
				Where cdSolicitacaoEnvioEmailSEQ = @cdSolicitacaoEnvioEmailSEQ

				RAISERROR (@desErro,@desSeverityErro,@desStateErro)

				RETURN

			END CATCH

			Update SolicitacaoEnvioEmail
			Set cdIndicadorStatusSolicitacaoEnvioEmail = 3, -- Enviado
				desErroEnvioSolicitacaoEnvioEmail = NULL
			Where cdSolicitacaoEnvioEmailSEQ = @cdSolicitacaoEnvioEmailSEQ
								
			FETCH NEXT FROM CS_SolicitacaoEnvioEmail
			INTO 	@cdSolicitacaoEnvioEmailSEQ,
					@desEmailSolicitacaoEnvioEmail,
					@desTextoSolicitacaoEnvioEmail,
				    @desAssuntoSolicitacaoEnvioEmail,
				    @desEmailCopiaOculta
					
			SET @FETCH_Email = @@FETCH_STATUS
								
		END

		CLOSE CS_SolicitacaoEnvioEmail
		DEALLOCATE CS_SolicitacaoEnvioEmail
			
		RETURN
				
	END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



 