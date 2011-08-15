module ActiveEmbed
  module CanEmbed
    def embeds(part_prefix, options = {})
      options.assert_valid_keys(:class_name)

      part_prefix     = part_prefix.to_s
      part_class_name = options[:class_name] || part_prefix.camelize
      part_class      = part_class_name.constantize

      class_eval do
        define_method(part_prefix) do
          @aggregation_cache[part_prefix] ||= part_class.new(self, part_prefix)
        end

        define_method("#{part_prefix}=") do |new_part|
          part = send(part_prefix)
          new_part.each { |k, v| part.send("#{k}=", v) }
        end
      end
    end
  end

  module CanBeEmbedded
    def initialize(embeding_record, prefix)
      @embeding_record = embeding_record
      @prefix          = prefix
    end

    def [](key)
      send(key)
    end

    def []=(key, value)
      send("#{key}=", value)
    end

    def respond_to?(method, include_private = false)
      @embeding_record.respond_to?(proxy_method_for(method)) || super
    end

    def method_missing(method, *args, &block)
      if respond_to?(method)
        @embeding_record.send(proxy_method_for(method), *args, &block)
      else
        super
      end
    end

    private
    def proxy_method_for(method)
      "#{@prefix}_#{method}"
    end
  end
end
