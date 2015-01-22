/******************************************************************************
**		File: SP_G_CooperativaCessaoCreditoPedidoExiste.sql
**		Name: SP_G_CooperativaCessaoCreditoPedidoExiste
**		Desc: Verificar se existe Registros
**
**		Auth: Roberto (Convergence)
**		Date: 05/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaCessaoCreditoPedidoExiste]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaCessaoCreditoPedidoExiste]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaCessaoCreditoPedidoExiste]
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
	
 






