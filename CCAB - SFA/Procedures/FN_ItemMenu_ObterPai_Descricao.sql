set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: FN_ItemMenu_ObterPai_Descricao.sql
**		Name: FN_ItemMenu_ObterPai_Descricao
**		Desc: Obtem o path de descrições do Pai
**
**		Auth: Roberto Chaparro
**		Date: Jun 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FN_ItemMenu_ObterPai_Descricao]'))
BEGIN
	DROP FUNCTION [dbo].[FN_ItemMenu_ObterPai_Descricao]
END
GO

CREATE FUNCTION [dbo].[FN_ItemMenu_ObterPai_Descricao] 
(@cdItemMenuSEQ		bigint)

returns		varchar(max)

AS
BEGIN

declare
	 @FETCH_ItemMenu			int

	,@dsItemMenu		varchar(max)
	,@dsItemMenu_Aux	varchar(70)
	,@cdContador		int

	declare @ItemMenu	TABLE 
				(cdId			int
				,dsItemMenu	varchar(70))


	

	select
		 @dsItemMenu	= ''
		,@cdContador	= 0

	-- Definicao do Cursor
	DECLARE CS_ItemMenu CURSOR FOR
	select 
		dsItemMenu 
	from 
		dbo.FN_ItemMenu_ObterPai_Descricao_Interna(@cdItemMenuSEQ)

	
	OPEN CS_ItemMenu                                
	FETCH NEXT FROM CS_ItemMenu
	INTO 	@dsItemMenu_Aux

	SELECT
		@FETCH_ItemMenu = @@FETCH_STATUS

	WHILE @FETCH_ItemMenu = 0
	BEGIN 

		insert into	@ItemMenu
			(cdId
			,dsItemMenu)
		values
			(@cdContador
			,ltrim(rtrim(@dsItemMenu_Aux)))

		select
			@cdContador = @cdContador + 1

		FETCH NEXT FROM CS_ItemMenu
		INTO 	@dsItemMenu_Aux

		SELECT
			@FETCH_ItemMenu = @@FETCH_STATUS
							
	END

	CLOSE CS_ItemMenu
	DEALLOCATE CS_ItemMenu




	-- Definicao do Cursor
	DECLARE CS_ItemMenu CURSOR FOR
	SELECT
		dsItemMenu
	FROM 
		@ItemMenu
	ORDER BY
		cdId	desc


	OPEN CS_ItemMenu                                
	FETCH NEXT FROM CS_ItemMenu
	INTO 	@dsItemMenu_Aux

	SELECT
		@FETCH_ItemMenu = @@FETCH_STATUS

	WHILE @FETCH_ItemMenu = 0
	BEGIN 

		select
			@dsItemMenu = @dsItemMenu + @dsItemMenu_Aux + ' / '


		FETCH NEXT FROM CS_ItemMenu
		INTO 	@dsItemMenu_Aux

		SELECT
			@FETCH_ItemMenu = @@FETCH_STATUS
							
	END

	CLOSE CS_ItemMenu
	DEALLOCATE CS_ItemMenu


	select
		@dsItemMenu = SUBSTRING(@dsItemMenu, 1, len(@dsItemMenu) - 2)




	RETURN @dsItemMenu

END

	
