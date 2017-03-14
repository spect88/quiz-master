require 'rails_helper'

describe QuizResult do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:quiz) }
end
