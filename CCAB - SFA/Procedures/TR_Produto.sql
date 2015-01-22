/******************************************************************************
**		File: TR_Produto.sql
**		Name: TR_Produto
**		Desc: Trigger de históricos da tabela Produto
**
**		Auth: Convergence
**		Date: 30/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		04.05.2010		Ronaldo Mega (RMWA)		Inclusão de Fornecedor e
**												Tipo Prouto							
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_Produto]'))
BEGIN
	DROP TRIGGER [dbo].[TR_Produto]
END
GO
 
CREATE TRIGGER [dbo].[TR_Produto] ON dbo.Produto
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
	INSERT INTO ProdutoHistorico
	(
		 cdProdutoSEQ
		,cdProdutoERP
		,dsProduto
		,dsUnidadeProduto
		,qtEmbalagemProduto
		,qtPesoLiquidoProduto
		,qtPesoBrutoProduto
		,cdIndicadorLiberadoPedidoProduto
		,cdGrupoProdutoSEQ
		,wkProduto
		,cdRecnoMicrosiga
		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		,cdTipoProduto
		,cdFornecedorSEQ
	)
	SELECT
		 cdProdutoSEQ
		,cdProdutoERP
		,dsProduto
		,dsUnidadeProduto
		,qtEmbalagemProduto
		,qtPesoLiquidoProduto
		,qtPesoBrutoProduto
		,cdIndicadorLiberadoPedidoProduto
		,cdGrupoProdutoSEQ
		,wkProduto
		,cdRecnoMicrosiga
		,@cdTipoEventoHistorico
		,getdate()
		,cdUsuarioUltimaAlteracao
		,cdTipoProduto
		,cdFornecedorSEQ

	FROM
		inserted
