set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_PedidoVenda_Microsiga.sql
**		Name: SP_U_PedidoVenda_Microsiga
**		Desc: Efetiva a Gravação do Pedido no Microsiga
**
**		Auth: Convergence
**		Date: 20/05/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_PedidoVenda_Microsiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_PedidoVenda_Microsiga]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_PedidoVenda_Microsiga]
	@cdPedidoVendaSEQ					bigint
AS


	DECLARE
		 @QuantidadeErros		int
		,@cdIndicadorStatus		int


	select
		@QuantidadeErros = count(*)
	from
		dbo.PedidoVendaERP
	where
		cdPedidoVendaSEQ					= @cdPedidoVendaSEQ
	and	cdIndicadorStatusPedidoVendaERP		= 7
		

	if @QuantidadeErros > 0
	begin
		select
			@cdIndicadorStatus = 7
	end
	else
	begin
		select
			@cdIndicadorStatus = 6
	end



	UPDATE
		dbo.PedidoVenda
	SET
		cdIndicadorStatusPedidoVenda		= @cdIndicadorStatus
	where
		cdPedidoVendaSEQ					= @cdPedidoVendaSEQ


	UPDATE
		dbo.PedidoVendaItem
	SET
		cdIndicadorStatusPedidoVendaItem	= @cdIndicadorStatus
	where
		cdPedidoVendaSEQ					= @cdPedidoVendaSEQ











