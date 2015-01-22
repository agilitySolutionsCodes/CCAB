set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_PedidoVendaResumoVencimento_TMP
**		Name: SP_G_PedidoVendaResumoVencimento_TMP
**		Desc: Seleciona o resumo de vencimentos do Pedido - tabela TMP
**
**		Auth: Roberto Chaparro
**		Date: Mar 11 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PedidoVendaResumoVencimento_TMP]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PedidoVendaResumoVencimento_TMP]
END
GO

CREATE PROCEDURE [dbo].[SP_G_PedidoVendaResumoVencimento_TMP]
	 @tmpPedidoVendaSEQ		bigint
	 
AS

	BEGIN
	
		-- Declara a variavel de desconto de pontualidade
		DECLARE @pcDescontoPontualidade numeric(8,4)
		SET @pcDescontoPontualidade = 0
	
	
	
		CREATE TABLE #TabelaResumoVencimento
	(
		 [cdTipoCronogramaSafraVencimento]			int
		,[dtCronogramaSafraVencimento]				datetime
		,[VALUEVqtPedidoVendaItem]					varchar(max)
		,[VALUEVqtAbertoPedidoVendaItem]			varchar(max)
		,[VALUEVvrTotalMoedaPedidoVendaItem]		varchar(max)
		,[VALUEVvrTotalMoedaAbertoPedidoVendaItem]	varchar(max)
		,[cdParcela]								int IDENTITY(0,1) NOT NULL
		,[dsVencimento]								varchar(max)
		,[VALUEVpcDescontoPontualidade]                     varchar(max)
		,[cdVencimento]                                     bigint
		
	)	ON [PRIMARY]
	
	
		-- Insere a Linha do Cabeçalho
		INSERT INTO #TabelaResumoVencimento (	dsVencimento,
												VALUEVvrTotalMoedaPedidoVendaItem,
												VALUEVvrTotalMoedaAbertoPedidoVendaItem,
												VALUEVpcDescontoPontualidade
											)
		VALUES (	'Data de Vencimento',
					'Valor Total', 
					'',
					'% Desc. Pontualidade')
					
		-- Insere Detalhe					
		INSERT INTO #TabelaResumoVencimento (	cdTipoCronogramaSafraVencimento,
												dtCronogramaSafraVencimento,
												VALUEVqtPedidoVendaItem,
												VALUEVqtAbertoPedidoVendaItem,
												VALUEVvrTotalMoedaPedidoVendaItem,
												VALUEVvrTotalMoedaAbertoPedidoVendaItem,
												dsVencimento,
												cdVencimento,
												VALUEVpcDescontoPontualidade												
											)
												
		select distinct	b.cdTipoCronogramaSafraVencimento,
						b.dtCronogramaSafraVencimento,
						dbo.FN_FormatarValor(sum(a.qtPedidoVendaItem),1)					as totalqtPedidoVendaItem,
						dbo.FN_FormatarValor(sum(a.qtAbertoPedidoVendaItem),1)				as totalqtAbertoPedidoVendaItem,
						dbo.FN_FormatarValor(sum(a.vrTotalMoedaPedidoVendaItem),2)			as totalvrTotalMoedaPedidoVendaItem,
						dbo.FN_FormatarValor(sum(a.vrTotalMoedaAbertoPedidoVendaItem),2)	as totalvrTotalMoedaAbertoPedidoVendaItem,
						case b.cdTipoCronogramaSafraVencimento 
							when 1 THEN 'A Vista' 
							when 2 THEN right(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'),2) +
										substring(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'), 5, 4) +
										left(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'),4)  
							else        right(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'),2) +
										substring(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'), 5, 4) +
										left(replace(convert(char(10), dtCronogramaSafraVencimento, 126),'-','/'),4)  
						end											as dsVencimento,
						b.cdCronogramaSafraVencimentoSEQ as cdVencimento,
						dbo.FN_FormatarValor(dbo.FN_BuscaPontualidadePedido(@tmpPedidoVendaSEQ, b.cdCronogramaSafraVencimentoSEQ,1),2)	as pcDescontoPontualidade				
		from	tmpPedidoVendaItem a,
				cronogramaSafraVencimento b
		Where	a.cdCronogramaSafraVencimentoSEQ = b.cdCronogramaSafraVencimentoSEQ
		and		a.tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		and     a.qtPedidoVendaItem > 0
		group by a.cdCronogramaSafraVencimentoSEQ, b.cdTipoCronogramaSafraVencimento, b.dtCronogramaSafraVencimento, b.cdCronogramaSafraVencimentoSEQ

	
		select	cdParcela,
				dsVencimento,
				VALUEVvrTotalMoedaPedidoVendaItem,
				VALUEVvrTotalMoedaAbertoPedidoVendaItem,
				VALUEVpcDescontoPontualidade
		from	#TabelaResumoVencimento
		
		drop TABLE #TabelaResumoVencimento
						
	END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO