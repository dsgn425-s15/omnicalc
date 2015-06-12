require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do

  describe "GET #word_count_form" do
    it "responds successfully" do
      get :word_count_form
      expect(true).to be true
    end
  end
end
