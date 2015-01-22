/******************************************************************************
**		File: SP_D_CronogramaSafraOrigemFaturamento.SQL
**		Name: SP_D_CronogramaSafraOrigemFaturamento
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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_CronogramaSafraOrigemFaturamento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_CronogramaSafraOrigemFaturamento]
END
GO

CREATE PROCEDURE [dbo].[SP_D_CronogramaSafraOrigemFaturamento]
	 @cdCooperativaOrigemFaturamentoSEQ						bigint
AS



	--Histórico
	DELETE 
		dbo.CooperativaOrigemFaturamentoHistorico
	WHERE
		cdCooperativaOrigemFaturamentoSEQ = @cdCooperativaOrigemFaturamentoSEQ
		

	--Principal
	DELETE 
		dbo.CooperativaOrigemFaturamento
	WHERE
		cdCooperativaOrigemFaturamentoSEQ = @cdCooperativaOrigemFaturamentoSEQ




