set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CronogramaSafraVencimento.sql
**		Name: TR_CronogramaSafraVencimento
**		Desc: Trigger de históricos da tabela CronogramaSafraVencimento
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CronogramaSafraVencimento]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CronogramaSafraVencimento]
END
GO
 
CREATE TRIGGER [dbo].[TR_CronogramaSafraVencimento] ON dbo.CronogramaSafraVencimento
AFTER INSERT, UPDATE
AS
 
declare
	@cdTipoEventoHistorico		int
 
	IF EXISTS (SELECT * FROM deleted)	-- Alteração
	BEGIN
		select
			@cdTipoEventoHistorico	= 2
	END
	ELSE
	BEGIN
		select
			@cdTipoEventoHistorico	= 1
	END
 
	--inserção
	INSERT INTO CronogramaSafraVencimentoHistorico
	(
		 cdCronogramaSafraVencimentoSEQ
		,cdCronogramaSafraSEQ
		,cdTipoCronogramaSafraVencimento
		,dtCronogramaSafraVencimento
		,pcCorrecaoPrecoTipoCulturaVencimento
		,wkCronogramaSafraVencimento
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,pcDescontoPontualidade
		
		,pcParcela1CronogramaSafraVencimento
		,pcParcela2CronogramaSafraVencimento
		,pcParcela3CronogramaSafraVencimento
		,pcParcela4CronogramaSafraVencimento
		,pcParcela5CronogramaSafraVencimento
		,pcParcela6CronogramaSafraVencimento
		,dtParcela1CronogramaSafraVencimento
		,dtParcela2CronogramaSafraVencimento
		,dtParcela3CronogramaSafraVencimento
		,dtParcela4CronogramaSafraVencimento
		,dtParcela5CronogramaSafraVencimento
		,dtParcela6CronogramaSafraVencimento
		
	)
	SELECT
		 cdCronogramaSafraVencimentoSEQ
		,cdCronogramaSafraSEQ
		,cdTipoCronogramaSafraVencimento
		,dtCronogramaSafraVencimento
		,pcCorrecaoPrecoTipoCulturaVencimento
		,wkCronogramaSafraVencimento
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao
		,pcDescontoPontualidade
		
		,pcParcela1CronogramaSafraVencimento
		,pcParcela2CronogramaSafraVencimento
		,pcParcela3CronogramaSafraVencimento
		,pcParcela4CronogramaSafraVencimento
		,pcParcela5CronogramaSafraVencimento
		,pcParcela6CronogramaSafraVencimento
		,dtParcela1CronogramaSafraVencimento
		,dtParcela2CronogramaSafraVencimento
		,dtParcela3CronogramaSafraVencimento
		,dtParcela4CronogramaSafraVencimento
		,dtParcela5CronogramaSafraVencimento
		,dtParcela6CronogramaSafraVencimento
		

	FROM
		inserted
