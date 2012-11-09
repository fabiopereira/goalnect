class StaticController < ApplicationController
  # Maintained temporarily because we have already sent out some links with how-it-works
  def faq
    respond_to do |format|
      format.html {render "/static/how-it-works-#{I18n.locale}.html.erb"}
    end
  end
  
  def sample_pagseguro_file
    respond_to do |format|
      format.xml 
    end
  end
  
  def test
    redemptions = RedemptionPointTransaction.all
    @order =  VantagensOrder.new(redemptions)
    
    # pedidos = []
    # pedidos << {:idParceiro => "9999999", :cnpj => "08175080000128", :idPedido => "1", :cpf => "14313459383", :dataPedido => "08/11/2012 14:30:00", :valorBonificacao => "25.00"}
    # pedidos << {:idParceiro => "9999999", :cnpj => "08175080000128", :idPedido => "1", :cpf => "14313459383", :dataPedido => "08/11/2012 14:30:00", :valorBonificacao => "25.00"}
    # pedidos << {:idParceiro => "9999999", :cnpj => "08175080000128", :idPedido => "1", :cpf => "14313459383", :dataPedido => "08/11/2012 14:30:00", :valorBonificacao => "25.00"}
    # 
    # @test = {:vantagens => {:pedidos => {:qtdeTotalPedidos => "3", :valorTotalBonificacaoPedidos => "50.00", :dataSolicitacao => "08/11/2012 23:00:00", :pedido => pedidos}}}
    # 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @order }
    end
    
  end
  
  def static_content
    if params[:static_content] == 'faq'
      return faq
    end 
    
    respond_to do |format|
      format.html {render "/static/#{params[:static_content]}-#{I18n.locale}.html.erb"}
    end
  end
end
