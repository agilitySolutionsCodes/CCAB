set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: FN_ItemMenu_ObterPai_Descricao_Interna.sql
**		Name: FN_ItemMenu_ObterPai_Descricao_Interna
**		Desc: Obtem o path de descrições do Pai, usada internamente
**
**		Auth: Roberto Chaparro
**		Date: Jun 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FN_ItemMenu_ObterPai_Descricao_Interna]'))
BEGIN
	DROP FUNCTION [dbo].[FN_ItemMenu_ObterPai_Descricao_Interna]
END
GO

CREATE FUNCTION [dbo].[FN_ItemMenu_ObterPai_Descricao_Interna] 
(@cdItemMenuSEQ		bigint)


RETURNS @ItemMenu table
						(cdItemMenuSuperior		bigint
						,dsItemMenu				varchar(max))
AS
BEGIN

declare
	 @cdItemMenuSuperior	bigint

	INSERT INTO @ItemMenu
		(cdItemMenuSuperior
		,dsItemMenu)
	SELECT
		 cdItemMenuSuperior
		,dsItemMenu
	FROM
		dbo.ItemMenu
	WHERE
		cdItemMenuSEQ			= @cdItemMenuSEQ
	and	not cdItemMenuSuperior		is null


	select
		 @cdItemMenuSuperior	= cdItemMenuSuperior
	FROM
		@ItemMenu



	IF not @cdItemMenuSuperior is null
	BEGIN
		INSERT INTO @ItemMenu
			(cdItemMenuSuperior
			,dsItemMenu)
		SELECT
			 cdItemMenuSuperior
			,dsItemMenu
		FROM
			dbo.FN_ItemMenu_ObterPai_Descricao_Interna(@cdItemMenuSuperior)
	END





  RETURN
END

	
