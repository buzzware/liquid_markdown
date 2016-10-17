require 'spec_helper'

module Kramdown
  module Converter
    describe PlainText do
      [
          [%(the body), %(the body)],
          [%(# h1 tag), %(h1 tag)],
          [%(## h2 tag), %(h2 tag)],
          [%(### h3 tag), %(h3 tag)],
          [%(*em tag*), %(em tag)],
          [%(**strong tag**), %(strong tag)],
          [%(para 1\npara2), %(para 1\npara2)],
          [%(some text with \\[escaped brackets\\]), %(some text with [escaped brackets])],
          [%(some text with non-ascii char ), %(some text with non-ascii char )],
          [%(<p>paragraph text</p>), %(paragraph text)]
      ].each_with_index do |(kramdown, expected), idx|
        it "converts example #{idx + 1} to plain text" do
          doc = Document.new(kramdown)

          expect(doc.to_plain_text).to eq(expected)
        end
      end

      it 'should convert kramdown and html into text' do
        text = '## the heading'
        text += '
<p>paragraph text</p>
          '
        doc = Document.new(text)
        expect(doc.to_plain_text).to eq("the heading\nparagraph text")
      end
    end
  end
end
