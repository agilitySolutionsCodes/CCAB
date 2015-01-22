using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for GrupoAcesso
/// </summary>
public class GrupoAcesso
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares


	public GrupoAcesso()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public DataTable Obter(Int64 cdGrupoAcessoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdGrupoAcessoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
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

    // Overload criado apenas para teste do FrontEnd. Parâmetros sem efeito no método...
    public DataTable ObterLista(string dsGrupoAcesso, Int64 cdIndicadorStatusGrupoAcesso) 
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_GrupoAcesso_Filtro", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


            if (dsGrupoAcesso.Trim() != "")
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@dsGrupoAcesso", SqlDbType.VarChar, 70);
                loSqlDataAdapter.SelectCommand.Parameters["@dsGrupoAcesso"].Value = dsGrupoAcesso;
            }

            if (cdIndicadorStatusGrupoAcesso != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorStatusGrupoAcesso", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorStatusGrupoAcesso"].Value = cdIndicadorStatusGrupoAcesso;
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

    public DataTable ObterListaPermissao(Int64 cdGrupoAcessoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();
            DataTable loDataTableRetorno = new DataTable();
            DataTable loDataTableHabilitacao;


            loDataTableRetorno.Columns.Add("cdItemMenu", System.Type.GetType("System.Int32"));
            loDataTableRetorno.Columns.Add("dsItemMenu", System.Type.GetType("System.String"));

            loDataTableRetorno.Columns.Add("Pesquisar_Value", System.Type.GetType("System.Boolean"));
            loDataTableRetorno.Columns.Add("Incluir_Value", System.Type.GetType("System.Boolean"));
            loDataTableRetorno.Columns.Add("Alterar_Value", System.Type.GetType("System.Boolean"));
            loDataTableRetorno.Columns.Add("Excluir_Value", System.Type.GetType("System.Boolean"));
            loDataTableRetorno.Columns.Add("Visualizar_Value", System.Type.GetType("System.Boolean"));

            loDataTableRetorno.Columns.Add("Pesquisar_Enabled", System.Type.GetType("System.Boolean"));
            loDataTableRetorno.Columns.Add("Incluir_Enabled", System.Type.GetType("System.Boolean"));
            loDataTableRetorno.Columns.Add("Alterar_Enabled", System.Type.GetType("System.Boolean"));
            loDataTableRetorno.Columns.Add("Excluir_Enabled", System.Type.GetType("System.Boolean"));
            loDataTableRetorno.Columns.Add("Visualizar_Enabled", System.Type.GetType("System.Boolean"));



            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_GrupoAcesso_ItemMenu", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            foreach (DataRow loDataRow in loDataTable.Rows)
            {
                DataRow r = loDataTableRetorno.NewRow();

                r["cdItemMenu"] = loDataRow["cdItemMenuSEQ"];
                r["dsItemMenu"] = loDataRow["dsItemMenu"];

                /////////////////// -- Habilitação
                //Verifico se a Pesquisa está habilitada
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Habilitacao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 4; //Pesquisa
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Pesquisar_Enabled"] = false;
                }
                else
                {
                    r["Pesquisar_Enabled"] = true;
                }


                //Verifico se a Visualização está habilitada
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Habilitacao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 5; //Visualização
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Visualizar_Enabled"] = false;
                }
                else
                {
                    r["Visualizar_Enabled"] = true;
                }


                //Verifico se a Inclusão está habilitada
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Habilitacao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 1; //Inclusão
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Incluir_Enabled"] = false;
                }
                else
                {
                    r["Incluir_Enabled"] = true;
                }

                
                //Verifico se a Alteração está habilitada
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Habilitacao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 2; //Alteração
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Alterar_Enabled"] = false;
                }
                else
                {
                    r["Alterar_Enabled"] = true;
                }


                //Verifico se a Exclusão está habilitada
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Habilitacao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 3; //Exclusão
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Excluir_Enabled"] = false;
                }
                else
                {
                    r["Excluir_Enabled"] = true;
                }




                /////////////////// -- Permissão
                //Verifico se a Pesquisa está permitida
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Permissao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 4; //Pesquisa
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Pesquisar_Value"] = false;
                }
                else
                {
                    r["Pesquisar_Value"] = true;
                }


                //Verifico se a Visualização está permitida
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Permissao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 5; //Visualização
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Visualizar_Value"] = false;
                }
                else
                {
                    r["Visualizar_Value"] = true;
                }


                //Verifico se a Inclusão está permitida
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Permissao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 1; //Inclusão
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Incluir_Value"] = false;
                }
                else
                {
                    r["Incluir_Value"] = true;
                }



                //Verifico se a Alteração está permitida
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Permissao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 2; //Alteração
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Alterar_Value"] = false;
                }
                else
                {
                    r["Alterar_Value"] = true;
                }


                //Verifico se a Exclusão está permitida
                loDataTableHabilitacao = new DataTable();
                loSqlConnection = new SqlConnection(msStringConexao);
                loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Permissao", loSqlConnection);
                loSqlCommand = loSqlConnection.CreateCommand();
                loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = loDataRow["cdItemMenuSEQ"];
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = 3; //Exclusão
                loSqlDataAdapter.Fill(loDataTableHabilitacao);
                loSqlConnection.Close();
                loSqlConnection = null;
                if (loDataTableHabilitacao.Rows.Count == 0)
                {
                    r["Excluir_Value"] = false;
                }
                else
                {
                    r["Excluir_Value"] = true;
                }





                loDataTableRetorno.Rows.Add(r);
            }


            return loDataTableRetorno; 


        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

        

    }

    public DataTable ObterLista()    
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_GrupoAcesso", loSqlConnection);

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

    public DataTable ObterHistorico(Int64 cdGrupoAcessoHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcessoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdGrupoAcessoHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoHistoricoSEQ"].Value = cdGrupoAcessoHistoricoSEQ;
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

    public DataTable ObterListaHistorico(Int64 cdGrupoAcessoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_GrupoAcessoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdGrupoAcessoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
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

    public string Incluir(string dsGrupoAcesso, int cdIndicadorStatusGrupoAcesso, Int64 cdSistemaGrupoAcesso, string wkGrupoAcesso)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            string MensagemDuplicidade;

            //Consistências
            if (dsGrupoAcesso.Trim() == "")
            {
                return "Descrição " + moPadrao.MensagemObrigatorio;
            }

            MensagemDuplicidade = VerificarDuplicidadeGrupoAcesso(0, dsGrupoAcesso);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }

            Int64 cdGrupoAcessoSEQ = 0;

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoGrupoAcesso");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_GrupoAcesso";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@dsGrupoAcesso", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@dsGrupoAcesso"].Value = dsGrupoAcesso;


            if (wkGrupoAcesso.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkGrupoAcesso", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkGrupoAcesso"].Value = wkGrupoAcesso;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;

            loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Direction = ParameterDirection.Output;

            loSqlCommand.ExecuteNonQuery();

            cdGrupoAcessoSEQ = Convert.ToInt64(loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value);

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            //return cdGrupoAcessoSEQ;
            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoGrupoAcesso");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(Int64 cdGrupoAcessoSEQ, string dsGrupoAcesso, int cdIndicadorStatusGrupoAcesso, Int64 cdSistemaGrupoAcesso, string wkGrupoAcesso)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            string MensagemDuplicidade;

            //Consistências
            if (cdGrupoAcessoSEQ == 0)
            {
                return "Código " + moPadrao.MensagemObrigatorio;
            }

            if (dsGrupoAcesso.Trim() == "")
            {
                return "Descrição " + moPadrao.MensagemObrigatorio;
            }

            if (cdIndicadorStatusGrupoAcesso == 0)
            {
                return "Situação " + moPadrao.MensagemObrigatorio;
            }


            MensagemDuplicidade = VerificarDuplicidadeGrupoAcesso(cdGrupoAcessoSEQ, dsGrupoAcesso);
            if (MensagemDuplicidade != "")
            {
                return MensagemDuplicidade;
            }


            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoGrupoAcesso");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_GrupoAcesso";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;

            loSqlCommand.Parameters.Add("@dsGrupoAcesso", SqlDbType.VarChar, 70);
            loSqlCommand.Parameters["@dsGrupoAcesso"].Value = dsGrupoAcesso;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusGrupoAcesso", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusGrupoAcesso"].Value = cdIndicadorStatusGrupoAcesso;
            

            if (wkGrupoAcesso.Trim() != "")
            {
                loSqlCommand.Parameters.Add("@wkGrupoAcesso", SqlDbType.VarChar, 255);
                loSqlCommand.Parameters["@wkGrupoAcesso"].Value = wkGrupoAcesso;
            }

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;


            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoGrupoAcesso");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    public string Excluir(Int64 cdGrupoAcessoSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            // Verifica se o cronograma safra pode ser excluido
            bool lbDisponivel = true;
            lbDisponivel = VerificarExclusaoGrupoAcesso(cdGrupoAcessoSEQ);
            if (lbDisponivel == false)
            {
                return "Exclusão não permitida pois o Grupo de Acesso está vinculado a uma ou mais Pessoas.";

            }


            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;



            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoGrupoAcesso");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_GrupoAcesso";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransacaoGrupoAcesso");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    private bool VerificarExclusaoGrupoAcesso(Int64 cdGrupoAcessoSEQ)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_VerificarExclusaoGrupoAcesso", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;

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

    private string VerificarDuplicidadeGrupoAcesso(Int64 cdGrupoAcessoSEQ, string dsGrupoAcesso)
    {
        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcesso_Duplicidade", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@dsGrupoAcesso", SqlDbType.VarChar, 70);
            loSqlDataAdapter.SelectCommand.Parameters["@dsGrupoAcesso"].Value = dsGrupoAcesso.Trim();
            
            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;


            if (cdGrupoAcessoSEQ == 0) //Inclusão
            {
                if (loDataTable.Rows.Count > 0)
                {
                    return "Grupo de Acesso não pode ser duplicado.";
                }
                else
                {
                    return "";
                }
            }
            else
            {
                if (loDataTable.Rows.Count > 0)
                {
                    if (Convert.ToInt64(loDataTable.Rows[0]["cdGrupoAcessoSEQ"]) != cdGrupoAcessoSEQ)
                    {
                        return "Grupo de Acesso não pode ser duplicado.";
                    }
                    return "";
                }
                return "";
            }



        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }

    }


    public string SalvarPermissao(Int64 cdGrupoAcessoSEQ, DataTable poDataTable)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {



            //Consistências
            if (cdGrupoAcessoSEQ == 0)
            {
                return "Código " + moPadrao.MensagemObrigatorio;
            }


            foreach (DataRow loDataRow in poDataTable.Rows)
            {
                try
                {
                    Int16 cdIndicadorTipoMenuOperacao_Inclusao;
                    Int16 cdIndicadorTipoMenuOperacao_Alteracao;
                    Int16 cdIndicadorTipoMenuOperacao_Exclusao;
                    Int16 cdIndicadorTipoMenuOperacao_Pesquisa;
                    Int16 cdIndicadorTipoMenuOperacao_Visualizacao;

                    cdIndicadorTipoMenuOperacao_Inclusao = Convert.ToInt16(loDataRow["Incluir_Value"]);
                    cdIndicadorTipoMenuOperacao_Alteracao = Convert.ToInt16(loDataRow["Alterar_Value"]);
                    cdIndicadorTipoMenuOperacao_Exclusao = Convert.ToInt16(loDataRow["Excluir_Value"]);
                    cdIndicadorTipoMenuOperacao_Pesquisa = Convert.ToInt16(loDataRow["Pesquisar_Value"]);
                    cdIndicadorTipoMenuOperacao_Visualizacao = Convert.ToInt16(loDataRow["Visualizar_Value"]);


                    SqlConnection loSqlConnection = null;
                    SqlCommand loSqlCommand = null;

                    loSqlConnection = new SqlConnection(msStringConexao);
                    loSqlConnection.Open();
                    loSqlCommand = loSqlConnection.CreateCommand();
                    loSqlTransaction = loSqlConnection.BeginTransaction("TransacaoGrupoAcesso");
                    loSqlCommand.Connection = loSqlConnection;
                    loSqlCommand.Transaction = loSqlTransaction;

                    loSqlCommand.CommandText = "SP_U_GrupoAcesso_Permissao";
                    loSqlCommand.CommandType = CommandType.StoredProcedure;

                    loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;

                    loSqlCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdItemMenuSEQ"].Value = Convert.ToInt64(loDataRow["cdItemMenu"]);

                    loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao_Inclusao", SqlDbType.Bit);
                    loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao_Inclusao"].Value = cdIndicadorTipoMenuOperacao_Inclusao;

                    loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao_Alteracao", SqlDbType.Bit);
                    loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao_Alteracao"].Value = cdIndicadorTipoMenuOperacao_Alteracao;

                    loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao_Exclusao", SqlDbType.Bit);
                    loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao_Exclusao"].Value = cdIndicadorTipoMenuOperacao_Exclusao;

                    loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao_Pesquisa", SqlDbType.Bit);
                    loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao_Pesquisa"].Value = cdIndicadorTipoMenuOperacao_Pesquisa;

                    loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao_Visualizacao", SqlDbType.Bit);
                    loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao_Visualizacao"].Value = cdIndicadorTipoMenuOperacao_Visualizacao;

                    loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
                    loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;

                    loSqlCommand.ExecuteNonQuery();

                    loSqlTransaction.Commit();

                    loSqlConnection.Close();
                    loSqlConnection = null;


                }
                catch (Exception loException)
                {
                    loSqlTransaction.Rollback("TransacaoGrupoAcesso");
                    moPadrao.GravarLogErro(this.ToString(), loException.Message);
                    return moPadrao.MensagemErroAlteracao;
                }

            }

            

            return "";
        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }


    #endregion Métodos
}
