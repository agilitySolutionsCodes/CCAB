/******************************************************************************
**		File: SP_I_CooperativaContaOrdem.sql
**		Name: SP_I_CooperativaContaOrdem
**		Desc: Insere um registro na tabela 
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 24/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_CooperativaContaOrdem]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_I_CooperativaContaOrdem]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_I_CooperativaContaOrdem]
(
	@cdCooperativaContaOrdemSEQ		bigint			= NULL,	
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL,
	@cdIndicadorContaOrdem			bigint			= NULL,	
	@wkCooperativaContaOrdem		varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao		bigint			= NULL	
)	
AS

	BEGIN 
	
		--Verifica se é alteracao
		IF @cdCooperativaContaOrdemSEQ IS NULL
		
			BEGIN
		
				INSERT INTO CooperativaContaOrdem
				(
					cdCronogramaSafraSEQ,				
					cdCooperativaSEQ,
					wkCooperativaContaOrdem,
					dtUltimaAlteracao,	
					cdUsuarioUltimaAlteracao,
					cdIndicadorContaOrdem
				)
				VALUES
				(			
					@cdCronogramaSafraSEQ,				
					@cdCooperativaSEQ,
					@wkCooperativaContaOrdem,
					GETDATE(),	
					@cdUsuarioUltimaAlteracao,
					@cdIndicadorContaOrdem
				)	 
				
				SELECT SCOPE_IDENTITY()		
			END
		
		ELSE
		
			UPDATE CooperativaContaOrdem SET 
			
					wkCooperativaContaOrdem		= @wkCooperativaContaOrdem,
					dtUltimaAlteracao			= GETDATE(),
					cdUsuarioUltimaAlteracao	= @cdUsuarioUltimaAlteracao,
					cdIndicadorContaOrdem		= @cdIndicadorContaOrdem
					
			WHERE
					cdCooperativaContaOrdemSEQ = @cdCooperativaContaOrdemSEQ
	
	END
	
GO
	
 






