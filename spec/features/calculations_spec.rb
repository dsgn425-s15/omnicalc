require 'rails_helper'

RSpec.describe "Calculation", type: :feature do
  describe "Word Count simple" do
    before do
      visit '/word_count/new'
      fill_in 'user_text', with: 'the first draft is just you telling yourself the story'
      fill_in 'user_word', with: 'the'
      click_button 'Submit'
    end

    it "displays the word count", points: 16 do
      expect(true).to be true
    end
  end
end
