class VantagensOrder

  require 'builder'
  
  HAYPER_CNPJ = "08175080000128"
  PARTNER_ID = "123456"

  def initialize(redemption_points_transactions)
    @redemption_orders = redemption_points_transactions
    @total_amount = calculate_total_amount
    @date = Time.now
  end
   
  def calculate_total_amount
    total = 0
    @redemption_orders.each do |redemption_order|
      total = total + redemption_order.money_amount
    end
    total
  end
   
  def to_xml(options={})
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, :version => "1.0", :encoding => "utf-8"
    xml.Vantagens { 
      xml.Pedidos do
        xml.qtdeTotalPedidos  @redemption_orders.size 
        xml.valorTotalBonificacaoPedidos format_value @total_amount
        xml.dataSolicitacao format_datetime @date
        @redemption_orders.each do |redemption_order|
          xml.Pedido do
            xml.idParceiro PARTNER_ID
            xml.cnpj HAYPER_CNPJ
            xml.idPedido redemption_order.id
            xml.dataPedido format_datetime redemption_order.created_at
            xml.valorBonificacao format_value redemption_order.money_amount
          end
        end
      end
    }
  end
  
  def format_datetime date
    date.in_time_zone("Brasilia").strftime("%d/%m/%Y %H:%M:%S")
  end
  
  def format_value value
    value_s = "%.2f" % value
    value_s.sub(".", ",")
  end
  
  def redemption_orders
     @redemption_orders
  end

end
