using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for TipoCultura
/// </summary>
public class TipoCultura
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public TipoCultura()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public string Incluir(string cdTipoCulturaERP, string dsTipoCultura, Int64 nuOrdemApresentacaoTipoCultura, string wkTipoCultura, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            Int64 cdTipoCulturaSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            //Consistências
            if (dsTipoCultura.Trim() == "")
            {
                return "Descrição Tipo Cultura" + moPadrao.MensagemObrigatorio;
            }


            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário da Última Alteração" + moPadrao.MensagemObrigatorio;
            }

            // Verifica se a descricao do tipo de cultura já foi cadastrada
            bool lbDisponivel = true;
            lbDisponivel = VerificaDescricaoTipoCultura(dsTipoCultura.Trim(),0);
            if (lbDisponivel == false)
            {
                return "Descrição do Tipo de Cultura já cadastrada";

            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoTipoCultura");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_TipoCultura";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            if (cdTipoCulturaERP.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@cdTipoCulturaERP", SqlDbType.VarChar, 30);
                loSqlCommand.Parameters["@cdTipoCulturaERP"].Value = cdTipoCulturaERP;
            }


            loSqlCommand.Parameters.Add("@dsTipoCultura", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@dsTipoCultura"].Value = dsTipoCultura;

            if (nuOrdemApresentacaoTipoCultura != 0)
            {
                loSqlCommand.Parameters.Add("@nuOrdemApresentacaoTipoCultura", SqlDbType.BigInt);
                loSqlCommand.Parameters["@nuOrdemApresentacaoTipoCultura"].Value = nuOrdemApresentacaoTipoCultura;
            }
            else
            {
                loSqlCommand.Parameters.Add("@nuOrdemApresentacaoTipoCultura", SqlDbType.BigInt);
                loSqlCommand.Parameters["@nuOrdemApresentacaoTipoCultura"].Value = 1;
            }

            if (wkTipoCultura.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkTipoCultura", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkTipoCultura"].Value = wkTipoCultura;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;



            loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Direction = ParameterDirection.Output;


            loSqlCommand.ExecuteNonQuery();

            cdTipoCulturaSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value);

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

    public string Alterar(Int64 cdTipoCulturaSEQ, string cdTipoCulturaERP, string dsTipoCultura, int cdIndicadorStatusTipoCultura, Int64 nuOrdemApresentacaoTipoCultura, string wkTipoCultura, Int64 cdUsuarioUltimaAlteracao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            //Consistências
            if (cdTipoCulturaSEQ == 0)
            {
                return "Código" + moPadrao.MensagemObrigatorio;
            }


            if (dsTipoCultura.Trim() == "")
            {
                return "Descrição Tipo Cultura" + moPadrao.MensagemObrigatorio;
            }


            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário da Última Alteração" + moPadrao.MensagemObrigatorio;
            }

            // Verifica se a descricao do tipo de cultura já foi cadastrada
            bool lbDisponivel = true;
            lbDisponivel = VerificaDescricaoTipoCultura(dsTipoCultura.Trim(), cdTipoCulturaSEQ);
            if (lbDisponivel == false)
            {
                return "Descrição do Tipo de Cultura já cadastrada";

            }
 
            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoTipoCultura");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_TipoCultura";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

            if (cdTipoCulturaERP.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@cdTipoCulturaERP", SqlDbType.VarChar, 30);
                loSqlCommand.Parameters["@cdTipoCulturaERP"].Value = cdTipoCulturaERP;
            }

            loSqlCommand.Parameters.Add("@dsTipoCultura", SqlDbType.VarChar, 30);
            loSqlCommand.Parameters["@dsTipoCultura"].Value = dsTipoCultura;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusTipoCultura", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusTipoCultura"].Value = cdIndicadorStatusTipoCultura;

            if (nuOrdemApresentacaoTipoCultura != 0)
            {
                loSqlCommand.Parameters.Add("@nuOrdemApresentacaoTipoCultura", SqlDbType.BigInt);
                loSqlCommand.Parameters["@nuOrdemApresentacaoTipoCultura"].Value = nuOrdemApresentacaoTipoCultura;
            }

            if (wkTipoCultura.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkTipoCultura", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkTipoCultura"].Value = wkTipoCultura;
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

    public DataTable ObterLista(Int64 cdTipoCulturaSEQ, string dsTipoCultura, int cdIndicadorStatusTipoCultura)
    {
        
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_TipoCultura", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (cdTipoCulturaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;
            }

            if (dsTipoCultura.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsTipoCultura", SqlDbType.VarChar, 30);
                loSqlDataAdapter.SelectCommand.Parameters["@dsTipoCultura"].Value = dsTipoCultura;
            }

            if (cdIndicadorStatusTipoCultura != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusTipoCultura", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusTipoCultura"].Value = cdIndicadorStatusTipoCultura;
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

    public DataTable Obter(Int64 cdTipoCulturaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_TipoCultura", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;


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

    public DataTable ObterListaHistorico(Int64 cdTipoCulturaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_TipoCulturaHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdTipoCulturaSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;
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

    public DataTable ObterHistorico(Int64 cdTipoCulturaHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_TipoCulturaHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdTipoCulturaHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoCulturaHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdTipoCulturaHistoricoSEQ"].Value = cdTipoCulturaHistoricoSEQ;
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

    private bool VerificaDescricaoTipoCultura(String dsTipoCultura, Int64 cdTipoCulturaSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificaDescricaoTipoCultura", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@dsTipoCultura", SqlDbType.VarChar, 30);
            loSqlDataAdapter.SelectCommand.Parameters["@dsTipoCultura"].Value = dsTipoCultura;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            if (loDataTable.Rows.Count > 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }

    #endregion Métodos
}
