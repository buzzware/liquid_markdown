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

    it 'hash values should be valid' do
      lm = subject.new('Hello {{name}}!', name: 'guest')
      expect(lm.liquidize).to eq('Hello guest!')
    end

    it 'deeply nested hash values should be valid' do
      lm = subject.new('Hello {{user.profile.info.name}}!', {user: {profile: {info: {name: 'admin'}}}})
      expect(lm.liquidize).to eq('Hello admin!')
    end
  end

  it 'should convert into LiquidMarkdown syntax' do
    template = '### h3 tag
  I love {{fruit.name}}!'

    output = "<h3>h3 tag</h3>\n\n<p>I love Orange!</p>\n"
    lm = subject.new(template, {'fruit' => {'name' => 'Orange'}})

    expect(lm.render).to eq(output)
  end

  it 'should be able to combine html and markdown together' do
    template = '# first heading
'
    template += '*bold*'
    template += '<div>Hello World</div>'
    lm = subject.new(template)

    expect(lm.render).to eq("<h1>first heading</h1>\n\n<p><em>bold</em><div>Hello World</div></p>\n")
  end

  it 'should be able to combine html, markdown and liquid together' do
    template = '# List of products
'
    template += '<ul id="products"><li><h2>{{ product.name }}</h2>Only {{ product.price | price }}</li></ul>'
    lm = subject.new(template, {'product' => {'name' => 'Galaxy S7 Edge', 'price' => 1200}})

    expect(lm.render)
        .to eq("<h1>List of products</h1>\n\n<ul id=\"products\"><li><h2>Galaxy S7 Edge</h2>Only 1200</li></ul>\n")
  end

  it 'should force strip_html filter for all variables when rendering liquid' do
    template = 'Strip html content from: {{content}}'
    lm = subject.new(template, {'content' => '<html><script>alert("hello")</script><style>#alert{padding: 0;}</style><body><p>Content with html tags in it</p></body></html>'})

    expect(lm.render)
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
      expect(lm.render).to eq("<ul id=\"products\"><li><h2>Galaxy S7 Edge</h2>Only 1200</li></ul>\n")
    end

    it 'should wrap output within layout' do
      lm = subject.new(template, values)
      lm.layout = layout

      expect(lm.render).to eq("<html><head></head><body><ul id=\"products\"><li><h2>Galaxy S7 Edge</h2>Only 1200</li></ul>\n</body></html>")
    end
  end
end
