module Kobol::Presenters
  class Issue

    attr_reader :title, :comments, :url, :language

    def initialize(attributes)
      attributes.each { |property,value| instance_variable_set("@#{property}", value) }
    end

    def title
      @title ? CGI::escapeHTML(@title) : nil
    end

    def language
      @language ? CGI::escapeHTML(@language) : nil
    end

    def body
      @body ? Markdown.new(@body, :filter_html, :smart).to_html : nil
    end

    def repo
      @url.gsub(/^(((https|http)?:\/\/(www\.)?))github.com(:|\/)/i, '').gsub(/(\/issues(.*)|\/pull(.*))$/i, '')
    end

    def labels
      @labels.map { |label| Label.new(name: label.name, color: label.color) }
    end

    def updated_at
      @updated_at.strftime("%d/%m/%Y %H:%M")
    end
  end
end
