class TagsController < ApplicationController
	before_action :find_entity

  respond_to :json

  def create
		unless tags_params[:entity_type] && tags_params[:entity_id]
			render json: { error: "Missing :entity_type or :entity_id parameters" }, status: :bad_request
			return
		end

		if @entity
	    @entity.tags.delete_all
      @entity.destroy_unused_tags
		else
      @entity = Entity.create(
        entity_type: tags_params[:entity_type],
        entity_id: tags_params[:entity_id]
      )
		end

    tags = tags_params[:tags] || []

    tags.each do |tag|
      @entity.tags.find_or_create_by(name: tag)
    end

    render json: @entity.to_json, status: :created
  end

	private

	def	find_entity
		@entity = Entity.find_by(entity_type: tags_params[:entity_type], entity_id: tags_params[:entity_id])
	end

  def tags_params
    params.permit(:entity_type, :entity_id, tags: [])
  end
end
