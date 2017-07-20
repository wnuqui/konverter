class ConversionsController < ApplicationController
  def create
    now = Time.now
    conversion = Conversion.where({ created_at: (now - 1.minute)..now }).where(post_params.slice(:base, :target)).first

    if conversion.nil?
      Conversion.create(post_params.slice(:base, :target))
    end

    render json: { conversion: '1 US dollar = 0.8927 euros' }
  end

  private

  def post_params
    params.permit!
  end
end
