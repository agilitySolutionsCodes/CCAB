set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_CompromissoCompraLiberacao.sql
**		Name: SP_G_CompromissoCompraLiberacao
**		Desc: Seleciona os registros da tabela Pedido Venda
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CompromissoCompraLiberacao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CompromissoCompraLiberacao]
END
GO

CREATE PROCEDURE [dbo].[SP_G_CompromissoCompraLiberacao]
	 @cdAgenteComercialCooperativaCompromissoCompra		bigint  = null
	,@cdCronogramaSafraSEQ								bigint  
	,@cdIndicadorMoedaCompromissoCompra					int		= null
	,@cdCompromissoCompraSEQ							bigint	= null
	,@cdPessoaOrigemFaturamento							bigint  = null

AS

	DECLARE
		@lsComando		varchar(max)

	select
		 @lsComando = 'SELECT ' 

		,@lsComando = @lsComando + '	  		 A.cdCompromissoCompraSEQ'
		,@lsComando = @lsComando + '	  		,A.dtEmissaoCompromissoCompra'
		,@lsComando = @lsComando + '            ,A.cdAgenteComercialCooperativaCompromissoCompra'
		,@lsComando = @lsComando + '            ,(ltrim(rtrim(B.nmPessoa))) + ' + '''-''' + ' + ltrim(rtrim(B.cdPessoaERP)) as dsAgenteComercialCooperativaCompromissoCompra'
		,@lscomando = @lscomando + '            ,A.cdPessoaOrigemFaturamento'
		,@lsComando = @lsComando + '            ,(ltrim(rtrim(D.nmPessoa))) + ' + '''-''' + ' + ltrim(rtrim(D.cdPessoaERP)) as dsPessoaOrigemFaturamento'
		,@lsComando = @lsComando + '            ,A.cdCronogramaSafraSEQ'
		,@lsComando = @lsComando + '            ,C.dsCronogramaSafra'
		,@lsComando = @lsComando + '	  		,A.cdIndicadorMoedaCompromissoCompra'
		,@lsComando = @lsComando + '	  		,('
		,@lsComando = @lsComando + '	  			SELECT'
		,@lsComando = @lsComando + '	  				wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	  			FROM'
		,@lsComando = @lsComando + '	  				dbo.CodigoReferenciado			(nolock)'
		,@lsComando = @lsComando + '	  			WHERE'
		,@lsComando = @lsComando + '	  				vrDominioCodigoReferenciado		= A.cdIndicadorMoedaCompromissoCompra'
		,@lsComando = @lsComando + '	  			AND	dsDominioCodigoReferenciado		= ''DMESPINDICADORMOEDA'' '
		,@lsComando = @lsComando + '	  		)	as dsIndicadorMoedaCompromissoCompra'
		,@lsComando = @lsComando + '	  		,dbo.FN_FormatarValor(A.vrTotalMoedaCompromissoCompra,2) as vrTotalMoedaCompromissoCompra'
		,@lsComando = @lsComando + '	  		,A.cdIndicadorStatusCompromissoCompra'
		,@lsComando = @lsComando + '	  		,('		
		,@lsComando = @lsComando + '	  			SELECT'
		,@lsComando = @lsComando + '	  				wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	  			FROM'
		,@lsComando = @lsComando + '	  				dbo.CodigoReferenciado			(nolock)'
		,@lsComando = @lsComando + '	  			WHERE'
		,@lsComando = @lsComando + '	  				vrDominioCodigoReferenciado		= A.cdIndicadorStatusCompromissoCompra'
		,@lsComando = @lsComando + '	  			AND	dsDominioCodigoReferenciado		= ''DMESPINDICADORSTATUSCOMPROMISSOCOMPRA'' '
		,@lsComando = @lsComando + '	  		)	as dsIndicadorStatusCompromissoCompra'

		,@lsComando = @lsComando + '	  	FROM'
		,@lsComando = @lsComando + '	  		dbo.CompromissoCompra	A (nolock)'
		,@lsComando = @lsComando + '           ,dbo.Pessoa B (nolock) '
		,@lsComando = @lsComando + '           ,dbo.CronogramaSafra C (nolock) '
		,@lscomando = @lsComando + '           ,dbo.Pessoa D (nolock) '
		
		,@lsComando = @lsComando + '		WHERE '
		,@lsComando = @lsComando + '		 	A.cdCompromissoCompraSEQ = A.cdCompromissoCompraSEQ ' 
		,@lsComando = @lsComando + '        and A.cdAgenteComercialCooperativaCompromissoCompra = B.cdPessoaSEQ '
		,@lsComando = @lsComando + '        and A.cdCronogramaSafraSEQ = C.cdCronogramaSafraSEQ '
		,@lscomando = @lsComando + '        and A.cdPessoaOrigemFaturamento = D.cdPessoaSEQ '
		
		
		-- Filtra somente os Compromissos que podem ser Liberados
		,@lsComando = @lsComando + '        and A.cdIndicadorStatusCompromissoCompra in (3,6) ' -- Somente Compromisso Aceito pela CCAB e/ou Bloqueado
		
	
		IF NOT @cdAgenteComercialCooperativaCompromissoCompra is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdAgenteComercialCooperativaCompromissoCompra = ' + convert(varchar, @cdAgenteComercialCooperativaCompromissoCompra) + ' '
		END

		IF NOT @cdPessoaOrigemFaturamento is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdPessoaOrigemFaturamento = ' + convert(varchar, @cdPessoaOrigemFaturamento) + ' '
		END

		IF NOT @cdCronogramaSafraSEQ is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdCronogramaSafraSEQ = ' + convert(varchar, @cdCronogramaSafraSEQ) + ' '
		END

		IF NOT @cdIndicadorMoedaCompromissoCompra is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdIndicadorMoedaCompromissoCompra = ' + convert(varchar, @cdIndicadorMoedaCompromissoCompra) + ' '
		END

		IF NOT @cdCompromissoCompraSEQ is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdCompromissoCompraSEQ = ' + convert(varchar, @cdCompromissoCompraSEQ) + ' '
		END

		IF NOT @cdCompromissoCompraSEQ is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdCompromissoCompraSEQ = ' + convert(varchar, @cdCompromissoCompraSEQ) + ' '
		END

	select
		 @lsComando = @lsComando + '	  	ORDER BY'
		,@lsComando = @lsComando + '	  		A.cdCompromissoCompraSEQ '
		

	exec(@lsComando)
	--print @lsComando
	

SET QUOTED_IDENTIFIER OFF

