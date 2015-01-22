set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_tmpPedidoVendaItemCultura.sql
**		Name: SP_I_tmpPedidoVendaItemCultura
**		Desc: Insere um registro na tabela tmpPedidoVendaItemCultura
**
**		Auth: Convergence
**		Date: 09/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_tmpPedidoVendaItemCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_tmpPedidoVendaItemCultura]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_tmpPedidoVendaItemCultura]
	 @tmpPedidoVendaSEQ	BIGINT 
	,@cdProdutoSEQ	BIGINT 
	,@cdCronogramaSafraSEQ	BIGINT 
	,@cdTipoCulturaSEQ BIGINT 
	,@qtPedidoVendaItemCultura	NUMERIC(22,4) 
	,@cdUsuarioUltimaAlteracao	BIGINT 
 
	,@tmpPedidoVendaItemCulturaSEQ	BIGINT	OUTPUT
AS
 
 	-- Verifica se o Registro já existe na base (problema do refresh)
	if not exists ( select	1
					from tmpPedidoVendaItemCultura
					where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
					and   cdProdutoSEQ = @cdProdutoSEQ
					and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					and   cdTipoCulturaSEQ = @cdTipoCulturaSEQ)
	begin

		--inserção
		INSERT INTO tmpPedidoVendaItemCultura
			(
			 tmpPedidoVendaSEQ
			,cdPedidoVendaItemCulturaSEQ
			,cdPedidoVendaSEQ
			,cdProdutoSEQ
			,cdCronogramaSafraSEQ
			,cdTipoCulturaSEQ
			,qtPedidoVendaItemCultura
			,cdIndicadorPedidoVendaItemCultura
			,wkRCPedidoVendaItemCultura
			,wkClientePedidoVendaItemCultura
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao
			)
		VALUES
			(	
			 @tmpPedidoVendaSEQ
			,0 -- cdPedidoVendaItemCulturaSEQ
			,0 -- cdPedidoVendaSEQ
			,@cdProdutoSEQ
			,@cdCronogramaSafraSEQ
			,@cdTipoCulturaSEQ
			,@qtPedidoVendaItemCultura
			,1 -- cdIndicadorPedidoVendaItemCultura (1 - Digitado)
			,null -- wkRCPedidoVendaItemCultura
			,null -- wkClientePedidoVendaItemCultura
			,getdate()
			,@cdUsuarioUltimaAlteracao
			)
	 
 		--retornos
		SELECT
			@tmpPedidoVendaItemCulturaSEQ = SCOPE_IDENTITY()
		SELECT
			@tmpPedidoVendaItemCulturaSEQ as tmpPedidoVendaItemCulturaSEQ
	end
	
	else
	
	begin
	
		-- Seleciona a Chave para o Update
		select	@tmpPedidoVendaItemCulturaSEQ = tmpPedidoVendaItemCulturaSEQ
		from tmpPedidoVendaItemCultura
		where tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		and   cdProdutoSEQ = @cdProdutoSEQ
		and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and   cdTipoCulturaSEQ = @cdTipoCulturaSEQ
	
		--atualização
		UPDATE tmpPedidoVendaItemCultura SET
			 tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
			,cdProdutoSEQ = @cdProdutoSEQ
			,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			,cdTipoCulturaSEQ = @cdTipoCulturaSEQ
			,qtPedidoVendaItemCultura = @qtPedidoVendaItemCultura
			,cdIndicadorPedidoVendaItemCultura = 1 -- cdIndicadorPedidoVendaItemCultura (1-Digitado)
			,dtUltimaAlteracao = getdate()
			,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

		WHERE 
			 tmpPedidoVendaItemCulturaSEQ = @tmpPedidoVendaItemCulturaSEQ

	end

