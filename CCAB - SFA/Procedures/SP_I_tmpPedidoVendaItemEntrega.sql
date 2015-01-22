set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_tmpPedidoVendaItemEntrega.sql
**		Name: SP_I_tmpPedidoVendaItemEntrega
**		Desc: Insere um registro na tabela tmpPedidoVendaItemEntrega
**
**		Auth: Convergence
**		Date: 09/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_tmpPedidoVendaItemEntrega]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_tmpPedidoVendaItemEntrega]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_tmpPedidoVendaItemEntrega]
	 @tmpPedidoVendaSEQ	BIGINT = NULL
	,@cdProdutoSEQ	BIGINT = NULL
	,@cdCronogramaSafraSEQ	BIGINT = NULL
	,@dtAnoMesPedidoVendaItemEntrega datetime = NULL
	,@qtPedidoVendaItemEntrega	NUMERIC(22,4) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT = NULL
 
	,@tmpPedidoVendaItemEntregaSEQ	BIGINT	OUTPUT
AS
 
 	-- Verifica se o Registro já existe na base (problema do refresh)
	if not exists ( select	1
					from tmpPedidoVendaItemEntrega
					where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
					and   cdProdutoSEQ = @cdProdutoSEQ
					and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					and   dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega)
	begin

		--inserção
		INSERT INTO tmpPedidoVendaItemEntrega
			(
			 tmpPedidoVendaSEQ
			,cdPedidoVendaItemEntregaSEQ
			,cdPedidoVendaSEQ
			,cdProdutoSEQ
			,cdCronogramaSafraSEQ
			,dtAnoMesPedidoVendaItemEntrega
			,qtPedidoVendaItemEntrega
			,cdIndicadorPedidoVendaItemEntrega
			,wkRCPedidoVendaItemEntrega
			,wkClientePedidoVendaItemEntrega
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao
			)
		VALUES
			(	
			 @tmpPedidoVendaSEQ
			,0 -- cdPedidoVendaItemEntregaSEQ
			,0 -- cdPedidoVendaSEQ
			,@cdProdutoSEQ
			,@cdCronogramaSafraSEQ
			,@dtAnoMesPedidoVendaItemEntrega
			,@qtPedidoVendaItemEntrega
			,1 -- cdIndicadorPedidoVendaItemEntrega (1 - Digitado)
			,null -- wkRCPedidoVendaItemEntrega
			,null -- wkClientePedidoVendaItemEntrega
			,getdate()
			,@cdUsuarioUltimaAlteracao
			)
	 
 		--retornos
		SELECT
			@tmpPedidoVendaItemEntregaSEQ = SCOPE_IDENTITY()
		SELECT
			@tmpPedidoVendaItemEntregaSEQ as tmpPedidoVendaItemEntrega
 
	end
	
	else
	
	begin
	
		-- Seleciona a Chave para o Update
		select	@tmpPedidoVendaItemEntregaSEQ = tmpPedidoVendaItemEntregaSEQ
		from tmpPedidoVendaItemEntrega
		where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		and   cdProdutoSEQ = @cdProdutoSEQ
		and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and   dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega
	
		--atualização
		UPDATE tmpPedidoVendaItemEntrega SET
			 tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
			,cdProdutoSEQ = @cdProdutoSEQ
			,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			,dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega
			,qtPedidoVendaItemEntrega = @qtPedidoVendaItemEntrega
			,cdIndicadorPedidoVendaItemEntrega = 1 -- cdIndicadorPedidoVendaItemEntrega (1-Digitado)
			,dtUltimaAlteracao = getdate()
			,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

		WHERE 
			 tmpPedidoVendaItemEntregaSEQ = @tmpPedidoVendaItemEntregaSEQ

	end
 	 
