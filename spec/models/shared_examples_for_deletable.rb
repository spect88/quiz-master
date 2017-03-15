require 'rails_helper'

shared_examples 'deletable' do
  it 'can be marked as deleted' do
    expect { model.mark_as_deleted! }
      .to change(model, :deleted?)
      .from(false)
      .to(true)
  end

  describe 'when model is deleted' do
    before { model.mark_as_deleted! }

    it 'is not part of "existing" scope' do
      expect(model.class.existing.map(&:id)).not_to include(model.id)
    end

    it 'is part of "deleted" scope' do
      expect(model.class.deleted.map(&:id)).to include(model.id)
    end
  end
end
