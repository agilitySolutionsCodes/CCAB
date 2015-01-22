set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaParametroPrecoProduto.sql
**		Name: SP_S_VerificaParametroPrecoProduto
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaParametroPrecoProduto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaParametroPrecoProduto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaParametroPrecoProduto]
	  @cdAgenteComercialCooperativaCompromissoCompra bigint 
	 ,@cdCronogramaSafraSEQ bigint
  
AS

    -- Solicitação Marisa em 21/07 (Cooaleste somente com 4 itens)
    IF @cdAgenteComercialCooperativaCompromissoCompra not in (select cdPessoaSEQ from pessoa where cdPessoaERP = '000700')
    BEGIN
 
		-- Solicitação Marisa (COABRA não deverá ter o numero minimo de produtos para consultar preço)
		IF @cdAgenteComercialCooperativaCompromissoCompra not in (select cdPessoaSEQ from pessoa where cdPessoaERP = '001400')
		BEGIN
	 
			select	top 1 qtProdutoPrecoCronogramaSafra
			from CronogramaSafra
			where	cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			
		END
		ELSE
		BEGIN
		
			select 1 as qtProdutoPrecoCronogramaSafra 
			
		END
	END
	ELSE
	BEGIN
	
		select 1 as qtProdutoPrecoCronogramaSafra
		
	END	
	
	
	
	

	