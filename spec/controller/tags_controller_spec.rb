require 'rails_helper'

describe TagsController, :type => :controller do
  let(:accept_json) { {"Accept" => "application/json"} }
  let(:json_content_type) { {"Content-Type" => "application/json"} }
  let(:accept_and_return_json) { accept_json.merge(json_content_type) }
  let(:entity_type) { "product" }
  let(:entity_id) { "abc123" }
  let(:entity_tags) { ["hat", "fish"] }
  let(:tag_params) do
		{
			entity_type: entity_type,
			entity_id: entity_id,
      tags: entity_tags
		}
  end

  before(:each) do
    @entity = Entity.create(entity_type: entity_type, entity_id: entity_id)
    entity_tags.each { |tag| @entity.tags << Tag.create(name: tag) }
  end

  describe "POST /tag" do
    context "when valid parameters" do
      it "creates an entity with tags" do

        post :create, tag_params, accept_and_return_json

        expect(response.status).to eq 201
        expect(Entity.first.entity_type).to eq tag_params[:entity_type]
        expect(Entity.first.entity_id).to eq tag_params[:entity_id]
        expect(Entity.first.tags.count).to eq 2
        expect(Entity.first.tag_names).to eq tag_params[:tags]
      end
    end

    context "when parameters missing" do
      it "responds with error" do

        post :create, { entity_type: entity_type }, accept_and_return_json

        expect(response.status).to eq 400
      end
    end
  end

  describe "GET /tags/:entity_type/:entity_id" do
    context "when entity exists" do
      it "returns requested entity" do

        get :show, tag_params, accept_json
				body = JSON.parse(response.body)

        expect(response.status).to be 200
				expect(body["entity_type"]).to eq @entity.entity_type
				expect(body["entity_id"]).to eq @entity.entity_id
      end
    end

    context "when entity does not exist" do
      it "returns entity not found" do
				tag_params = {
					entity_type: 'invalid',
					entity_id: 'does-not-exist'
				}

        get :show, tag_params, accept_json
        body = JSON.parse(response.body)

        expect(response.status).to be 404
        expect(body["error"]).to eq "Entity not found"
      end
    end
  end

  describe "DELETE /tags/:entity_type/:entity_id" do
    it "deletes an entity" do

      delete :destroy, tag_params, accept_json

      expect(response.status).to be 204
      expect(Entity.count).to eq 0
    end
  end
end
