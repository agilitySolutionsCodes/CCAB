/******************************************************************************
**		File: SP_D_CronogramaSafraPricipioAtivo
**		Name: SP_D_CronogramaSafraPricipioAtivo
**		Desc: Exclui o registro da tabela 
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 06.05.2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_CronogramaSafraPricipioAtivo]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_CronogramaSafraPricipioAtivo]
END
GO

CREATE PROCEDURE [dbo].[SP_D_CronogramaSafraPricipioAtivo]
	 @cdCooperativaPrincipioAtivoSEQ						bigint
AS



	--Histórico
	DELETE 
		dbo.CooperativaPrincipioAtivoHistorico
	WHERE
		cdCooperativaPrincipioAtivoSEQ = @cdCooperativaPrincipioAtivoSEQ
		

	--Principal
	DELETE 
		dbo.CooperativaPrincipioAtivo
	WHERE
		cdCooperativaPrincipioAtivoSEQ = @cdCooperativaPrincipioAtivoSEQ




