require 'spec_helper'

describe LiquidMarkdown do
  it 'has a version number' do
    expect(LiquidMarkdown::VERSION).not_to be nil
  end

  context '.Liquid' do
    it 'should convert content to liquid template' do
      output = LiquidMarkdown.liquidize('{{"Hello World" | upcase}}')

      expect(output).to eq("<p>HELLO WORLD</p>\n")
    end
  end

  context '.Markdown' do
    it 'should convert content to markdown template' do
      output = LiquidMarkdown.render('#first heading')

      expect(output).to eq('<h1>First Heading</h1>')
    end
  end

  it 'should convert into Liquid markdown syntax' do
    input = %{
      {{ "Hello World" | upcase }}

      ```
        def code_block(args)
          puts "code block example"
        end
      ```
    }

    output = "<p>HELLO WORLD</p>\n\n<p><code>\n        def code_block(args)\n          puts &quot;code block example&quot;\n        end\n</code></p>\n"

    expect(LiquidMarkdown.render(input)).to eq(output)
  end
end
