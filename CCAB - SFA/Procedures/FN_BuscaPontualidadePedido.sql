set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: FN_BuscaPontualidadePedido.sql
**		Name: FN_BuscaPontualidadePedido
**		Desc: Retornar o valor da pontualidade para um determinado Pedido/vencimento
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FN_BuscaPontualidadePedido]'))
BEGIN
	DROP FUNCTION [dbo].[FN_BuscaPontualidadePedido]
END
GO

CREATE FUNCTION [dbo].[FN_BuscaPontualidadePedido] 
(
	@cdPedidoVendaSEQ			bigint,
	@cdCronogramaSafraVencimentoSEQ bigint,
	@TipoBusca						int
)

returns		numeric(8,4)

AS
BEGIN

	DECLARE @cdCooperativaSEQ bigint
	DECLARE @cdCronogramaSafraSEQ bigint
	DECLARE @pcDescontoPontualidade numeric(8,4)
	
	-- Busca o Agente e Safra do Pedido conforme o tipo de busca (1 - TmpPedidoVenda, 2 - PedidoVenda)
	SET @cdCooperativaSEQ = 0
	SET @cdCronogramaSafraSEQ = 0
	
	if @TipoBusca = 1
	BEGIN
	
		select @cdCooperativaSEQ = cdAgenteComercialCooperativaPedidoVenda, 
			   @cdCronogramaSafraSEQ = cdCronogramaSafraSEQ 
		from tmpPedidoVenda
		Where tmpPedidoVendaSEQ = @cdPedidoVendaSEQ
		
	END
	ELSE
	BEGIN
	
		select @cdCooperativaSEQ = cdAgenteComercialCooperativaPedidoVenda, 
			   @cdCronogramaSafraSEQ = cdCronogramaSafraSEQ 
		from PedidoVenda	
		Where cdPedidoVendaSEQ = @cdPedidoVendaSEQ

	END	
		
	-- Busca o percentual de Pontualidade
	if exists (	select 1 from CronogramaSafraVencimentoCooperativa
				where cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
				and   cdCooperativaSEQ = @cdCooperativaSEQ)
	BEGIN
	
		SET @pcDescontoPontualidade = 0
		select @pcDescontoPontualidade = pcDescontoPontualidade 
		from CronogramaSafraVencimentoCooperativa
		where cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
		and   cdCooperativaSEQ = @cdCooperativaSEQ	
		
	END
	ELSE
	BEGIN
		
		SET @pcDescontoPontualidade = 0
		select @pcDescontoPontualidade = pcDescontoPontualidade 
		from CronogramaSafraVencimento
		where cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and   cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

	END

	RETURN @pcDescontoPontualidade

END

	
