/******************************************************************************
**		File: SP_I_CooperativaCessaoCredito.sql
**		Name: SP_I_CooperativaCessaoCredito
**		Desc: Insere um registro na tabela 
**
**		Auth: Roberto (Convergence)
**		Date: 05/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_CooperativaCessaoCredito]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_I_CooperativaCessaoCredito]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_I_CooperativaCessaoCredito]
(
	@cdCooperativaCessaoCreditoSEQ		bigint			= NULL,	
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL,
	@cdIndicadorCessaoCredito			bigint			= NULL,	
	@cdIndicadorPedidoNormal			bigint			= NULL,	
	@cdIndicadorPedidoContaOrdem			bigint			= NULL,	
	@wkCooperativaCessaoCredito		varchar(255)	= NULL,	
	@cdUsuarioUltimaAlteracao		bigint			= NULL	
)	
AS

	BEGIN 
	
		--Verifica se é alteracao
		IF @cdCooperativaCessaoCreditoSEQ IS NULL
		
			BEGIN
		
				INSERT INTO CooperativaCessaoCredito
				(
					cdCronogramaSafraSEQ,				
					cdCooperativaSEQ,
					wkCooperativaCessaoCredito,
					dtUltimaAlteracao,	
					cdUsuarioUltimaAlteracao,
					cdIndicadorCessaoCredito,
					cdIndicadorPedidoNormal,	
					cdIndicadorPedidoContaOrdem
					
				)
				VALUES
				(			
					@cdCronogramaSafraSEQ,				
					@cdCooperativaSEQ,
					@wkCooperativaCessaoCredito,
					GETDATE(),	
					@cdUsuarioUltimaAlteracao,
					@cdIndicadorCessaoCredito,
					@cdIndicadorPedidoNormal,	
					@cdIndicadorPedidoContaOrdem
					
				)	 
				
				SELECT SCOPE_IDENTITY()		
			END
		
		ELSE
		
			UPDATE CooperativaCessaoCredito SET 
			
					wkCooperativaCessaoCredito		= @wkCooperativaCessaoCredito,
					dtUltimaAlteracao			= GETDATE(),
					cdUsuarioUltimaAlteracao	= @cdUsuarioUltimaAlteracao,
					cdIndicadorCessaoCredito		= @cdIndicadorCessaoCredito,
					
					cdIndicadorPedidoNormal		=	@cdIndicadorPedidoNormal,	
					cdIndicadorPedidoContaOrdem	=	@cdIndicadorPedidoContaOrdem
					
					
			WHERE
					cdCooperativaCessaoCreditoSEQ = @cdCooperativaCessaoCreditoSEQ
	
	END
	
GO
	
 






