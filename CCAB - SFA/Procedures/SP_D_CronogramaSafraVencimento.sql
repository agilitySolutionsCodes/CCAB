set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_CronogramaSafraVencimento
**		Name: SP_D_CronogramaSafraVencimento
**		Desc: Exclui o registro da tabela CronogramaSafraVencimento
**
**		Auth: Roberto Chaparro
**		Date: Mar 20 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_CronogramaSafraVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_CronogramaSafraVencimento]
END
GO

CREATE PROCEDURE [dbo].[SP_D_CronogramaSafraVencimento]
	 @cdCronogramaSafraVencimentoSEQ						bigint
AS


	--Histórico
	DELETE 
		dbo.CronogramaSafraVencimentoHistorico
	WHERE
		cdCronogramaSafraVencimentoSEQ						= @cdCronogramaSafraVencimentoSEQ
		

	--Principal
	DELETE 
		dbo.CronogramaSafraVencimento
	WHERE
		cdCronogramaSafraVencimentoSEQ						= @cdCronogramaSafraVencimentoSEQ




