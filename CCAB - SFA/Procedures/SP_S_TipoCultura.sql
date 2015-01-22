set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_TipoCultura.sql
**		Name: SP_S_TipoCultura
**		Desc: Seleciona um registro da tabela TipoCultura
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_TipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_TipoCultura]
END
GO

CREATE PROCEDURE [dbo].[SP_S_TipoCultura]
	 @cdTipoCulturaSEQ			bigint
AS

	SELECT
		 cdTipoCulturaSEQ
		,cdTipoCulturaERP
		,dsTipoCultura
		,cdIndicadorStatusTipoCultura
		,nuOrdemApresentacaoTipoCultura
		,wkTipoCultura
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		dbo.TipoCultura				(nolock)
	WHERE
		cdTipoCulturaSEQ			= @cdTipoCulturaSEQ



SET QUOTED_IDENTIFIER OFF

