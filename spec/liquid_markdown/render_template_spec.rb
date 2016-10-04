require 'spec_helper'

describe LiquidMarkdown::Render::Template do
  subject { described_class }

  it 'expect template string on initialize' do
    expect { subject.new }.to raise_error(ArgumentError)
  end

  context '.Markdown' do
    it 'should render h1 tag' do
      lm = subject.new('#first heading')
      expect(lm.markdown(lm.template)).to eq("<h1>first heading</h1>\n")
    end
  end

  context '.Liquidize' do
    it 'should upcase string using liquid template' do
      lm = subject.new('{{"hello world" | upcase}}')
      expect(lm.liquidize).to eq('HELLO WORLD')
    end

    it 'should be able to parse liquid variables from value' do
      lm = subject.new('Hello {{name}}!', 'name' => 'guest')
      expect(lm.liquidize).to eq('Hello guest!')
    end

    it 'hash values should be valid' do
      lm = subject.new('Hello {{name}}!', name: 'guest')
      expect(lm.liquidize).to eq('Hello guest!')
    end
  end

  context '.render' do
    it 'should render both Liquid and Markdown together' do
      lm = subject.new('##My Name is {{name | upcase}}.', name: 'Admin')
      expect(lm.render).
          to eq("<h2>My Name is ADMIN.</h2>\n")
    end
  end
end