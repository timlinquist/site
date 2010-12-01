module Confreaks
  class Renderer
    def initialize template_file, apply_binding
      @file = template_file
      @binding = apply_binding
    end

    def render
      template = ERB.new(File.read(@file), nil, '-')
      template.result(@binding)
    end
  end
end
