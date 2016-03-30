require 'rails_helper'

describe Tag do
  let(:entity_type) { "product" }
  let(:entity_id) { "abc123" }

  before(:each) do
    @entity = Entity.create(
      entity_type: entity_type,
      entity_id: entity_id
    )
  end

  it "is valid with name" do
    tag = Tag.new(name: "hat")

    expect(tag).to be_valid
  end

  it "is invalid without name" do
    tag = Tag.new

    expect(tag).to be_invalid
  end

  it "can be created through Entity" do
    tag = @entity.tags.create(name: "hat")

    expect(Tag.count).to eq 1
    expect(@entity.tags.count).to eq Tag.count
    expect(@entity.tags).to include(tag)
  end
end
