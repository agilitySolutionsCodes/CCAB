/******************************************************************************
**		File: SP_G_CooperativaCessaoCreditoExisteCarga.sql
**		Name: SP_G_CooperativaCessaoCreditoExisteCarga
**		Desc: Listar Registros
**
**		Auth: Roberto (Convergence)
**		Date: 05/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaCessaoCreditoExisteCarga]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaCessaoCreditoExisteCarga]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaCessaoCreditoExisteCarga]
(
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL,	
	@Tipo							int				= NULL
)	
AS

	BEGIN 


		IF (@Tipo = 3)
		BEGIN
			SELECT
				Count(1)
			FROM
				CooperativaCessaoCredito		A	WITH(NOLOCK)			
			WHERE			
				(cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
				AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			AND cdIndicadorCessaoCredito = 1
			AND	cdIndicadorPedidoNormal	 = 1		
		END
		ELSE
		BEGIN
			SELECT
				Count(1)
			FROM
				CooperativaCessaoCredito		A	WITH(NOLOCK)			
			WHERE			
				(cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
				AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			AND cdIndicadorCessaoCredito = 1
			AND	cdIndicadorPedidoContaOrdem	 = 1		
		
		END


		
	
	END
	
GO
	
 






