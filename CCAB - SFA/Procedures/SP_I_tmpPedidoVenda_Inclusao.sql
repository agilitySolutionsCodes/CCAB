set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_tmpPedidoVenda_Inclusao.sql
**		Name: SP_I_tmpPedidoVenda_Inclusao
**		Desc: Insere um registro na tabela tmpPedidoVenda - somente para Inclusões
**
**		Auth: Convergence
**		Date: 02/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_tmpPedidoVenda_Inclusao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_tmpPedidoVenda_Inclusao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_tmpPedidoVenda_Inclusao]
	 @cdAgenteComercialCooperativaPedidoVenda	BIGINT
	,@cdCronogramaSafraSEQ						BIGINT 
	,@cdClienteFaturamentoPedidoVenda			BIGINT
	,@cdClienteEntregaPedidoVenda				BIGINT
	,@cdUsuarioUltimaAlteracao					BIGINT
	,@cdPessoaOrigemFaturamento					BIGINT
	,@cdIndicadorMoedaPedidoVenda				BIGINT
	,@cdTipoPedidoVenda							INT
	,@cdTipoProduto								INT
 
	,@tmpPedidoVendaSEQ							BIGINT	OUTPUT
AS
 
	declare
		 @cdCompromissoCompraSEQ			bigint
		,@cdAgenteComercialCCABPedidoVenda	bigint
		,@cdAgenteComercialRCPedidoVenda	bigint

	select
		@cdCompromissoCompraSEQ = 0


	--Obtenho os dados do Compromisso de Compra, dados estes, necessários para a Inclusão do Pedido Temporário
	select
		 @cdCompromissoCompraSEQ			= cdCompromissoCompraSEQ
		,@cdAgenteComercialCCABPedidoVenda	= cdAgenteComercialCCABCompromissoCompra
		,@cdAgenteComercialRCPedidoVenda	= cdAgenteComercialRCCompromissoCompra
	from
		dbo.CompromissoCompra
	where
		cdAgenteComercialCooperativaCompromissoCompra	= @cdAgenteComercialCooperativaPedidoVenda
	and cdCronogramaSafraSEQ							= @cdCronogramaSafraSEQ
	and cdIndicadorMoedaCompromissoCompra				= @cdIndicadorMoedaPedidoVenda
	and cdPessoaOrigemFaturamento						= @cdPessoaOrigemFaturamento

	if @cdCompromissoCompraSEQ > 0
	begin
	
		-- Busca RC direto do Cadastro de Clientes
		select	
			 @cdAgenteComercialRCPedidoVenda = cdAgenteComercialRCPessoa
		from
			dbo.Pessoa
		where
			cdPessoaSEQ = @cdClienteFaturamentoPedidoVenda
			
		--inserção
		INSERT INTO tmpPedidoVenda
			(
			 cdPedidoVendaSEQ
			,cdAgenteComercialCooperativaPedidoVenda
			,cdCompromissoCompraSEQ
			,cdCronogramaSafraSEQ
			,dtDigitacaoPedidoVenda
			,dtEmissaoPedidoVenda
			,cdTipoPedidoVenda
			,cdModalidadePedidoVenda
			,cdIndicadorStatusPedidoVenda
			,cdIndicadorMoedaPedidoVenda
			,vrTotalMoedaPedidoVenda
			,vrTotalAbertoMoedaPedidoVenda
			,cdAgenteComercialCCABPedidoVenda
			,cdAgenteComercialRCPedidoVenda
			,cdClienteFaturamentoPedidoVenda
			,cdClienteEntregaPedidoVenda
			,cdPedidoVendaERP
			,cdFilialFaturadoraERP
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao
			,cdPessoaOrigemFaturamento
			,cdTipoProduto
			)
		VALUES
			(
			 0
			,@cdAgenteComercialCooperativaPedidoVenda
			,@cdCompromissoCompraSEQ
			,@cdCronogramaSafraSEQ
			,getdate() --dtDigitacaoPedidoVenda
			,null --dtEmissaoPedidoVenda
			,@cdTipoPedidoVenda --cdTipoPedidoVenda
			,1 --cdModalidadePedidoVenda
			,1 --cdIndicadorStatusPedidoVenda
			,@cdIndicadorMoedaPedidoVenda
			,0 --vrTotalMoedaPedidoVenda
			,0 --vrTotalAbertoMoedaPedidoVenda
			,@cdAgenteComercialCCABPedidoVenda
			,@cdAgenteComercialRCPedidoVenda
			,@cdClienteFaturamentoPedidoVenda
			,@cdClienteEntregaPedidoVenda
			,null --@cdPedidoVendaERP
			,null --@cdFilialFaturadoraERP
			,getdate()
			,@cdUsuarioUltimaAlteracao
			,@cdPessoaOrigemFaturamento
			,@cdTipoProduto
			)

		--retornos
		SELECT
			@tmpPedidoVendaSEQ = SCOPE_IDENTITY()


		SELECT
			@tmpPedidoVendaSEQ as cdPedidoVendaSEQ


	end
	else
	begin
	
		RAISERROR ('5002 - Compromisso de Compra não encontrado',16,1)
		RETURN			
		
	end

