module Jasonify
  def json_message(messages, success, data, status)
    render json: {
      messages: messages,
      success: success,
      data: data
    }, status: status
  end
end