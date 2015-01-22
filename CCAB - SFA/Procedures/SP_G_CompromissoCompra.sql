set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_CronogramaSafraVencimento_Parcelas.sql
**		Name: SP_G_CronogramaSafraVencimento_Parcelas
**		Desc: Seleciona os registros da tabela Pedido Venda
**
**		Auth: Roberto Chaparro
**		Date: Mai 10 2011 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CronogramaSafraVencimento_Parcelas]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CronogramaSafraVencimento_Parcelas]
END
GO

CREATE PROCEDURE [dbo].[SP_G_CronogramaSafraVencimento_Parcelas]
	 @cdAgenteComercialCooperativaCronogramaSafraVencimento		bigint  = null
	,@cdCronogramaSafraSEQ								bigint  
	,@cdIndicadorMoedaCronogramaSafraVencimento					int		= null
	,@cdCronogramaSafraVencimentoSEQ							bigint	= null
	,@cdIndicadorStatusCronogramaSafraVencimento				int		= null
	,@cdPessoaOrigemFaturamento							bigint  = null

AS

	DECLARE
		@lsComando		varchar(max)

	select
		 @lsComando = 'SELECT ' 

		,@lsComando = @lsComando + '	  		 A.cdCronogramaSafraVencimentoSEQ'
		,@lsComando = @lsComando + '	  		,A.dtEmissaoCronogramaSafraVencimento'
		,@lsComando = @lsComando + '            ,A.cdAgenteComercialCooperativaCronogramaSafraVencimento'
		,@lsComando = @lsComando + '            ,(ltrim(rtrim(B.nmPessoa))) + ' + '''-''' + ' + ltrim(rtrim(B.cdPessoaERP)) as dsAgenteComercialCooperativaCronogramaSafraVencimento'
		,@lsComando = @lsComando + '            ,A.cdPessoaOrigemFaturamento'
		,@lsComando = @lsComando + '            ,(ltrim(rtrim(D.nmPessoa))) + ' + '''-''' + ' + ltrim(rtrim(D.cdPessoaERP)) as dsPessoaOrigemFaturamento'
		,@lsComando = @lsComando + '            ,A.cdCronogramaSafraSEQ'
		,@lsComando = @lsComando + '            ,C.dsCronogramaSafra'
		,@lsComando = @lsComando + '	  		,A.cdIndicadorMoedaCronogramaSafraVencimento'
		,@lsComando = @lsComando + '	  		,('
		,@lsComando = @lsComando + '	  			SELECT'
		,@lsComando = @lsComando + '	  				wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	  			FROM'
		,@lsComando = @lsComando + '	  				dbo.CodigoReferenciado			(nolock)'
		,@lsComando = @lsComando + '	  			WHERE'
		,@lsComando = @lsComando + '	  				vrDominioCodigoReferenciado		= A.cdIndicadorMoedaCronogramaSafraVencimento'
		,@lsComando = @lsComando + '	  			AND	dsDominioCodigoReferenciado		= ''DMESPINDICADORMOEDA'' '
		,@lsComando = @lsComando + '	  		)	as dsIndicadorMoedaCronogramaSafraVencimento'
		,@lsComando = @lsComando + '	  		,dbo.FN_FormatarValor(A.vrTotalMoedaCronogramaSafraVencimento,2) as vrTotalMoedaCronogramaSafraVencimento'
		,@lsComando = @lsComando + '	  		,A.cdIndicadorStatusCronogramaSafraVencimento'
		,@lsComando = @lsComando + '	  		,('		
		,@lsComando = @lsComando + '	  			SELECT'
		,@lsComando = @lsComando + '	  				wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	  			FROM'
		,@lsComando = @lsComando + '	  				dbo.CodigoReferenciado			(nolock)'
		,@lsComando = @lsComando + '	  			WHERE'
		,@lsComando = @lsComando + '	  				vrDominioCodigoReferenciado		= A.cdIndicadorStatusCronogramaSafraVencimento'
		,@lsComando = @lsComando + '	  			AND	dsDominioCodigoReferenciado		= ''DMESPINDICADORSTATUSCOMPROMISSOCOMPRA'' '
		,@lsComando = @lsComando + '	  		)	as dsIndicadorStatusCronogramaSafraVencimento'

		,@lsComando = @lsComando + '	  	FROM'
		,@lsComando = @lsComando + '	  		dbo.CronogramaSafraVencimento	A (nolock)'
		,@lsComando = @lsComando + '           ,dbo.Pessoa B (nolock) '
		,@lsComando = @lsComando + '           ,dbo.CronogramaSafra C (nolock) '
		,@lsComando = @lsComando + '           ,dbo.Pessoa D (nolock) '
		
		,@lsComando = @lsComando + '		WHERE '
		,@lsComando = @lsComando + '		 	A.cdCronogramaSafraVencimentoSEQ = A.cdCronogramaSafraVencimentoSEQ ' 
		,@lsComando = @lsComando + '        and A.cdAgenteComercialCooperativaCronogramaSafraVencimento = B.cdPessoaSEQ '
		,@lsComando = @lsComando + '        and A.cdCronogramaSafraSEQ = C.cdCronogramaSafraSEQ '
		,@lsComando = @lsComando + '        and A.cdPessoaOrigemFaturamento = D.cdPessoaSEQ '
		
		IF NOT @cdAgenteComercialCooperativaCronogramaSafraVencimento is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdAgenteComercialCooperativaCronogramaSafraVencimento = ' + convert(varchar, @cdAgenteComercialCooperativaCronogramaSafraVencimento) + ' '
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

		IF NOT @cdIndicadorMoedaCronogramaSafraVencimento is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdIndicadorMoedaCronogramaSafraVencimento = ' + convert(varchar, @cdIndicadorMoedaCronogramaSafraVencimento) + ' '
		END

		IF NOT @cdCronogramaSafraVencimentoSEQ is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdCronogramaSafraVencimentoSEQ = ' + convert(varchar, @cdCronogramaSafraVencimentoSEQ) + ' '
		END

		IF NOT @cdCronogramaSafraVencimentoSEQ is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdCronogramaSafraVencimentoSEQ = ' + convert(varchar, @cdCronogramaSafraVencimentoSEQ) + ' '
		END

		IF NOT @cdIndicadorStatusCronogramaSafraVencimento is null
		BEGIN
			select
				@lsComando = @lsComando + '	AND	A.cdIndicadorStatusCronogramaSafraVencimento = ' + convert(varchar, @cdIndicadorStatusCronogramaSafraVencimento) + ' '
		END

	select
		 @lsComando = @lsComando + '	  	ORDER BY'
		,@lsComando = @lsComando + '	  		A.cdCronogramaSafraVencimentoSEQ '
		

	exec(@lsComando)
	--print @lsComando
	

SET QUOTED_IDENTIFIER OFF

