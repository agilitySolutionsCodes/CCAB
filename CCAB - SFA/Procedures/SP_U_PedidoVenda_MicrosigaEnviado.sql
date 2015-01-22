set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_PedidoVenda_MicrosigaEnviado.sql
**		Name: SP_U_PedidoVenda_MicrosigaEnviado
**		Desc: Marca a Gravação do Pedido no Microsiga (Enviado)
**
**		Auth: Convergence
**		Date: 20/05/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_PedidoVenda_MicrosigaEnviado]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_PedidoVenda_MicrosigaEnviado]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_PedidoVenda_MicrosigaEnviado]

AS


	UPDATE
		dbo.PedidoVenda
	SET
		cdIndicadorStatusPedidoVenda		= 8
	where
		cdIndicadorStatusPedidoVenda		= 5  --Liberado para o Microsiga















