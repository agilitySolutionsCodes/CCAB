/******************************************************************************
**		File: SP_D_CronogramaSafraContaOrdem.SQL
**		Name: SP_D_CronogramaSafraContaOrdem
**		Desc: Exclui o registro da tabela 
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 24.05.2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_CronogramaSafraContaOrdem]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_CronogramaSafraContaOrdem]
END
GO

CREATE PROCEDURE [dbo].[SP_D_CronogramaSafraContaOrdem]
	 @cdCooperativaContaOrdemSEQ						bigint
AS



	--Histórico
	DELETE 
		dbo.CooperativaContaOrdemHistorico
	WHERE
		cdCooperativaContaOrdemSEQ = @cdCooperativaContaOrdemSEQ
		

	--Principal
	DELETE 
		dbo.CooperativaContaOrdem
	WHERE
		cdCooperativaContaOrdemSEQ = @cdCooperativaContaOrdemSEQ




