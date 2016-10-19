require 'spec_helper'

describe LiquidMarkdown::Render do
  subject { described_class }

  it 'has a version number' do
    expect(LiquidMarkdown::VERSION).not_to be nil
  end

  it 'expect template string on initialize' do
    expect { subject.new }.to raise_error(ArgumentError)
  end

  context '.Liquidize' do
    it 'should upcase string using liquid template' do
      lm = subject.new('{{"hello world" | upcase}}')
      expect(lm.liquidize).to eq('HELLO WORLD')
    end

    it 'should be able to parse liquid variables' do
      lm = subject.new('Hello {{name}}!', 'name' => 'guest')
      expect(lm.liquidize).to eq('Hello guest!')
    end
  end

  it 'should convert into LiquidMarkdown syntax' do
    template = '### h3 tag
  I love {{fruit.name}}!'

    output = "<h3>h3 tag</h3>\n<p>I love Orange!</p>\n"
    lm = subject.new(template, {'fruit' => {'name' => 'Orange'}})

    expect(lm.html).to eq(output)
  end

  it 'should be able to combine html and markdown together' do
    template = '
# first heading
*bold*
_underline_
<span>inline html</span>
<div>
inline block level element
</div>
'
    lm = subject.new(template)

    expect(lm.html).to eq("\n<h1>first heading</h1>\n<p><em>bold</em>\n<em>underline</em>\n<span>inline html</span></p>\n<div>\n  <p>inline block level element</p>\n</div>\n")
  end

  it 'should be able to combine html, markdown and liquid together' do
    template = '# List of products
'
    template += '<ul id="products"><li><h2>{{ product.name }}</h2>Only {{ product.price | price }}</li></ul>'
    lm = subject.new(template, {'product' => {'name' => 'Galaxy S7 Edge', 'price' => 1200}})

    expect(lm.html)
        .to eq("<h1>List of products</h1>\n<ul id=\"products\"><li><h2>Galaxy S7 Edge</h2>Only 1200</li></ul>\n")
  end

  it 'should force strip_html filter for all variables when rendering liquid' do
    template = 'Strip html content from: {{content}}'
    lm = subject.new(template, {'content' => '<html><script>alert("hello")</script><style>#alert{padding: 0;}</style><body><p>Content with html tags in it</p></body></html>'})

    expect(lm.html)
        .to eq("<p>Strip html content from: Content with html tags in it</p>\n")
  end

  context '.Layout' do
    let(:layout) {'<html><head></head><body>{{yield}}</body></html>'}
    let(:template) {'<ul id="products"><li><h2>{{ product.name }}</h2>Only {{ product.price | price }}</li></ul>'}
    let(:values) {{'product' => {'name' => 'Galaxy S7 Edge', 'price' => 1200}}}

    it 'default layout should be empty' do
      lm = subject.new(template, values)
      expect(lm.layout).to eq('')
    end

    it 'should be able to set layout' do
      lm = subject.new(template, values)
      lm.layout = layout
      expect(lm.layout).to eq(layout)
    end

    it 'should render default layout if no layout configured' do
      lm = subject.new(template, values)
      expect(lm.html).to eq("<ul id=\"products\"><li><h2>Galaxy S7 Edge</h2>Only 1200</li></ul>\n")
    end

    it 'should wrap output within layout' do
      lm = subject.new(template, values)
      lm.layout = layout

      expect(lm.html).to eq("<html><head></head><body><ul id=\"products\"><li><h2>Galaxy S7 Edge</h2>Only 1200</li></ul>\n</body></html>")
    end
  end
end
