<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_OrigemFaturamento_Formulario" %>
<!-- Cabeçalho Formulário -->

<script type="text/javascript" src="../../../scripts/JScript.js"></script>

<!-- Preparação da PopUp Modal que exibirá o Formulário (Permite que o formulário seja arrastado pela tela) -->
<asp:Button runat="server" ID="btShowPanel1" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowPanel1"
    PopupControlID="Panel1" PopupDragHandleControlID="Panel1DragHandle" BackgroundCssClass="modalBackground" />
    
<div class="pageSection">
    <asp:Panel runat="Server" ID="Panel1DragHandle" CssClass="drag">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="tbTitulo_bordaEsquerda">
                    &nbsp;
                </td>
                <td class="tbTitulo_BG">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="180" class="tbTitulo_NomeTela" align="left">
                                <asp:Label runat="server" SkinID="normal" ID="lbOperacao" />
                            </td>
                            <td width="*">
                                <asp:Image ID="Image2" runat="server" Width="18" Height="36" ImageAlign="Right" ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                            </td>
                            <td width="335" class="tbTitulo_NomeTela" align="left">
                                <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="tbTitulo_bordaDireita">
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>
<!-- Área de Mensagens -->
<div>
    <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false" ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:" runat="server" />
    <asp:Label ID="lblMensagen" runat="server" Visible="False" style="color:Red; font-weight:normal"></asp:Label>
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>
<!-- Formulário -->
<div>          
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="cdCooperativaOrigemFaturamentoSEQ" CellPadding="5"
        AutoGenerateRows="false" Width="100%" GridLines="None">
        
        <EditItemTemplate>
            <div class="pageSection">
                <asp:HiddenField ID="cdCronogramaSafraSEQ" runat="server" Value='<%Session["cdCronogramaSafraSEQ"].ToString();%>' />     
                <asp:HiddenField ID="cdUsuarioUltimaAlteracao" runat="server" />     
                <asp:HiddenField ID="cdCooperativaOrigemFaturamentoSEQ" runat="server" Value='<%# Bind("cdCooperativaOrigemFaturamentoSEQ") %>' />                  
                                         
                
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbCadastro_Mestra">
                    <tr style="visibility:hidden">
                        <td valign="middle" class="fonteTbCadastro">
                            Nome da Safra:
                        </td>
                        <td class="tdCamposFormularios" colspan="4">
                            <asp:Label ID="dsCronogramaSafra" runat="server" SkinID="data"  /><%Session["dsCronogramaSafra"].ToString();%>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Agente:
                        </td>
                        <td colspan="3">
                            <asp:HiddenField ID="hiddenFieldCooperativaSEQ" runat="server" Value='<%# Bind("cdCooperativaSEQ") %>' />
                            <asp:DropDownList  ID="cdCooperativaSEQ" runat="server"  CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="470" DataTextField="nmPessoa" DataSourceID="dataSourceAgente" />
                        </td>                
                    </tr>
                    <tr>                                                
                        <td valign="middle" class="fonteTbCadastro">
                            Origem Faturamento:
                        </td>    
                        <td>
                            <asp:HiddenField ID="hiddenFieldOrigemFaturamentoSEQ" runat="server" Value='<%# Bind("cdOrigemFaturamentoSEQ") %>' />
                            <asp:DropDownList ID="cdOrigemFaturamentoSEQ" Width="470" runat="server"  CssClass="campoTexto" DataValueField="cdPessoaOrigemFaturamento" DataTextField="dsPessoaOrigemFaturamento" DataSourceID="dataSourceFornecedor" />              
                        </td>
                    </tr> 
                    <tr>                                                
                        <td valign="middle" class="fonteTbCadastro">
                            Situaçao:
                        </td>    
                        <td>
                            <asp:HiddenField ID="hiddenFieldIndicadorSituacaoOrigemFaturamento" runat="server" Value='<%# Bind("cdIndicadorSituacaoOrigemFaturamento") %>' />
                            <asp:DropDownList ID="cdIndicadorSituacaoOrigemFaturamento" Width="155" runat="server" CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" DataTextField="wkDominioCodigoReferenciado" DataSourceID="DataSourceSimNao" />        
                        </td>
                    </tr>                   
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Observação:
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="wkCooperativaOrigemFaturamento" TextMode="MultiLine" runat="server" Width="650" Rows="3" Text='<%# Bind("wkCooperativaOrigemFaturamento") %>'></asp:TextBox>
                        </td>                      
                    </tr>                    
                </table>
            </div>            
        </EditItemTemplate>          
    </asp:FormView>
    <asp:ObjectDataSource ID="dataSourcePricipioAtivo" runat="server">
    </asp:ObjectDataSource>
    <div style="text-align: right;">
        <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
            CausesValidation="true" OnCommand="btAction_OnClick" />
        <asp:Button runat="server" ID="btCancel" CommandName="Cancel" CssClass="button" Text="cancelar" 
            CausesValidation="false" OnCommand="btCancel_OnClick" />
    </div>

</div>

<asp:ObjectDataSource ID="DataSourceSimNao" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
    <SelectParameters>
        <asp:Parameter  Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORATIVOINATIVO" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="dataSourceAgente" runat="server" SelectMethod="ObterListaOnDemandERP" TypeName="Pessoa">
    <SelectParameters>
        <asp:Parameter Name="cdIndicadorTipoPerfilPessoa" DefaultValue="3" Type="Int32" />
        <asp:SessionParameter SessionField="cdUsuario" Name="cdUsuarioUltimaAlteracao" Type="Int64" />
        <asp:Parameter Name="cdIndicadorTipoAgenteComercialPessoa" DefaultValue="1" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="dataSourceFornecedor" runat="server" SelectMethod="ObterListaOrigemFaturamento" TypeName="Pessoa">
    <SelectParameters>
        <asp:Parameter Name="cdIndicadorStatusPessoa" Type="Int64" />
    </SelectParameters>
</asp:ObjectDataSource>


