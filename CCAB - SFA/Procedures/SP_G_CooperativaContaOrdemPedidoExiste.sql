/******************************************************************************
**		File: SP_G_CooperativaContaOrdemPedidoExiste.sql
**		Name: SP_G_CooperativaContaOrdemPedidoExiste
**		Desc: Verificar se existe Registros
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 25/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaContaOrdemPedidoExiste]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaContaOrdemPedidoExiste]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaContaOrdemPedidoExiste]
(
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL	
)	
AS

	BEGIN 
		
		SELECT
			Count(1)
		FROM
			PedidoVenda		A	WITH(NOLOCK)			
		WHERE			
			(cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdAgenteComercialCooperativaPedidoVenda = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			
	
	END
	
GO
	
 






