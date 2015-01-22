/******************************************************************************
**		File: SP_G_CooperativaCessaoCreditoExiste.sql
**		Name: SP_G_CooperativaCessaoCreditoExiste
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaCessaoCreditoExiste]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaCessaoCreditoExiste]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaCessaoCreditoExiste]
(
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL	
)	
AS

	BEGIN 
		
		SELECT
			Count(1)
		FROM
			CooperativaCessaoCredito		A	WITH(NOLOCK)			
		WHERE			
			(cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			
	
	END
	
GO
	
 






