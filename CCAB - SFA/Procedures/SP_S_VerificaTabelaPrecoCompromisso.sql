set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaTabelaPrecoCompromisso.sql
**		Name: SP_S_VerificaTabelaPrecoCompromisso
**		Desc: Verifica TabelaPreco para cadastro de Compromisso
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaTabelaPrecoCompromisso]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaTabelaPrecoCompromisso]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaTabelaPrecoCompromisso]
	  @cdAgenteComercialCooperativaCompromissoCompra	BIGINT
	 ,@cdCronogramaSafraSEQ bigint
	 ,@cdIndicadorMoedaCompromissoCompra bigint
  
AS
 
	if @cdIndicadorMoedaCompromissoCompra = 1 -- Real
	begin
		--seleção
		SELECT 
			cdPessoaTabelaPrecoProdutoSEQ
		FROM
			PessoaTabelaPrecoProduto (nolock)
		WHERE 
			cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
		and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and vrRealPessoaTabelaPrecoProduto <> 0
	end
	else -- dolar
	begin
		--seleção
		SELECT 
			cdPessoaTabelaPrecoProdutoSEQ
		FROM
			PessoaTabelaPrecoProduto (nolock)
		WHERE 
			cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
		and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and vrDolarPessoaTabelaPrecoProduto <> 0
	end	
