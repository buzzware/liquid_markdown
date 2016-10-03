require 'spec_helper'

describe LiquidMarkdown::Render::Template do
  subject { described_class }

  it 'expect template string on initialize' do
    expect { subject.new }.to raise_error
  end

  context '.Markdown' do

  end

  context '.Liquidize' do
    it 'should upcase string using liquid template' do
      lm = subject.new('{{"hello world" | upcase}}')
      expect(lm.liquidize).to eq('HELLO WORLD')
    end

    it 'should be able to pass values explictly' do
      lm = subject.new('Hello {{name}}!', name: 'guest')
      expect(lm.liquidize).to eq('Hello guest!')
    end
  end
end