set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CompromissoCompraItem.sql
**		Name: TR_CompromissoCompraItem
**		Desc: Trigger de hist�ricos da tabela CompromissoCompraItem
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CompromissoCompraItem]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CompromissoCompraItem]
END
GO
 
CREATE TRIGGER [dbo].[TR_CompromissoCompraItem] ON dbo.CompromissoCompraItem
AFTER INSERT, UPDATE
AS
 
declare
	@cdTipoEventoHistorico		int
 
	IF EXISTS (SELECT * FROM deleted)	-- Altera��o
	BEGIN
		select
			@cdTipoEventoHistorico	= 2
	END
	ELSE
	BEGIN
		select
			@cdTipoEventoHistorico	= 1
	END
 
	--inser��o
	INSERT INTO CompromissoCompraItemHistorico
	(
		 cdCompromissoCompraItemSEQ
		,cdCompromissoCompraSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ
		,qtCompromissoCompraItem
		,qtAbertoCompromissoCompraItem
		,vrUnitarioMoedaCompromissoCompraItem
		,vrTotalMoedaCompromissoCompraItem
		,vrTotalMoedaAbertoCompromissoCompraItem
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,pcDescontoPontualidade
	)
	SELECT
		 cdCompromissoCompraItemSEQ
		,cdCompromissoCompraSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ
		,qtCompromissoCompraItem
		,qtAbertoCompromissoCompraItem
		,vrUnitarioMoedaCompromissoCompraItem
		,vrTotalMoedaCompromissoCompraItem
		,vrTotalMoedaAbertoCompromissoCompraItem
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao
		,pcDescontoPontualidade

	FROM
		inserted
