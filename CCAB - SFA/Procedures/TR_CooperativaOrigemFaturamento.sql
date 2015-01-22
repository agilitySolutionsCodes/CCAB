set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CooperativaOrigemFaturamento.sql
**		Name: TR_CooperativaOrigemFaturamento
**		Desc: Trigger de históricos da tabela CooperativaOrigemFaturamento
**
**		Auth: Convergence
**		Date: 05/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CooperativaOrigemFaturamento]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CooperativaOrigemFaturamento]
END
GO
 
CREATE TRIGGER [dbo].[TR_CooperativaOrigemFaturamento] ON CooperativaOrigemFaturamento
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
	INSERT INTO CooperativaOrigemFaturamentoHistorico
	(
		 cdCooperativaOrigemFaturamentoSEQ
		,cdCronogramaSafraSEQ
		,cdCooperativaSEQ
		,cdOrigemFaturamentoSEQ
		,cdIndicadorSituacaoOrigemFaturamento
		,wkCooperativaOrigemFaturamento

		,cdTipoEventoHistorico	
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	)
	SELECT
	
		 cdCooperativaOrigemFaturamentoSEQ
		,cdCronogramaSafraSEQ
		,cdCooperativaSEQ
		,cdOrigemFaturamentoSEQ
		,cdIndicadorSituacaoOrigemFaturamento
		,wkCooperativaOrigemFaturamento
		
		,@cdTipoEventoHistorico
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		inserted

