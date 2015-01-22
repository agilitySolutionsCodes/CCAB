set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_TipoCultura_AK.sql
**		Name: SP_S_TipoCultura_AK
**		Desc: Seleciona um registro da AK da tabela TipoCultura
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_TipoCultura_AK]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_TipoCultura_AK]
END
GO

CREATE PROCEDURE [dbo].[SP_S_TipoCultura_AK]
	 @cdTipoCulturaERP			varchar(30)
AS

	SELECT
		 cdTipoCulturaSEQ
	FROM
		dbo.TipoCultura				(nolock)
	WHERE
		cdTipoCulturaERP			= @cdTipoCulturaERP



SET QUOTED_IDENTIFIER OFF

