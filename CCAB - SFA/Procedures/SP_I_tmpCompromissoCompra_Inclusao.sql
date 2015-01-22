set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_tmpCompromissoCompra_Inclusao.sql
**		Name: SP_I_tmpCompromissoCompra_Inclusao
**		Desc: Insere um registro na tabela tmpCompromissoCompra - somente para Inclusões
**
**		Auth: Convergence
**		Date: 08/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_tmpCompromissoCompra_Inclusao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_tmpCompromissoCompra_Inclusao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_tmpCompromissoCompra_Inclusao]
	 @cdAgenteComercialCooperativaCompromissoCompra		bigint
	,@cdCronogramaSafraSEQ								bigint
	,@cdIndicadorMoedaCompromissoCompra					int
	,@cdUsuarioUltimaAlteracao							bigint
	,@cdPessoaOrigemFaturamento							bigint

	,@tmpCompromissoCompraSEQ							BIGINT	OUTPUT
AS
 
	declare
		 @cdAgenteComercialCCABCompromissoCompra		bigint
		,@cdAgenteComercialRCCompromissoCompra			bigint


	--Obtenho os códigos dos agêntes
	select
		 @cdAgenteComercialCCABCompromissoCompra	= cdAgenteComercialCCABPessoa
		,@cdAgenteComercialRCCompromissoCompra		= cdAgenteComercialRCPessoa
	from
		dbo.Pessoa
	where
		cdPessoaSEQ									= @cdAgenteComercialCooperativaCompromissoCompra

	INSERT INTO dbo.tmpCompromissoCompra
		(cdCompromissoCompraSEQ 
		,cdAgenteComercialCooperativaCompromissoCompra 
		,cdCronogramaSafraSEQ 
		,dtEmissaoCompromissoCompra 
		,cdIndicadorStatusCompromissoCompra 
		,cdIndicadorMoedaCompromissoCompra 
		,vrTotalMoedaCompromissoCompra 
		,vrTotalAbertoMoedaCompromissoCompra 
		,cdAgenteComercialCCABCompromissoCompra 
		,cdAgenteComercialRCCompromissoCompra
		,cdPessoaOrigemFaturamento 
		,dtUltimaAlteracao 
		,cdUsuarioUltimaAlteracao)
	VALUES
		(0 -- cdCompromissoCompraSEQ
		,@cdAgenteComercialCooperativaCompromissoCompra
		,@cdCronogramaSafraSEQ
		,getdate() -- dtEmissaoCompromissoCompra
		,3
		,@cdIndicadorMoedaCompromissoCompra
		,0 -- vrTotalMoedaCompromissoCompra
		,0 -- vrTotalAbertoMoedaCompromissoCompra
		,@cdAgenteComercialCCABCompromissoCompra
		,@cdAgenteComercialRCCompromissoCompra
		,@cdPessoaOrigemFaturamento
		,getdate()
		,@cdUsuarioUltimaAlteracao)

		--retornos
		SELECT
			@tmpCompromissoCompraSEQ = SCOPE_IDENTITY()

		SELECT
			@tmpCompromissoCompraSEQ as tmpCompromissoCompraSEQ

