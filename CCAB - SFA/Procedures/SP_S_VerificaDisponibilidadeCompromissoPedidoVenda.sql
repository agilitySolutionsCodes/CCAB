set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDisponibilidadeCompromissoPedidoVenda.sql
**		Name: SP_S_VerificaDisponibilidadeCompromissoPedidoVenda
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDisponibilidadeCompromissoPedidoVenda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDisponibilidadeCompromissoPedidoVenda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDisponibilidadeCompromissoPedidoVenda]
	  @cdAgenteComercialCooperativaPedidoVenda	BIGINT
	 ,@cdCronogramaSafraSEQ bigint
	 ,@cdIndicadorMoedaPedidoVenda bigint
	 ,@cdPessoaOrigemFaturamento bigint
	 ,@cdTipoProduto bigint
  
AS
 
	--seleção
	SELECT 
		A.cdCompromissoCompraSEQ
	FROM
		CompromissoCompra A (nolock)
	WHERE 
		A.cdAgenteComercialCooperativaCompromissoCompra = @cdAgenteComercialCooperativaPedidoVenda
	and A.cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
	and A.cdIndicadorMoedaCompromissoCompra = @cdIndicadorMoedaPedidoVenda
	and A.cdIndicadorStatusCompromissoCompra = 5 -- Liberado para pedidos
	and A.cdPessoaOrigemFaturamento = @cdPessoaOrigemFaturamento
	and exists (select 1 from compromissocompraitem B,
                              produto C
			    where B.cdCompromissoCompraSEQ = A.cdCompromissoCompraSEQ
				and   B.cdProdutoSEQ = C.cdProdutoSEQ
			    and   C.cdTipoProduto = @cdTipoProduto)
	

	
	
	
	