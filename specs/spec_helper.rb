$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'fbgraph'
begin
  require 'redgreen'
rescue LoadError
  # No pretty colors in Ruby 1.9+.
end

def expect_consumer(uri, result = '')
  consumer = @client.consumer[uri]
  consumer.stub!(:get).and_return(Struct.new(:body).new(result))
  @client.consumer.stub!(:[]).with(uri).and_return(consumer)
end

def expect_consumer_post(uri, params = {}, result = '')
  rest_client = @client.consumer[uri]
  rest_client.stub!(:post).with(params).and_return(Struct.new(:body).new(result))
  @client.consumer.stub!(:[]).with(uri).and_return(rest_client)
end
