set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_PedidoVendaERP_Microsiga.sql
**		Name: SP_U_PedidoVendaERP_Microsiga
**		Desc: Efetiva a Gravação do Pedido no Microsiga ERP
**
**		Auth: Convergence
**		Date: 20/05/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_PedidoVendaERP_Microsiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_PedidoVendaERP_Microsiga]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_PedidoVendaERP_Microsiga]
	 @cdPedidoVendaERPSEQ				bigint			
	,@cdIndicadorStatus					int
	,@cdPedidoVendaERP					varchar(30)		
	,@cdPedidoVendaSEQ					bigint
	,@nmPessoa							varchar(70)
	,@enEmail							varchar(70)
	,@Erro								varchar(max)

AS

	DECLARE
		@cdSolicitacaoEnvioEmailSEQ		bigint

	UPDATE
		dbo.PedidoVendaERP
	SET
		 cdIndicadorStatusPedidoVendaERP	= @cdIndicadorStatus
		,cdPedidoVendaERP					= @cdPedidoVendaERP
	where
		cdPedidoVendaERPSEQ					= @cdPedidoVendaERPSEQ



	UPDATE
		dbo.PedidoVendaERPItem
	SET
		cdIndicadorStatusPedidoVendaERPItem	= @cdIndicadorStatus
	where
		cdPedidoVendaERPSEQ					= @cdPedidoVendaERPSEQ


	EXEC SP_U_PedidoVenda_Microsiga
		@cdPedidoVendaSEQ = @cdPedidoVendaSEQ


	--Envio email de erro
	if (@Erro <> '')
	begin
		EXEC SP_I_SolicitacaoEnvioEmail_ErroMicroSiga
			 @cdPedidoVendaSEQ				= @cdPedidoVendaSEQ
			,@cdPedidoVendaERPSEQ			= @cdPedidoVendaERPSEQ
			,@nmPessoa						= @nmPessoa
			,@enEmail						= @enEmail
			,@Erro							= @Erro
			,@cdUsuarioUltimaAlteracao		= 0
			
			,@cdSolicitacaoEnvioEmailSEQ	= @cdSolicitacaoEnvioEmailSEQ
	end