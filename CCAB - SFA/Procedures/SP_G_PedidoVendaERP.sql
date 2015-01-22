set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVendaERP.sql
**		Name: SP_G_PedidoVendaERP
**		Desc: Seleciona os registros da tabela Pedido Venda
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaERP]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaERP]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaERP]
	 @cdPedidoVendaSEQ	bigint	

AS

	-- Busca Pedido ERP
	SELECT	A.cdPedidoVendaERPusuario  
			,isnull(A.cdPedidoVendaERP,'') as cdPedidoVendaERP
		    ,B.dtDigitacaoPedidoVenda
		    ,B.dtEmissaoPedidoVenda
		    ,case isnull(A.dtVenctoPedidoVendaERP,'')
				when '' THEN	'A Vista'
				else 			right(replace(convert(char(10), A.dtVenctoPedidoVendaERP, 126),'-','/'),2) +
								substring(replace(convert(char(10), A.dtVenctoPedidoVendaERP, 126),'-','/'), 5, 4) +
								left(replace(convert(char(10), A.dtVenctoPedidoVendaERP, 126),'-','/'),4)  
			end as dtVenctoPedidoVendaERP
		    ,B.cdAgenteComercialCooperativaPedidoVenda
		    ,(ltrim(rtrim(C.nmPessoa)) + '-' + ltrim(rtrim(C.cdPessoaERP))) as dsAgenteComercialCooperativaPedidoVenda
		    ,B.cdPessoaOrigemFaturamento 
		    ,(ltrim(rtrim(D.nmPessoa)) + '-' + ltrim(rtrim(D.cdPessoaERP))) as dsPessoaOrigemFaturamento
		    ,B.cdClienteFaturamentoPedidoVenda
		    ,(ltrim(rtrim(E.nmPessoa)) + '-' + ltrim(rtrim(E.cdPessoaERP))) as dsClienteFaturamentoPedidoVenda
		    ,B.cdClienteEntregaPedidoVenda 
		    ,(ltrim(rtrim(F.nmPessoa)) + '-' + ltrim(rtrim(F.cdPessoaERP))) as dsClienteEntregaPedidoVenda
		    ,B.cdIndicadorMoedaPedidoVenda
		    ,(SELECT
					wkDominioCodigoReferenciado
			  FROM
					dbo.CodigoReferenciado (nolock)
			  WHERE
					vrDominioCodigoReferenciado		= B.cdIndicadorMoedaPedidoVenda
			  AND	dsDominioCodigoReferenciado		= 'DMESPINDICADORMOEDA'
			  )	as dsIndicadorMoedaPedidoVenda
			,dbo.FN_FormatarValor(A.vrTotalMoedaPedidoVendaERP,2) as vrTotalMoedaPedidoVendaERP
			,dbo.FN_FormatarValor(A.vrTotalAbertoMoedaPedidoVendaERP,2) as vrTotalAbertoMoedaPedidoVendaERP
			,(SELECT
					wkDominioCodigoReferenciado
			  FROM
					dbo.CodigoReferenciado (nolock)
			  WHERE
					vrDominioCodigoReferenciado		= A.cdIndicadorStatusPedidoVendaERP
			  AND	dsDominioCodigoReferenciado		= 'DMPESPINDICADORSTATUSPEDIDO'
			  )	as dsIndicadorStatusPedido	
			 ,cdPedidoVendaERPSEQ	
			  
	FROM	 dbo.PedidoVendaERP  A (nolock)		  
			,dbo.PedidoVenda     B (nolock)
			,dbo.Pessoa          C (nolock)
			,dbo.Pessoa          D (nolock)
			,dbo.Pessoa          E (nolock)
			,dbo.Pessoa          F (nolock)
			
	WHERE	A.cdPedidoVendaSEQ = B.cdPedidoVendaSEQ
	AND		B.cdAgenteComercialCooperativaPedidoVenda = C.cdPessoaSEQ
	AND     B.cdPessoaOrigemFaturamento = D.cdPessoaSEQ
	AND     B.cdClienteFaturamentoPedidoVenda = E.cdPessoaSEQ
	AND     B.cdClienteEntregaPedidoVenda = F.cdPessoaSEQ
	AND     A.cdPedidoVendaSEQ = @cdPedidoVendaSEQ
	
	ORDER BY A.dtVenctoPedidoVendaERP
	
SET QUOTED_IDENTIFIER OFF


