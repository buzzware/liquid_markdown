require 'spec_helper'

describe LiquidMarkdown do
  it 'has a version number' do
    expect(LiquidMarkdown::VERSION).not_to be nil
  end

  it 'should convert into LiquidMarkdown syntax' do
    input = '### h3 tag
  I love {{fruit.name}}!'

    output = "<h3>h3 tag</h3>\n\n<p>I love Orange!</p>\n"

    expect(LiquidMarkdown.render(input, {'fruit' => {'name' => 'Orange'}})).to eq(output)
  end
end
