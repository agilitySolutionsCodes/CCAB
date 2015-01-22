set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_tmpPedidoVendaItem.sql
**		Name: SP_I_tmpPedidoVendaItem
**		Desc: Insere um registro na tabela tmpPedidoVendaItem
**
**		Auth: Convergence
**		Date: 03/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_tmpPedidoVendaItem]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_tmpPedidoVendaItem]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_tmpPedidoVendaItem]
	@tmpPedidoVendaSEQ	BIGINT = NULL
	,@cdProdutoSEQ	BIGINT = NULL
	,@cdCronogramaSafraSEQ	BIGINT = NULL
	,@cdCronogramaSafraVencimentoSEQ	BIGINT = NULL
	,@qtPedidoVendaItem	NUMERIC(22,4) = NULL
	,@qtAbertoPedidoVendaItem	NUMERIC(22,4) = NULL
	,@cdPedidoVendaERP	VARCHAR(30) = NULL
	,@cdPedidoVendaItemERP	VARCHAR(30) = NULL
	,@cdFilialFaturadoraERP	VARCHAR(30) = NULL
	,@wkRCPedidoVendaItem	VARCHAR(255) = NULL
	,@wkClientePedidoVendaItem	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT = NULL
	
	,@cdAgenteComercialCooperativaCompromissoCompra BIGINT
	,@cdPessoaOrigemFaturamento BIGINT 
	,@cdIndicadorMoedaPedidoVenda BIGINT
 
	,@tmpPedidoVendaItemSEQ	BIGINT	OUTPUT
	
AS

	-- Variaveis para busca do Preço
	declare @vrUnitarioMoedaPedidoVendaItem	NUMERIC(22,4) 
	declare @vrTotalMoedaPedidoVendaItem	NUMERIC(22,4) 
	declare @cdCompromissoCompraSEQ BIGINT
	
	-- Busca o Compromisso de Compra
	SET @cdCompromissoCompraSEQ = 0
	select	@cdCompromissoCompraSEQ = cdCompromissoCompraSEQ
	from	CompromissoCompra
	where	cdAgenteComercialCooperativaCompromissoCompra = @cdAgenteComercialCooperativaCompromissoCompra
	and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
	and     cdPessoaOrigemFaturamento = @cdPessoaOrigemFaturamento
	and     cdIndicadorMoedaCompromissoCompra = @cdIndicadorMoedaPedidoVenda 
	
	IF @cdCompromissoCompraSEQ = 0
	BEGIN
		RAISERROR ('5002 - Erro na Busca do Compromisso de Compra',16,1)
		RETURN	
	END	
	
	-- Busca Valor Unitário do compromisso de Compra
	SET @vrUnitarioMoedaPedidoVendaItem = 0
	select	@vrUnitarioMoedaPedidoVendaItem = vrUnitarioMoedaCompromissoCompraItem
	from	CompromissoCompraItem 
	where	cdCompromissoCompraSEQ = @cdCompromissoCompraSEQ
	and     cdProdutoSEQ = @cdProdutoSEQ
	and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
	and     cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

	IF @vrUnitarioMoedaPedidoVendaItem = 0
	BEGIN
		RAISERROR ('5003 - Erro na Busca do Valor Unitario',16,1)
		RETURN	
	END
	
	SET @vrTotalMoedaPedidoVendaItem = @qtPedidoVendaItem * @vrUnitarioMoedaPedidoVendaItem
	
	-- Verifica se o Registro já existe na base (problema do refresh)
	if not exists ( select	1
					from tmpPedidoVendaItem
					where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
					and   cdProdutoSEQ = @cdProdutoSEQ
					and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					and   cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ)
	begin
 
		--inserção
		INSERT INTO tmpPedidoVendaItem
		(
		 cdPedidoVendaItemSEQ
		,tmpPedidoVendaSEQ
		,cdPedidoVendaSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ
		,qtPedidoVendaItem
		,qtAbertoPedidoVendaItem
		,vrUnitarioMoedaPedidoVendaItem
		,vrTotalMoedaPedidoVendaItem
		,vrTotalMoedaAbertoPedidoVendaItem
		,cdPedidoVendaERP
		,cdPedidoVendaItemERP
		,cdFilialFaturadoraERP
		,cdIndicadorStatusPedidoVendaItem
		,wkRCPedidoVendaItem
		,wkClientePedidoVendaItem
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		)
		VALUES
		(
		0 -- cdPedidoVendaItemSEQ
		,@tmpPedidoVendaSEQ
		,0 -- cdPedidoVendaSEQ
		,@cdProdutoSEQ
		,@cdCronogramaSafraSEQ
		,@cdCronogramaSafraVencimentoSEQ
		,@qtPedidoVendaItem
		,@qtPedidoVendaItem -- @qtAbertoPedidoVendaItem
		,@vrUnitarioMoedaPedidoVendaItem
		,@vrTotalMoedaPedidoVendaItem
		,@vrTotalMoedaPedidoVendaItem -- @vrTotalMoedaAbertoPedidoVendaItem
		,@cdPedidoVendaERP
		,@cdPedidoVendaItemERP
		,@cdFilialFaturadoraERP
		,1 -- @cdIndicadorStatusPedidoVendaItem (1-Digitado)
		,@wkRCPedidoVendaItem
		,@wkClientePedidoVendaItem
		,getdate()
		,@cdUsuarioUltimaAlteracao
		)
 
		--retornos
		SELECT
			@tmpPedidoVendaItemSEQ = SCOPE_IDENTITY()
		SELECT
			@tmpPedidoVendaItemSEQ as tmpPedidoVendaItemSEQ

	end 
	
	else
	
	begin
	
		-- Seleciona a Chave para o Update
		select	@tmpPedidoVendaItemSEQ = tmpPedidoVendaItemSEQ
		from tmpPedidoVendaItem
		where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		and   cdProdutoSEQ = @cdProdutoSEQ
		and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and   cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ	
	
		--atualização
		UPDATE tmpPedidoVendaItem SET
			tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
			,cdProdutoSEQ = @cdProdutoSEQ
			,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			,cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
			,qtPedidoVendaItem = @qtPedidoVendaItem
			,qtAbertoPedidoVendaItem = @qtPedidoVendaItem
			,vrTotalMoedaPedidoVendaItem = @qtPedidoVendaItem * @vrUnitarioMoedaPedidoVendaItem
			,vrTotalMoedaAbertoPedidoVendaItem = @qtPedidoVendaItem * @vrUnitarioMoedaPedidoVendaItem
			,cdIndicadorStatusPedidoVendaItem = 1 -- @cdIndicadorStatusPedidoVendaItem (1 - Digitado)
			,dtUltimaAlteracao = getdate()
			,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
			,vrUnitarioMoedaPedidoVendaItem = @vrUnitarioMoedaPedidoVendaItem

		WHERE 
			 tmpPedidoVendaItemSEQ = @tmpPedidoVendaItemSEQ
	
	end 

