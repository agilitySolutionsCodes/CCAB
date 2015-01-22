set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa_Colaborador
**		Name: SP_G_Pessoa_Colaborador
**		Desc: Seleciona registros na tabela Pessoa - Colaborador
**
**		Auth: Roberto Chaparro
**		Date: Mar 18 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_Colaborador]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa_Colaborador]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa_Colaborador]
	 @cdPessoaSEQ							bigint			= null
	,@dsLoginPessoa							varchar(30)		= null
	,@nuCNPJCPFPessoa						varchar(30)		= null
	,@nmFoneticoPessoa						varchar(8000)	= null
	,@cdIndicadorStatusPessoa				int				= null
	,@cdIndicadorSenhaBloqueadaPessoa		int				= null
	,@cdIndicadorTipoPerfilPessoa			int				= null
	,@cdEmpresaColaboradorPessoa			bigint			= null

AS

DECLARE
	@lsComando		varchar(max)


	select
		 @lsComando = 'SELECT ' 

		,@lsComando = @lsComando + '	  PES.cdPessoaSEQ'
		,@lsComando = @lsComando + '	 ,PES.cdPessoaERP'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorTipoPerfilPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorStatusPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorTipoAcessoPessoa'
		,@lsComando = @lsComando + '	 ,PES.dsLoginPessoa'
		,@lsComando = @lsComando + '	 ,PES.dsSenhaLoginPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorPrimeiroAcessoPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorSenhaBloqueadaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmReduzidoPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCNPJCPFPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuInscricaoEstadualPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuInscricaoMunicipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuInscricaoRuralPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdNacionalidadePessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enLogradouroEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enBairroEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enMunicipioEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdSiglaEstadoEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCEPEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCaixaPostalEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enReferenciaEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enLogradouroEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enComplementoEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enComplementoEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enBairroEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enMunicipioEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdSiglaEstadoEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCEPEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCaixaPostalEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enReferenciaEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enLogradouroEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enComplementoEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enBairroEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enMunicipioEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdSiglaEstadoEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCEPEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCaixaPostalEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enReferenciaEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisTelefonePrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuDDDTelefonePrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuTelefonePrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisTelefoneFAXPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuDDDTelefoneFAXPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuTelefoneFAXPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisTelefoneCelularPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuDDDTelefoneCelularPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuTelefoneCelularPessoa'
		,@lsComando = @lsComando + '	 ,PES.enEmailPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmContatoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmContatoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdAgenteComercialRCPessoa'

		,@lsComando = @lsComando + '	 ,PES.cdEmpresaColaboradorPessoa'
		,@lsComando = @lsComando + '	 ,('
		,@lsComando = @lsComando + '	 	SELECT '
		,@lsComando = @lsComando + '	 		isnull(nmReduzidoPessoa, '''') + ''-'' + isnull(cdPessoaERP, '''') '
		,@lsComando = @lsComando + '	 	FROM'
		,@lsComando = @lsComando + '	 		dbo.Pessoa	ARC	(nolock)'
		,@lsComando = @lsComando + '	 	WHERE'
		,@lsComando = @lsComando + '	 		ARC.cdPessoaSEQ = PES.cdEmpresaColaboradorPessoa'
		,@lsComando = @lsComando + '	 )	as nmEmpresaColaboradorPessoa'

		

		,@lsComando = @lsComando + '	 ,('
		,@lsComando = @lsComando + '	 	SELECT '
		,@lsComando = @lsComando + '	 		wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	 	FROM'
		,@lsComando = @lsComando + '	 		dbo.CodigoReferenciado'
		,@lsComando = @lsComando + '	 	WHERE'
		,@lsComando = @lsComando + '	 		vrDominioCodigoReferenciado = PES.cdIndicadorStatusPessoa'
		,@lsComando = @lsComando + '	 	AND	dsDominioCodigoReferenciado = ''DMESPINDICADORATIVOINATIVO'''
		,@lsComando = @lsComando + '	 )	as dsIndicadorStatusPessoa'


		,@lsComando = @lsComando + '	 ,PES.cdAgenteComercialCCABPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdGrupoAcessoSEQ'
		,@lsComando = @lsComando + '	 ,PES.dtUltimaAlteracao'
		,@lsComando = @lsComando + '	 ,PES.cdUsuarioUltimaAlteracao'

		,@lsComando = @lsComando + '	 ,('
		,@lsComando = @lsComando + '	 	SELECT '
		,@lsComando = @lsComando + '	 		wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	 	FROM'
		,@lsComando = @lsComando + '	 		dbo.CodigoReferenciado'
		,@lsComando = @lsComando + '	 	WHERE'
		,@lsComando = @lsComando + '	 		vrDominioCodigoReferenciado = PES.cdIndicadorStatusPessoa'
		,@lsComando = @lsComando + '	 	AND	dsDominioCodigoReferenciado = ''DMESPINDICADORATIVOINATIVO'''
		,@lsComando = @lsComando + '	 )	as dsIndicadorStatusPessoa'


		,@lsComando = @lsComando + '	 ,('
		,@lsComando = @lsComando + '	 	SELECT '
		,@lsComando = @lsComando + '	 		isnull(nmReduzidoPessoa, '''') + ''-'' + isnull(cdPessoaERP, '''') '
		,@lsComando = @lsComando + '	 	FROM'
		,@lsComando = @lsComando + '	 		dbo.Pessoa	ARC	(nolock)'
		,@lsComando = @lsComando + '	 	WHERE'
		,@lsComando = @lsComando + '	 		ARC.cdPessoaSEQ = PES.cdAgenteComercialRCPessoa'
		,@lsComando = @lsComando + '	 )	as nmAgenteComercialRCPessoa'

		,@lsComando = @lsComando + '	 ,('
		,@lsComando = @lsComando + '	 	SELECT '
		,@lsComando = @lsComando + '	 		isnull(nmReduzidoPessoa, '''') + ''-'' + isnull(cdPessoaERP, '''') '
		,@lsComando = @lsComando + '	 	FROM'
		,@lsComando = @lsComando + '	 		dbo.Pessoa	ACC	(nolock)'
		,@lsComando = @lsComando + '	 	WHERE'
		,@lsComando = @lsComando + '	 		ACC.cdPessoaSEQ = PES.cdAgenteComercialCooperativaPessoa'
		,@lsComando = @lsComando + '	 )	as nmAgenteComercialCooperativaPessoa'


		,@lsComando = @lsComando + '	 ,PES.cdIndicadorTipoAgenteComercialPessoa'

		,@lsComando = @lsComando + '	 ,('
		,@lsComando = @lsComando + '	 	SELECT '
		,@lsComando = @lsComando + '	 		wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	 	FROM'
		,@lsComando = @lsComando + '	 		dbo.CodigoReferenciado'
		,@lsComando = @lsComando + '	 	WHERE'
		,@lsComando = @lsComando + '	 		vrDominioCodigoReferenciado = PES.cdIndicadorTipoAgenteComercialPessoa'
		,@lsComando = @lsComando + '	 	AND	dsDominioCodigoReferenciado = ''DMESPINDICADORTIPOAGENTE'''
		,@lsComando = @lsComando + '	 )	as dsIndicadorTipoAgenteComercialPessoa'


		,@lsComando = @lsComando + '	 ,('
		,@lsComando = @lsComando + '	 	SELECT '
		,@lsComando = @lsComando + '	 		wkDominioCodigoReferenciado'
		,@lsComando = @lsComando + '	 	FROM'
		,@lsComando = @lsComando + '	 		dbo.CodigoReferenciado'
		,@lsComando = @lsComando + '	 	WHERE'
		,@lsComando = @lsComando + '	 		vrDominioCodigoReferenciado = PES.cdIndicadorTipoPerfilPessoa'
		,@lsComando = @lsComando + '	 	AND	dsDominioCodigoReferenciado = ''DMESPINDICADORTIPOPERFIL'''
		,@lsComando = @lsComando + '	 )	as dsIndicadorTipoPerfilPessoa'






		,@lsComando = @lsComando + ' FROM '
		,@lsComando = @lsComando + '	dbo.Pessoa				PES '

		,@lsComando = @lsComando + 'WHERE '
		,@lsComando = @lsComando + '	PES.cdPessoaSEQ	> 0 '

		,@lsComando = @lsComando + 'AND cdIndicadorTipoPerfilPessoa IN (4, 5) ' -- Colaborador Cliente, Colaborador CCAB


	IF NOT @cdPessoaSEQ is null
	BEGIN
		select
			 @lsComando = @lsComando + 'AND	 PES.cdPessoaSEQ = ' 
			,@lsComando = @lsComando + convert(varchar,@cdPessoaSEQ)
			,@lsComando = @lsComando + ' ' 


	END	

	IF NOT @dsLoginPessoa is null
	BEGIN
		select
			 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PES.dsLoginPessoa))) = ''' 
			,@lsComando = @lsComando + upper(ltrim(rtrim(@dsLoginPessoa)))
			,@lsComando = @lsComando + '''' 
	END	

	IF NOT @nuCNPJCPFPessoa is null
	BEGIN
		select
			 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PES.nuCNPJCPFPessoa))) = ''' 
			,@lsComando = @lsComando + upper(ltrim(rtrim(@nuCNPJCPFPessoa)))
			,@lsComando = @lsComando + '''' 
	END	

	IF NOT @nmFoneticoPessoa is null
	BEGIN
		select
			 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PES.nmFoneticoPessoa))) like ''' + '%'
			,@lsComando = @lsComando + upper(ltrim(rtrim(@nmFoneticoPessoa)))
			,@lsComando = @lsComando + '%' + ''''
	END

	IF NOT @cdIndicadorStatusPessoa is null
	BEGIN
		select
			 @lsComando = @lsComando + 'AND	 PES.cdIndicadorStatusPessoa = ' 
			,@lsComando = @lsComando + convert(varchar,@cdIndicadorStatusPessoa)
			,@lsComando = @lsComando + ' ' 
	END

	IF NOT @cdIndicadorSenhaBloqueadaPessoa is null
	BEGIN
		select
			 @lsComando = @lsComando + 'AND	 PES.cdIndicadorSenhaBloqueadaPessoa = ' 
			,@lsComando = @lsComando + convert(varchar,@cdIndicadorSenhaBloqueadaPessoa)
			,@lsComando = @lsComando + ' ' 
	END

	IF NOT @cdIndicadorTipoPerfilPessoa is null
	BEGIN

		select
			 @lsComando = @lsComando + 'AND	 PES.cdIndicadorTipoPerfilPessoa = ' 
			,@lsComando = @lsComando + convert(varchar,@cdIndicadorTipoPerfilPessoa)
			,@lsComando = @lsComando + ' ' 
	END

	IF NOT @cdEmpresaColaboradorPessoa is null
	BEGIN
		select
			 @lsComando = @lsComando + 'AND	 PES.cdEmpresaColaboradorPessoa = ' 
			,@lsComando = @lsComando + convert(varchar,@cdEmpresaColaboradorPessoa)
			,@lsComando = @lsComando + ' ' 
	END



	select
		 @lsComando = @lsComando + 'ORDER BY '
		,@lsComando = @lsComando + '	PES.nmPessoa '



	EXEC(@lsComando)
	--print @lsComando

SET QUOTED_IDENTIFIER OFF

