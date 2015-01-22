set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDisponibilidadePedidoVenda.sql
**		Name: SP_S_VerificaDisponibilidadePedidoVenda
**		Desc: Verifica Disponibilidade para cadastro de Compromisso
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDisponibilidadePedidoVenda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDisponibilidadePedidoVenda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDisponibilidadePedidoVenda]
	  @cdAgenteComercialCooperativaPedidoVenda	BIGINT
	 ,@cdClienteFaturamentoPedidoVenda bigint
	 ,@cdClienteEntregaPedidoVenda bigint
	 ,@cdPessoaOrigemFaturamento bigint
	 ,@cdCronogramaSafraSEQ bigint
	 ,@cdIndicadorMoedaPedidoVenda bigint
	 ,@cdPedidoVendaSEQ bigint
 
AS

	IF @cdPedidoVendaSEQ is NULL or @cdPedidoVendaSEQ = 0
	BEGIN
 
		--seleção
		SELECT 
			cdPedidoVendaSEQ
		FROM
			PedidoVenda (nolock)
		WHERE 
			cdAgenteComercialCooperativaPedidoVenda = @cdAgenteComercialCooperativaPedidoVenda
		and cdClienteFaturamentoPedidoVenda = @cdClienteFaturamentoPedidoVenda
		and cdClienteEntregaPedidoVenda = @cdClienteEntregaPedidoVenda
		and cdPessoaOrigemFaturamento = @cdPessoaOrigemFaturamento
		and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and cdIndicadorMoedaPedidoVenda = @cdIndicadorMoedaPedidoVenda
		
		-- Desconsidera se a Cooperativa for a Coabra (pedido feito pela Marisa em 22/06)
		-- Desconsidera se a Cooperativa for a Copacis (pedido feito pela Marisa em 21/07)
		and cdAgenteComercialCooperativaPedidoVenda not in (select cdPessoaSEQ from Pessoa where cdPessoaERP in ('001400'))
		
		-- Liberação da Consistencia para todos (pedido feito pela Marisa em 21/07)
		and cdAgenteComercialCooperativaPedidoVenda = -1

	END
	ELSE
	BEGIN
	
		--seleção
		SELECT 
			cdPedidoVendaSEQ
		FROM
			PedidoVenda (nolock)
		WHERE 
			cdAgenteComercialCooperativaPedidoVenda = @cdAgenteComercialCooperativaPedidoVenda
		and cdClienteFaturamentoPedidoVenda = @cdClienteFaturamentoPedidoVenda
		and cdClienteEntregaPedidoVenda = @cdClienteEntregaPedidoVenda
		and cdPessoaOrigemFaturamento = @cdPessoaOrigemFaturamento
		and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and cdIndicadorMoedaPedidoVenda = @cdIndicadorMoedaPedidoVenda
		and cdPedidoVendaSEQ <> @cdPedidoVendaSEQ

		-- Liberação da Consistencia para todos (pedido feito pela Marisa em 21/07)
		and cdAgenteComercialCooperativaPedidoVenda = -1
		
	END
	