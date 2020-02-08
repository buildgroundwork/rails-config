# frozen_string_literal: true

# Replicate Rack exception handling for specs.
module HandleExceptionsInSpecs
  def process(*)
    super
  rescue ActiveRecord::RecordNotFound, ActionController::RoutingError, Pundit::NotAuthorizedError
    @response.status = 404
    @response
  rescue ActionController::UnknownFormat
    @response.status = 406
    @response
  rescue ActionController::ParameterMissing
    @response.status = 400
    @response
  end
end

