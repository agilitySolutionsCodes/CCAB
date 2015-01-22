set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_Pessoa_Login_Duplicidade.sql
**		Name: SP_S_Pessoa_Login_Duplicidade
**		Desc: Retorna o Id da pessoa caso encontre seu Login
**
**		Auth: Roberto Chaparro
**		Date: Abr 28 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_Pessoa_Login_Duplicidade]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_Pessoa_Login_Duplicidade]
END
GO

CREATE PROCEDURE [dbo].[SP_S_Pessoa_Login_Duplicidade]
	 @dsLoginPessoa			varchar(30)

AS

	SELECT
		cdPessoaSEQ
	FROM
		dbo.Pessoa
	WHERE
		upper(rtrim(ltrim(dsLoginPessoa)))		= upper(rtrim(ltrim(@dsLoginPessoa)))

SET QUOTED_IDENTIFIER OFF

