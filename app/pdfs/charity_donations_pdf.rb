class CharityDonationsPdf < Prawn::Document
  def initialize(charity_donations, view)
    super(top_margin: 70)
    @charity_donations = charity_donations
    @view = view
    goalnect_logo
    header_text
    line_items
    total_price
  end
  
  def goalnect_logo
    repeat(:all) do
      image("#{Rails.root}/public/assets/pdf_images/goalnect.logo.png", :position => :right, :width => 150) 
    end
  end
  
  def header_text
    move_down 20
    text "#{@charity_donations.charity.charity_name}", size: 16, style: :bold
    text "#{I18n.t("charity_page.donations_list")} (#{@charity_donations.from.strftime("%d/%m/%Y")} - #{@charity_donations.to.strftime("%d/%m/%Y")})", size: 16
  end
  
  def line_items
    if @charity_donations.donations && !@charity_donations.donations.empty?
      move_down 20
      table line_item_rows do
        row(0).font_style = :bold
        columns(3..5).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
      end
    else
      text "#{I18n.t("charity_page.no_donations_message")}"
    end
  end

  def line_item_rows
    if @charity_donations.donations
      [["Id", "#{I18n.t("charity_page.date")}", "#{I18n.t("charity_page.donor")}", "#{I18n.t("charity_page.value")}", "PagSeguro", "Goalnect"]] +
      @charity_donations.donations.map do |item|
        [item.id, item.created_at.strftime("%d/%m/%Y"), item.donor_name, price(item.amount), price(item.pagseguro_fee), price(item.goalnect_fee)]
      end
    end
  end
  
  def price(num)
    @view.number_to_currency(num)
  end
  
  def total_price
    move_down 30
    text "#{I18n.t("charity_page.total_raised_amount")}: #{price(@charity_donations.total_donations)}", size: 16, style: :bold
    text "#{I18n.t("charity_page.total_pagseguro_fee")}: #{price(@charity_donations.total_pagseguro_fee)}", size: 16, style: :bold
    text "#{I18n.t("charity_page.total_goalnect_fee")}: #{price(@charity_donations.total_goalnect_fee)}", size: 16, style: :bold
    text "#{I18n.t("charity_page.total_net_raised_amount")}: #{price(@charity_donations.total_net_donations)}", size: 16, style: :bold
  end
  
  def file_name
    "donationslist.pdf"
  end
end