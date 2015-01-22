<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>
<%-- 
<%@ Register src="_SFA/Cadastros/PessoaFisica/Formulario.ascx" tagname="formulario" tagprefix="uc" %>
<%@ Register src="_SFA/Cadastros/PessoaFisica/Resultado.ascx" tagname="resultado" tagprefix="uc" %>
<%@ Register src="_SFA/Cadastros/PessoaFisica/Filtro.ascx" tagname="filtro" tagprefix="uc" %>
<%@ Register src="_SFA/Cadastros/PessoaFisica/DadosPai.ascx" tagname="dadospai" tagprefix="uc" %>
--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<%--
            <div class="pageSection" >
                <table width="100%" border="0" cellpadding="0" cellspacing="0" 
                    __designer:mapid="8b">
                    <tr __designer:mapid="8c">
                        <td class="tbTitulo_bordaEsquerda" __designer:mapid="8d">
                            &nbsp;
                        </td>
                        <td class="tbTitulo_BG" __designer:mapid="8e">
                            <table border="0" cellpadding="0" cellspacing="0" __designer:mapid="8f">
                                <tr __designer:mapid="90">
                                    <td align="left" __designer:mapid="91" style="width: 500px">
                                        <asp:ImageButton ID="btCadastro" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btVisualizar.gif"
                                            AlternateText=".: atualizar cadastro" runat="server" OnClick="btCadastro_OnClick" 
                                            ToolTip="Atualizar Cadastro" Visible="False" />
                                        
                                    </td>
                                    <td width="20" align="right" __designer:mapid="a0">
                                        <asp:Image ID="Image2" runat="server" Width="18" Height="36" ImageAlign="Top" 
                                            ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                                    </td>
                                    <td width="240" class="tbTitulo_NomeTela" align="left" __designer:mapid="a2">
                                        <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" Width="250px" >Atualização Cadastral</asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="tbTitulo_bordaDireita" __designer:mapid="a4">
                            &nbsp;
                        </td>
                    </tr>
                </table>
                
                <br />
                
                <asp:GridView ID="grdAtualizacaoCadastral" runat="server" 
                    AutoGenerateColumns="False">
                    <Columns>
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" OnClick="GridView_OnClick" ImageUrl='<%# Bind("Imagem") %>'
                                />
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="Mensagem" HeaderText="Mensagens">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        
                    </Columns>
                    
                    
                </asp:GridView>
                <br />
                
                <br />
            </div>
            
            <div class="pageSection" >
                <table width="100%" border="0" cellpadding="0" cellspacing="0" 
                    __designer:mapid="8b">
                    <tr __designer:mapid="8c">
                        <td class="tbTitulo_bordaEsquerda" __designer:mapid="8d">
                            &nbsp;
                        </td>
                        <td class="tbTitulo_BG" __designer:mapid="8e">
                            <table border="0" cellpadding="0" cellspacing="0" __designer:mapid="8f">
                                <tr __designer:mapid="90">
                                    <td width="500" align="left" __designer:mapid="91" style="width: 500px">
                                        <asp:ImageButton ID="ImageButton1" ImageAlign="AbsMiddle" BackColor="Transparent" ImageUrl="~/imgsCCAB/tbTitulo_btVisualizar.gif"
                                            AlternateText=".: meus anúncios" runat="server" OnClick="btAnuncio_OnClick" 
                                            ToolTip="Meus Anúncios" />
                                        
                                    </td>
                                    <td width="20" align="right" __designer:mapid="a0">
                                        <asp:Image ID="Image1" runat="server" Width="18" Height="36" ImageAlign="Top" 
                                            ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                                    </td>
                                    <td width="240" class="tbTitulo_NomeTela" align="left" __designer:mapid="a2">
                                        <asp:Label ID="Label1" runat="server" SkinID="normal" Width="250px" >Meus Anúncios - Em Negociação</asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td class="tbTitulo_bordaDireita" __designer:mapid="a4">
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <br />
                <asp:GridView ID="grdMeusAnuncios" runat="server" 
                    AutoGenerateColumns="False" SkinID="Embedded" 
                    onselectedindexchanged="grdMeusAnuncios_SelectedIndexChanged" 
                    OnPageIndexChanging="grdMeusAnuncios_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    
                    
                        <asp:BoundField DataField="cdAnuncioSEQ" HeaderText="Número">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dsTipoAtivo" HeaderText="Tipo de Ativo">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dsTituloAnuncio" HeaderText="Título">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dsIndicadorStatusAnuncio" HeaderText="Situação">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                    </Columns>
                    
                    
                </asp:GridView>
                <br />
                
                <br />
                
                <br />
                <br />
            </div>
--%>            </asp:Content>

