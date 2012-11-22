require 'acceptance/acceptance_helper'

feature 'Camila finds Goalnect and decides to run marathon circuito das estacoes', %q{
  In order for Camila to run the marathon she needed to see the benefit of helping 
  a charity along the journey
} do
  
  scenario 'Camila and his sudden decision to run Circuito das Estacoes' do  
    due_date = 20.days.from_now
    charity = ensure_charity_active_exists 'charitycircuitadasestacoes'
    discover_goalnect_and_decide_to_commit_to_an_event 'camila', 'charitycircuitadasestacoes', due_date, charity
  end

end
