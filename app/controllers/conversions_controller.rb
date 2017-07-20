class ConversionsController < ApplicationController
  def create
    now = Time.now
    conversion = Conversion.where({ created_at: (now - 1.minute)..now }).where(post_params.slice(:base, :target)).first

    if conversion.nil?
      Conversion.create(post_params.slice(:base, :target))
    end

    result = Conversion.convert_via_google(post_params.slice(:base, :target))
    render json: { conversion: result }
  end

  private

  def post_params
    params.permit!
  end
end
