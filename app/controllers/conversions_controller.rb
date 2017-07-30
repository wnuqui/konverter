class ConversionsController < ApplicationController
  def create
    result = Conversion.convert(post_params.slice(:base, :target))
    render json: { conversion: result }
  end

  private

  def post_params
    params.permit!
  end
end
