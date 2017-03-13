require 'rails_helper'

describe Quiz do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(256) }
  it { is_expected.to validate_presence_of(:content) }

  it do
    is_expected
      .to allow_value(questions: [{ question: '1', answer: '2' }])
      .for(:content)
  end

  it do
    is_expected
      .not_to allow_value(questions: nil)
      .for(:content)
  end
end
