require 'rubygems'
require 'HTTParty'


class Stack
  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize(service, id)
    @options = {query: {site: service}}
    @id = id
  end

  def user
    obj = self.class.get("/2.2/users/#{@id}", @options)
    obj = obj['items']
    name = obj[0]
    name = name['display_name']
    puts name
  end

  def tags
    @tags = []
    obj = self.class.get("/2.2/users/#{@id}/tags", @options)
    obj = obj['items']
    obj.each do |i|
      i.each { |key, value|
        if (key === "name")
          @tags.push(value)
        end
      }
    end

  end

  def questions
    suggest = []
    quest = self.class.get("/2.2/questions/no-answers", @options)
    quest = quest['items']
    quest.each do |i|
      i.each d { |value|
        if (@tags.include? value)
          suggest.push(quest)
        end
      }
    end
    return suggest
  end


end

stack_ext = Stack.new("stackoverflow", 15)
# stack_ext.user
stack_ext.tags



