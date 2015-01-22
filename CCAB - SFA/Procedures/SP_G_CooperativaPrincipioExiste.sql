/******************************************************************************
**		File: SP_G_CooperativaPrincipioExiste.sql
**		Name: SP_G_CooperativaPrincipioExiste
**		Desc: Listar Registros
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 06/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		13.05.2010		Ronaldo Mega			Inclusão Tipo Produto
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CooperativaPrincipioExiste]'))

	BEGIN
		DROP PROCEDURE [dbo].[SP_G_CooperativaPrincipioExiste]
	END

GO
 
CREATE PROCEDURE [dbo].[SP_G_CooperativaPrincipioExiste]
(
	@cdCronogramaSafraSEQ			bigint			= NULL,	
	@cdCooperativaSEQ				bigint			= NULL	
)	
AS

	BEGIN 
		
		SELECT
			Count(1)
		FROM
			CooperativaPrincipioAtivo		A	WITH(NOLOCK)			
		WHERE			
			(cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ OR @cdCronogramaSafraSEQ IS NULL)
			AND (cdCooperativaSEQ = @cdCooperativaSEQ OR @cdCooperativaSEQ IS NULL)
			
	
	END
	
GO
	
 






