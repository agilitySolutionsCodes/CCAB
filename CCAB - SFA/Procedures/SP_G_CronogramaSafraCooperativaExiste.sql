/******************************************************************************
**		File: SP_G_CronogramaSafraCooperativaExiste.sql
**		Name: SP_G_CronogramaSafraCooperativaExiste
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CronogramaSafraCooperativaExiste]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CronogramaSafraCooperativaExiste]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CronogramaSafraCooperativaExiste]
(
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdPessoaSEQ					bigint			= NULL	
)	
AS

	BEGIN 
		
		SELECT
			Count(1)
		FROM
			CronogramaSafraCooperativa		A	WITH(NOLOCK)			
		WHERE			
			(cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdPessoaSEQ = @cdPessoaSEQ OR @cdPessoaSEQ IS NULL)
			
	
	END
	
GO
	
 






