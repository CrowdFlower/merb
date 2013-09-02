[:be_successful, :respond_successfully].each do |type|
  RSpec::Matchers.define(type) do
    match do |rack|
      @status = rack.respond_to?(:status) ? rack.status : rack
      @inspect = describe_input(rack)

      (200..207).include?(@status)
    end

    failure_message_for_should do |rack|
      if @inspect.is_a?(Numeric)
        "Expected status code to be successful, " \
        "but it was #{@inspect}"
      else
        "Expected #{@inspect} " \
        "to be successful, but it returned a #{@status}"
      end
    end

    failure_message_for_should_not do |rack|
      if @inspect.is_a?(Numeric)
        "Expected status code not to be successful, " \
        "but it was #{@inspect}"
      else
        "Expected #{@inspect} not " \
        "to be successful, but it returned a #{@status}"
      end
    end
  end
end

[:be_missing, :be_client_error].each do |type|
  RSpec::Matchers.define(type) do
    match do |rack|
      @status = rack.respond_to?(:status) ? rack.status : rack
      @inspect = describe_input(rack)

      (400..417).include?(@status)
    end
    
    failure_message_for_should do |rack|
      unless @inspect.is_a?(Numeric)
        "Expected #{@inspect} " \
        "to be missing, but it returned a #{@status}"
      else
        "Expected not to get a missing error code, " \
        "but got #{@inspect}"
      end
    end

    failure_message_for_should_not do |rack|
      unless @inspect.is_a?(Numeric)
        "Expected #{@inspect} not " \
        "to be missing, but it returned a #{@status}"
      else
        "Expected a missing error code, " \
        "but got #{@inspect}"
      end
    end
  end
end

RSpec::Matchers.define(:have_body) do |body|
  match do |rack|
    @actual = if rack.respond_to?(:body)
      rack.body.to_s
    else
      rack.to_s
    end
    
    @actual == body
  end
  
  failure_message_for_should do |rack|
    "Expected the response to match:\n    #{body}\nActual response was:\n    #{@actual}" 
  end

  failure_message_for_should_not do |rack|
    "Expected the response not to match:\n    #{body}\nActual response was:\n    #{@actual}" 
  end
end

RSpec::Matchers.define(:have_content_type) do |mime_symbol|
  match do |rack|
    content_type = rack.headers["Content-Type"].split("; ").first
    if registered_mime = Merb.available_mime_types[mime_symbol]
      registered_mime[:accepts].include?(content_type)
    else
      @error = "Mime #{mime_symbol.inspect} was not registered"
      false
    end
  end
  
  failure_message_for_should do |rack|
    if @error
      @error
    else
      ret = "Expected your response to be of the #{mime_symbol} type, "
      if mime = Merb.available_accepts[rack.headers["Content-Type"]]
        ret << "but it was #{mime}"
      else
        ret << "but it was #{rack.headers["Content-Type"]}, which was " \
               "not a registered Merb content type."
      end
    end
  end
end

RSpec::Matchers.define(:redirect) do
  match do |rack|
    @inspect = describe_input(rack)
    @status_code = status_code(rack)
    (300..399).include?(@status_code)
  end
  
  failure_message_for_should do |rack|
    "Expected #{@inspect} to be a redirect, but the " \
    "status code was #{@status_code}"
  end

  failure_message_for_should_not do |rack|
    "Expected #{@inspect} not to be a redirect, but the " \
    "status code was #{@status_code}"
  end
end

RSpec::Matchers.define(:redirect_to) do |location|
  match do |rack|
    @inspect = describe_input(rack)
    
    return false unless rack.headers["Location"]
    @location, @query = rack.headers["Location"].split("?")
    @status_code = status_code(rack)
    location = url(location) if location.is_a?(Symbol)
    @status_code.in?(300..399) && @location == location
  end
  
  failure_message_for_should_not do |rack|
    "Expected #{@inspect} not to redirect to " \
    "<#{location}> but it did."
  end
  
  failure_message_for_should do |rack|
    if !rack.status.in?(300..399)
      "Expected #{@inspect} to be a redirect, but " \
      "it returned status code #{rack.status}."
    elsif rack.headers["Location"] != location
      "Expected #{@inspect} to redirect to " \
      "<#{location}>, but it redirected to <#{rack.headers["Location"]}>"
    end
  end
end
