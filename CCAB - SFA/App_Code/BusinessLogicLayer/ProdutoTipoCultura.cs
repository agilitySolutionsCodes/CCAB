using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for ProdutoTipoCultura
/// </summary>
public class ProdutoTipoCultura
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public ProdutoTipoCultura()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public string Incluir(Int64 cdProdutoSEQ, Int64 cdTipoCulturaSEQ, int cdIndicadorStatusProdutoTipoCultura, string wkProdutoTipoCultura, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Int64 cdProdutoTipoCulturaSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            //Consistências:
            if (cdProdutoSEQ == 0)
            {
                return "Produto" + moPadrao.MensagemObrigatorio;
            }

            if (cdTipoCulturaSEQ == 0)
            {
                return "Tipo de Cultura" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorStatusProdutoTipoCultura == 0)
            {
                return "Situação" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoProdutoTipoCultura");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_ProdutoTipoCultura";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

            loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusProdutoTipoCultura", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusProdutoTipoCultura"].Value = cdIndicadorStatusProdutoTipoCultura;

            if (wkProdutoTipoCultura.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkProdutoTipoCultura", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkProdutoTipoCultura"].Value = wkProdutoTipoCultura;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdProdutoTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoTipoCulturaSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            cdProdutoTipoCulturaSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoTipoCultura");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(Int64 cdProdutoTipoCulturaSEQ, Int64 cdProdutoSEQ, Int64 cdTipoCulturaSEQ, int cdIndicadorStatusProdutoTipoCultura, string wkProdutoTipoCultura, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            //Consistências:
            if (cdProdutoTipoCulturaSEQ == 0)
            {
                return "Sequencial " + moPadrao.MensagemObrigatorio;
            }

            if (cdProdutoSEQ == 0)
            {
                return "Produto" + moPadrao.MensagemObrigatorio;
            }

            if (cdTipoCulturaSEQ == 0)
            {
                return "Tipo de Cultura" + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorStatusProdutoTipoCultura == 0)
            {
                return "Situação" + moPadrao.MensagemObrigatorio;
            }

            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoProdutoTipoCultura");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_ProdutoTipoCultura";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdProdutoTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoTipoCulturaSEQ"].Value = cdProdutoTipoCulturaSEQ;

            loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

            loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusProdutoTipoCultura", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusProdutoTipoCultura"].Value = cdIndicadorStatusProdutoTipoCultura;

            if (wkProdutoTipoCultura.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkProdutoTipoCultura", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkProdutoTipoCultura"].Value = wkProdutoTipoCultura;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;


            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoTipoCultura");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public DataTable ObterLista()
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_ProdutoTipoCultura", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


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

    public DataTable Obter(Int64 cdProdutoTipoCulturaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_ProdutoTipoCultura", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdProdutoTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdProdutoTipoCulturaSEQ"].Value = cdProdutoTipoCulturaSEQ;


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

    public DataTable ObterListaHistorico(Int64 cdProdutoTipoCulturaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_ProdutoTipoCulturaHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdProdutoTipoCulturaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdProdutoTipoCulturaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdProdutoTipoCulturaSEQ"].Value = cdProdutoTipoCulturaSEQ;
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

    public DataTable ObterHistorico(Int64 cdProdutoTipoCulturaHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_ProdutoTipoCulturaHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdProdutoTipoCulturaHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdProdutoTipoCulturaHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdProdutoTipoCulturaHistoricoSEQ"].Value = cdProdutoTipoCulturaHistoricoSEQ;
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
