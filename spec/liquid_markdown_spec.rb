require 'spec_helper'

describe LiquidMarkdown do
  it 'has a version number' do
    expect(LiquidMarkdown::VERSION).not_to be nil
  end

  it 'should convert into LiquidMarkdown syntax' do
    template = '### h3 tag
  I love {{fruit.name}}!'

    output = "<h3>h3 tag</h3>\n\n<p>I love Orange!</p>\n"

    expect(LiquidMarkdown.render(template, {'fruit' => {'name' => 'Orange'}})).to eq(output)
  end

  it 'should be able to combine html and markdown together' do
    template = '# first heading
'
    template += '*bold*'
    template += '<div>Hello World</div>'

    expect(LiquidMarkdown.render(template)).to eq("<h1>first heading</h1>\n\n<p><em>bold</em><div>Hello World</div></p>\n")
  end

  it 'should be able to combine html, markdown and liquid together' do
    template = '# List of products
'
    template += '<ul id="products"><li><h2>{{ product.name }}</h2>Only {{ product.price | price }}</li></ul>'

    expect(LiquidMarkdown.render(template, {'product' => {'name' => 'Galaxy S7 Edge', 'price' => 1200}}))
        .to eq("<h1>List of products</h1>\n\n<ul id=\"products\"><li><h2>Galaxy S7 Edge</h2>Only 1200</li></ul>\n")
  end
end
