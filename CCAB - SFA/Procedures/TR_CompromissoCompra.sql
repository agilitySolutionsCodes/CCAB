set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CompromissoCompra.sql
**		Name: TR_CompromissoCompra
**		Desc: Trigger de históricos da tabela CompromissoCompra
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CompromissoCompra]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CompromissoCompra]
END
GO
 
CREATE TRIGGER [dbo].[TR_CompromissoCompra] ON dbo.CompromissoCompra
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
	INSERT INTO CompromissoCompraHistorico
	(
		 cdCompromissoCompraSEQ
		,cdAgenteComercialCooperativaCompromissoCompra
		,cdCronogramaSafraSEQ
		,dtEmissaoCompromissoCompra
		,cdIndicadorStatusCompromissoCompra
		,cdIndicadorMoedaCompromissoCompra
		,vrTotalMoedaCompromissoCompra
		,vrTotalAbertoMoedaCompromissoCompra
		,cdAgenteComercialCCABCompromissoCompra
		,cdAgenteComercialRCCompromissoCompra
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,cdPessoaOrigemFaturamento
	)
	SELECT
		 cdCompromissoCompraSEQ
		,cdAgenteComercialCooperativaCompromissoCompra
		,cdCronogramaSafraSEQ
		,dtEmissaoCompromissoCompra
		,cdIndicadorStatusCompromissoCompra
		,cdIndicadorMoedaCompromissoCompra
		,vrTotalMoedaCompromissoCompra
		,vrTotalAbertoMoedaCompromissoCompra
		,cdAgenteComercialCCABCompromissoCompra
		,cdAgenteComercialRCCompromissoCompra
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao
		,cdPessoaOrigemFaturamento

	FROM
		inserted
