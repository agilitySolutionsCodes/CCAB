/******************************************************************************
**		File: SP_G_CooperativaContaOrdemExiste.sql
**		Name: SP_G_CooperativaContaOrdemExiste
**		Desc: Listar Registros
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 24/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaContaOrdemExiste]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaContaOrdemExiste]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaContaOrdemExiste]
(
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL	
)	
AS

	BEGIN 
		
		SELECT
			Count(1)
		FROM
			CooperativaContaOrdem		A	WITH(NOLOCK)			
		WHERE			
			(cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)

			
	
	END
	
GO
	
 






