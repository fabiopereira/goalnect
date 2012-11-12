class VantagensFileGenerator
  
  def self.xml
   redemptions = RedemptionPointTransaction.find(:all, :conditions => ['processed = :p', {:p => false}])
   vantagens_order = VantagensOrder.new(redemptions)
   file = create_file vantagens_order
   RedemptionPointTransaction.update_all(['processed = ?', true], ['id in (?)', redemptions_ids(vantagens_order)])
   file
  end
  
  def self.redemptions_ids vantagens_order
    ids = []
    vantagens_order.redemption_orders.each do |order|
      ids << order.id
    end
    ids
  end
  
  def self.file_name
    "Bonificacao_#{VantagensOrder::PARTNER_ID}_#{br_today_date}.xml"
  end
  
  def self.br_today_date
    Time.now.in_time_zone("Brasilia").strftime("%Y%m%d")
  end
  
  def self.create_file vantagens_order
    vantagens_file = nil
    file = File.open("#{Rails.root.join('tmp') }/#{file_name}",  "w+") 
    begin
       file.print(vantagens_order.to_xml)
       file.flush 
       vantagens_file = VantagensFile.new({:file => file, :file_name => file_name})
    ensure
      file.close
      File.delete(file.path) 
    end
    vantagens_file
  end
 
  
end
