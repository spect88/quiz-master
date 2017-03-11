require 'rails_helper'

describe LandingPagesController do
  render_views

  describe '/' do
    before { get :root }

    it 'displays root landing page' do
      expect(response.body).to match(/Quiz Master/)
      expect(response.body).to match(/Get Started/)
    end
  end
end
