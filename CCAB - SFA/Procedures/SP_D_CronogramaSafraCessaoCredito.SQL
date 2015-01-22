/******************************************************************************
**		File: SP_D_CronogramaSafraCessaoCredito.SQL
**		Name: SP_D_CronogramaSafraCessaoCredito
**		Desc: Exclui o registro da tabela 
**
**		Auth: Roberto (Convergence)
**		Date: 05.05.2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_CronogramaSafraCessaoCredito]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_CronogramaSafraCessaoCredito]
END
GO

CREATE PROCEDURE [dbo].[SP_D_CronogramaSafraCessaoCredito]
	 @cdCooperativaCessaoCreditoSEQ						bigint
AS



	--Histórico
	DELETE 
		dbo.CooperativaCessaoCreditoHistorico
	WHERE
		cdCooperativaCessaoCreditoSEQ = @cdCooperativaCessaoCreditoSEQ
		

	--Principal
	DELETE 
		dbo.CooperativaCessaoCredito
	WHERE
		cdCooperativaCessaoCreditoSEQ = @cdCooperativaCessaoCreditoSEQ




