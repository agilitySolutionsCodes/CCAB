set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_ProdutoMoeda.sql
**		Name: TR_ProdutoMoeda
**		Desc: Trigger de históricos da tabela ProdutoMoeda
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_ProdutoMoeda]'))
BEGIN
	DROP TRIGGER [dbo].[TR_ProdutoMoeda]
END
GO
 
CREATE TRIGGER [dbo].[TR_ProdutoMoeda] ON dbo.ProdutoMoeda
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
	INSERT INTO ProdutoMoedaHistorico
	(
		 cdProdutoMoedaSEQ
		,cdProdutoSEQ
		,cdIndicadorMoedaProduto
		,cdIndicadorStatusProdutoMoeda
		,wkProdutoMoeda
		,dtOcorrenciaHistorico
		,cdTipoEventoHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdProdutoMoedaSEQ
		,cdProdutoSEQ
		,cdIndicadorMoedaProduto
		,cdIndicadorStatusProdutoMoeda
		,wkProdutoMoeda
		,getdate()
		,@cdTipoEventoHistorico
		,cdUsuarioUltimaAlteracao

	FROM
		inserted
