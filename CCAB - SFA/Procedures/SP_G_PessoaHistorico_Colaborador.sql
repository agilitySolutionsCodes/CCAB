set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_PessoaHistorico_Colaborador.sql
**		Name: SP_G_PessoaHistorico_Colaborador
**		Desc: Obtem uma lista de registros da tabela PessoaHistorico
**
**		Auth: Convergence
**		Date: 18/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PessoaHistorico_Colaborador]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PessoaHistorico_Colaborador]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_PessoaHistorico_Colaborador]
	 @cdPessoaSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdPessoaHistoricoSEQ
		,HIS.cdPessoaSEQ
		,HIS.cdPessoaERP
		,HIS.cdIndicadorTipoPerfilPessoa
		,HIS.cdIndicadorStatusPessoa
		,HIS.cdIndicadorPessoa
		,HIS.cdIndicadorTipoAcessoPessoa
		,HIS.dsLoginPessoa
		,HIS.dsSenhaLoginPessoa
		,HIS.cdIndicadorPrimeiroAcessoPessoa
		,HIS.cdIndicadorSenhaBloqueadaPessoa
		,HIS.nmPessoa
		,HIS.nmReduzidoPessoa
		,HIS.nmFoneticoPessoa
		,HIS.nuCNPJCPFPessoa
		,HIS.nuInscricaoEstadualPessoa
		,HIS.nuInscricaoMunicipalPessoa
		,HIS.nuInscricaoRuralPessoa
		,HIS.nuRGCedulaEstrangeiroPessoa
		,HIS.cdNacionalidadePessoa
		,HIS.cdPaisEnderecoPrincipalPessoa
		,HIS.cdPaisEnderecoCobrancaPessoa
		,HIS.cdPaisTelefonePrincipalPessoa
		,HIS.cdPaisTelefoneFAXPessoa
		,HIS.cdPaisTelefoneCelularPessoa
		,HIS.dtNascimentoPessoa
		,HIS.cdIndicadorSexoPessoa
		,HIS.cdIndicadorEstadoCivilPessoa
		,HIS.enLogradouroEnderecoPrincipalPessoa
		,HIS.enBairroEnderecoPrincipalPessoa
		,HIS.enMunicipioEnderecoPrincipalPessoa
		,HIS.cdSiglaEstadoEnderecoPrincipalPessoa
		,HIS.nuCEPEnderecoPrincipalPessoa
		,HIS.nuCaixaPostalEnderecoPrincipalPessoa
		,HIS.enReferenciaEnderecoPrincipalPessoa
		,HIS.enLogradouroEnderecoCobrancaPessoa
		,HIS.enComplementoEnderecoCobrancaPessoa
		,HIS.enComplementoEnderecoPrincipalPessoa
		,HIS.enBairroEnderecoCobrancaPessoa
		,HIS.enMunicipioEnderecoCobrancaPessoa
		,HIS.cdSiglaEstadoEnderecoCobrancaPessoa
		,HIS.nuCEPEnderecoCobrancaPessoa
		,HIS.nuCaixaPostalEnderecoCobrancaPessoa
		,HIS.enReferenciaEnderecoCobrancaPessoa
		,HIS.enLogradouroEnderecoEntregaPessoa
		,HIS.cdPaisEnderecoEntregaPessoa
		,HIS.enComplementoEnderecoEntregaPessoa
		,HIS.enBairroEnderecoEntregaPessoa
		,HIS.enMunicipioEnderecoEntregaPessoa
		,HIS.cdSiglaEstadoEnderecoEntregaPessoa
		,HIS.nuCEPEnderecoEntregaPessoa
		,HIS.nuCaixaPostalEnderecoEntregaPessoa
		,HIS.enReferenciaEnderecoEntregaPessoa
		,HIS.nuDDDTelefonePrincipalPessoa
		,HIS.nuTelefonePrincipalPessoa
		,HIS.nuDDDTelefoneFAXPessoa
		,HIS.nuTelefoneFAXPessoa
		,HIS.nuDDDTelefoneCelularPessoa
		,HIS.nuTelefoneCelularPessoa
		,HIS.enEmailPrincipalPessoa
		,HIS.nmContatoPrincipalPessoa
		,HIS.nmContatoCobrancaPessoa
		,HIS.cdGrupoAcessoSEQ
		,HIS.cdAgenteComercialRCPessoa
		,HIS.cdAgenteComercialCooperativaPessoa
		,HIS.cdAgenteComercialCCABPessoa
		,HIS.cdEmpresaColaboradorPessoa
		,HIS.cdTipoEventoHistorico
		,HIS.dtOcorrenciaHistorico
		,HIS.cdUsuarioOcorrenciaHistorico
		,HIS.cdIndicadorTipoAgenteComercialPessoa	

		,(
			CASE cdTipoEventoHistorico 
				WHEN 1 THEN 'Inclusão'
				ELSE 'Alteração'
			END	
		)	as dsTipoEventoHistorico 


		,(
			SELECT 
				USU.dsLoginPessoa
			FROM
				dbo.Pessoa	USU	(nolock)
			WHERE
				USU.cdPessoaSEQ = HIS.cdUsuarioOcorrenciaHistorico
		)	as nmUsuario


	FROM
		PessoaHistorico	HIS		(nolock)	

	WHERE 
		cdPessoaSEQ = @cdPessoaSEQ
