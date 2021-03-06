if exists(select * from sysobjects where name = 'sp_s_Pessoa_DadosPerfil' and xtype = 'P')
	drop procedure sp_s_Pessoa_DadosPerfil
go


CREATE PROCEDURE sp_s_Pessoa_DadosPerfil
	@cdPessoaSEQ		bigint
AS


	SELECT
		 PES.cdIndicadorTipoPerfilPessoa
		,COD.wkDominioCodigoReferenciado
	FROM
		dbo.Pessoa PES INNER JOIN
		dbo.CodigoReferenciado COD ON PES.cdIndicadorTipoPerfilPessoa = COD.vrDominioCodigoReferenciado
	WHERE
		PES.cdPessoaSEQ = @cdPessoaSEQ
	AND	COD.dsDominioCodigoReferenciado = 'DMESPINDICADORTIPOPERFIL'
	ORDER BY
		COD.wkDominioCodigoReferenciado

GO

