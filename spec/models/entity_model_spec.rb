require 'rails_helper'

describe Entity do
  let(:entity_type) { "product" }
  let(:entity_id) { "abc123" }
  let(:entity_tags) { ["hat", "fish"] }

  it "is valid with entity_type and entity_id" do
    entity = Entity.new(
      entity_type: entity_type,
      entity_id: entity_id
    )

    expect(entity).to be_valid
  end

  it "is invalid without entity_type" do
    entity = Entity.new(
      entity_id: entity_id
    )

    expect(entity).to be_invalid
  end

  it "is invalid without entity_id" do
    entity = Entity.new(
      entity_type: entity_type
    )

    expect(entity).to be_invalid
  end
end
