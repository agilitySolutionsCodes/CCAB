/******************************************************************************
**		File: SP_I_CooperativaPrincipioAtivo.sql
**		Name: SP_I_CooperativaPrincipioAtivo
**		Desc: Insere um registro na tabela CooperativaPrincipioAtivo
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 06/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		13.05.2010		Ronaldo Mega			Inclusão Tipo Produto
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_CooperativaPrincipioAtivo]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_I_CooperativaPrincipioAtivo]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_I_CooperativaPrincipioAtivo]
(
	@cdCooperativaPrincipioAtivoSEQ	bigint			= NULL,	
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL,
	@cdFornecedorPrincipioAtivo		bigint			= NULL,
	@cdIndicadorPrincipioAtivo		int				= NULL,	
	@cdIndicadorProdutoAcabado		int				= NULL,	
	@wkCooperativaPrincipioAtivo	varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao		bigint			= NULL,
	@cdTipoProduto					bigint			= NULL
)	
AS

	BEGIN 
	
		--Verifica se é alteracao
		IF @cdCooperativaPrincipioAtivoSEQ IS NULL
		
			BEGIN
		
				INSERT INTO CooperativaPrincipioAtivo
				(
					cdCronogramaSafraSEQ,				
					cdCooperativaSEQ,
					cdFornecedorPrincipioAtivo,
					--cdIndicadorPrincipioAtivo,	
					--cdIndicadorProdutoAcabado,	
					wkCooperativaPrincipioAtivo,
					dtUltimaAlteracao,	
					cdUsuarioUltimaAlteracao,
					cdTipoProduto
				)
				VALUES
				(			
					@cdCronogramaSafraSEQ,				
					@cdCooperativaSEQ,
					@cdFornecedorPrincipioAtivo,
					--@cdIndicadorPrincipioAtivo,	
					--@cdIndicadorProdutoAcabado,	
					@wkCooperativaPrincipioAtivo,
					GETDATE(),	
					@cdUsuarioUltimaAlteracao,
					@cdTipoProduto
				)	 
				
				SELECT SCOPE_IDENTITY()		
			END
		
		ELSE
		
			UPDATE CooperativaPrincipioAtivo SET 
			
					--cdIndicadorPrincipioAtivo	= @cdIndicadorPrincipioAtivo,
					--cdIndicadorProdutoAcabado	= @cdIndicadorProdutoAcabado,
					wkCooperativaPrincipioAtivo = @wkCooperativaPrincipioAtivo,
					dtUltimaAlteracao			= GETDATE(),
					cdUsuarioUltimaAlteracao	= @cdUsuarioUltimaAlteracao,
					cdTipoProduto				= @cdTipoProduto
					
			WHERE
					cdCooperativaPrincipioAtivoSEQ = @cdCooperativaPrincipioAtivoSEQ
	
	END
	
GO
	
 






