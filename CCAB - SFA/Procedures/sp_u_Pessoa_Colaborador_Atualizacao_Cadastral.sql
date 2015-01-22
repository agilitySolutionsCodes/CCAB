﻿if exists(select * from sysobjects where name = 'sp_u_Pessoa_Colaborador_Atualizacao_Cadastral' and xtype = 'P')
	drop procedure sp_u_Pessoa_Colaborador_Atualizacao_Cadastral
go

create procedure sp_u_Pessoa_Colaborador_Atualizacao_Cadastral
(
	@cdPessoaSEQ bigint,
	@cdIndicadorPessoa	int = null,
	@cdPessoaERP	varchar(30) = null,
	@nmPessoa	varchar(70) = null,
	@nmReduzidoPessoa	varchar(30) = null,
	@enEmailPrincipalPessoa	varchar(70) = null,
	@dsLoginPessoa	varchar(30) = null,
	@nuInscricaoEstadualPessoa	varchar(30) = null,
	@nuInscricaoMunicipalPessoa	varchar(30) = null,
	@nuInscricaoRuralPessoa	varchar(30) = null,
	@cdNacionalidadePessoa	int = null,
	@nuRGCedulaEstrangeiroPessoa	varchar(30) = null,
	@dtNascimentoPessoa	datetime = null,
	@cdIndicadorSexoPessoa	int = null,
	@cdIndicadorEstadoCivilPessoa	int = null,
	@nmContatoPrincipalPessoa	varchar(30) = null,
	@nmContatoCobrancaPessoa	varchar(30) = null,
	@cdIndicadorStatusPessoa	int = null,
	@cdPaisEnderecoPrincipalPessoa	int = null,
	@enLogradouroEnderecoPrincipalPessoa	varchar(100) = null,
	@enBairroEnderecoPrincipalPessoa	varchar(70) = null,
	@enMunicipioEnderecoPrincipalPessoa	varchar(70) = null,
	@cdSiglaEstadoEnderecoPrincipalPessoa	varchar(5) = null,
	@nuCepEnderecoPrincipalPessoa	varchar(8) = null,
	@enReferenciaEnderecoPrincipalPessoa	varchar(30) = null,
	@nuCaixaPostalEnderecoPrincipalPessoa	varchar(30) = null,
	@cdPaisEnderecoCobrancaPessoa	int = null,
	@enLogradouroEnderecoCobrancaPessoa	varchar(100) = null,
	@enBairroEnderecoCobrancaPessoa	varchar(70) = null,
	@enMunicipioEnderecoCobrancaPessoa	varchar(70) = null,
	@cdSiglaEstadoEnderecoCobrancaPessoa	varchar(5) = null,
	@nuCepEnderecoCobrancaPessoa	varchar(8) = null,
	@enReferenciaEnderecoCobrancaPessoa	varchar(30) = null,
	@nuCaixaPostalEnderecoCobrancaPessoa	varchar(30) = null,
	@cdPaisEnderecoEntregaPessoa	int = null,
	@enLogradouroEnderecoEntregaPessoa	varchar(100) = null,
	@enBairroEnderecoEntregaPessoa	varchar(70) = null,
	@enMunicipioEnderecoEntregaPessoa	varchar(70) = null,
	@cdSiglaEstadoEnderecoEntregaPessoa	varchar(5) = null,
	@nuCepEnderecoEntregaPessoa	varchar(8) = null,
	@enReferenciaEnderecoEntregaPessoa	varchar(30) = null,
	@nuCaixaPostalEnderecoEntregaPessoa	varchar(30) = null,
	@cdPaisTelefonePrincipalPessoa	int = null,
	@nuDDDTelefonePrincipalPessoa	varchar(5) = null,
	@nuTelefonePrincipalPessoa	varchar(30) = null,
	@cdPaisTelefoneFAXPessoa	int = null,
	@nuDDDTelefoneFAXPessoa	varchar(5) = null,
	@nuTelefoneFAXPessoa	varchar(30) = null,
	@cdPaisTelefoneCelularPessoa	int = null,
	@nuDDDTelefoneCelularPessoa	varchar(5) = null,
	@nuTelefoneCelularPessoa	varchar(30) = null
)
as

	update Pessoa 
	SET
		cdIndicadorPessoa = @cdIndicadorPessoa,
		cdPessoaERP = @cdPessoaERP,
		nmPessoa = @nmPessoa,
		nmReduzidoPessoa = @nmReduzidoPessoa,
		enEmailPrincipalPessoa = @enEmailPrincipalPessoa,
		dsLoginPessoa = @dsLoginPessoa,
		nuInscricaoEstadualPessoa = @nuInscricaoEstadualPessoa,
		nuInscricaoMunicipalPessoa = @nuInscricaoMunicipalPessoa,
		nuInscricaoRuralPessoa = @nuInscricaoRuralPessoa,
		cdNacionalidadePessoa = @cdNacionalidadePessoa,
		nuRGCedulaEstrangeiroPessoa = @nuRGCedulaEstrangeiroPessoa,
		dtNascimentoPessoa = @dtNascimentoPessoa,
		cdIndicadorSexoPessoa = @cdIndicadorSexoPessoa,
		cdIndicadorEstadoCivilPessoa = @cdIndicadorEstadoCivilPessoa,
		nmContatoPrincipalPessoa = @nmContatoPrincipalPessoa,
		nmContatoCobrancaPessoa = @nmContatoCobrancaPessoa,
		cdIndicadorStatusPessoa = @cdIndicadorStatusPessoa,
		cdPaisEnderecoPrincipalPessoa = @cdPaisEnderecoPrincipalPessoa,
		enLogradouroEnderecoPrincipalPessoa = @enLogradouroEnderecoPrincipalPessoa,
		enBairroEnderecoPrincipalPessoa = @enBairroEnderecoPrincipalPessoa,
		enMunicipioEnderecoPrincipalPessoa = @enMunicipioEnderecoPrincipalPessoa,
		cdSiglaEstadoEnderecoPrincipalPessoa = @cdSiglaEstadoEnderecoPrincipalPessoa,
		nuCepEnderecoPrincipalPessoa = @nuCepEnderecoPrincipalPessoa,
		enReferenciaEnderecoPrincipalPessoa = @enReferenciaEnderecoPrincipalPessoa,
		nuCaixaPostalEnderecoPrincipalPessoa = @nuCaixaPostalEnderecoPrincipalPessoa,
		cdPaisEnderecoCobrancaPessoa = @cdPaisEnderecoCobrancaPessoa,
		enLogradouroEnderecoCobrancaPessoa = @enLogradouroEnderecoCobrancaPessoa,
		enBairroEnderecoCobrancaPessoa = @enBairroEnderecoCobrancaPessoa,
		enMunicipioEnderecoCobrancaPessoa = @enMunicipioEnderecoCobrancaPessoa,
		cdSiglaEstadoEnderecoCobrancaPessoa = @cdSiglaEstadoEnderecoCobrancaPessoa,
		nuCepEnderecoCobrancaPessoa = @nuCepEnderecoCobrancaPessoa,
		enReferenciaEnderecoCobrancaPessoa = @enReferenciaEnderecoCobrancaPessoa,
		nuCaixaPostalEnderecoCobrancaPessoa = @nuCaixaPostalEnderecoCobrancaPessoa,
		cdPaisEnderecoEntregaPessoa = @cdPaisEnderecoEntregaPessoa,
		enLogradouroEnderecoEntregaPessoa = @enLogradouroEnderecoEntregaPessoa,
		enBairroEnderecoEntregaPessoa = @enBairroEnderecoEntregaPessoa,
		enMunicipioEnderecoEntregaPessoa = @enMunicipioEnderecoEntregaPessoa,
		cdSiglaEstadoEnderecoEntregaPessoa = @cdSiglaEstadoEnderecoEntregaPessoa,
		nuCepEnderecoEntregaPessoa = @nuCepEnderecoEntregaPessoa,
		enReferenciaEnderecoEntregaPessoa = @enReferenciaEnderecoEntregaPessoa,
		nuCaixaPostalEnderecoEntregaPessoa = @nuCaixaPostalEnderecoEntregaPessoa,
		cdPaisTelefonePrincipalPessoa = @cdPaisTelefonePrincipalPessoa,
		nuDDDTelefonePrincipalPessoa = @nuDDDTelefonePrincipalPessoa,
		nuTelefonePrincipalPessoa = @nuTelefonePrincipalPessoa,
		cdPaisTelefoneFAXPessoa = @cdPaisTelefoneFAXPessoa,
		nuDDDTelefoneFAXPessoa = @nuDDDTelefoneFAXPessoa,
		nuTelefoneFAXPessoa = @nuTelefoneFAXPessoa,
		cdPaisTelefoneCelularPessoa = @cdPaisTelefoneCelularPessoa,
		nuDDDTelefoneCelularPessoa = @nuDDDTelefoneCelularPessoa,
		nuTelefoneCelularPessoa = @nuTelefoneCelularPessoa
	Where
		cdPessoaSEQ = @cdPessoaSEQ

go