class ApplicationController < ActionController::API
  STATUS_CODE ||= {
    success: 200,
    created: 201,
    error: 400,
    unauthorized: 401,
    not_found: 404
  }.freeze

  STATUS_CODE.each do |status, value|
    define_method "response_#{status}" do |data = {}|
      render json: data, status: value
    end
  end
end
