using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for ItemMenu
/// </summary>
public class ItemMenu
{
    #region Variáveis Modulares

    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public ItemMenu()
	{
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public DataTable ObterLista(Int64 cdPessoaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_ItemMenu", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaSeguranca(Int64 cdPessoaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_ItemMenu_Seguranca", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            if (cdPessoaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    #endregion Métodos
}
