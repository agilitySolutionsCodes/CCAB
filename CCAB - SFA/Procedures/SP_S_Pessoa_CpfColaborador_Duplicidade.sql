set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_Pessoa_CpfColaborador_Duplicidade.sql
**		Name: SP_S_Pessoa_CpfColaborador_Duplicidade
**		Desc: Retorna o Id da pessoa caso encontre seu Cpf
**
**		Auth: Roberto Chaparro
**		Date: Abr 28 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_Pessoa_CpfColaborador_Duplicidade]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_Pessoa_CpfColaborador_Duplicidade]
END
GO

CREATE PROCEDURE [dbo].[SP_S_Pessoa_CpfColaborador_Duplicidade]
	@nuCNPJCPFPessoa					varchar(30)

AS

	SELECT
		cdPessoaSEQ
	FROM
		dbo.Pessoa
	WHERE
		nuCNPJCPFPessoa				= @nuCNPJCPFPessoa
	AND	cdIndicadorTipoPerfilPessoa in (4, 5) --Colaboradores
		

SET QUOTED_IDENTIFIER OFF

