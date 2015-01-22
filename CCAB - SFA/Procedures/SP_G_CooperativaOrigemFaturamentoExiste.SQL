/******************************************************************************
**		File: SP_G_CooperativaOrigemFaturamentoExiste.SQL
**		Name: SP_G_CooperativaOrigemFaturamentoExiste
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaOrigemFaturamentoExiste]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaOrigemFaturamentoExiste]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaOrigemFaturamentoExiste]
(
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL,
	@cdOrigemFaturamentoSEQ			bigint			= NULL
)	
AS

	BEGIN 
		
		SELECT
			Count(1)
		FROM
			CooperativaOrigemFaturamento		A	WITH(NOLOCK)			
		WHERE			
			(cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			AND (cdOrigemFaturamentoSEQ = @cdOrigemFaturamentoSEQ OR @cdOrigemFaturamentoSEQ IS NULL)
			
	
	END
	
GO
	
 






