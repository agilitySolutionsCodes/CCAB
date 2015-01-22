set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_tmpPedidoVenda.sql
**		Name: SP_U_tmpPedidoVenda
**		Desc: Altera um registro na tabela tmpPedidoVenda
**
**		Auth: Convergence
**		Date: 22/06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_tmpPedidoVenda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_tmpPedidoVenda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_tmpPedidoVenda]
	 @tmpPedidoVendaSEQ BIGINT = NULL
	,@cdClienteEntregaPedidoVenda	BIGINT = NULL
 
AS


	--atualização
	UPDATE tmpPedidoVenda SET
		cdClienteEntregaPedidoVenda = @cdClienteEntregaPedidoVenda
	WHERE 
		 tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
 
 
