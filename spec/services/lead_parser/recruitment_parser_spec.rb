require "rails_helper"

RSpec.describe LeadParser::RecruitmentParser, type: :model do


  let(:input_json) {
    # Must do it twice, don't know why
    JSON.parse(JSON.parse(File.read("#{Rails.root}/spec/services/examples/input_json.json"))).sample
  }
  let(:rec_parser) { LeadParser::RecruitmentParser.new(input_json) }

  describe '.parse' do
    before do
      rec_parser.parse
    end
    it 'should parse the input_json and assign it to the output json' do
      actual = rec_parser.output_json
      expect(actual[:epid]).to eq(input_json["lead"]["cipid"])
      expect(actual[:trade_slug]).to eq(input_json["lead"]["category"])
      expect(actual[:order_type]).to eq(input_json["lead"]["request_type"])
      expect(actual[:cipid]).to eq(input_json["lead"]["cipid"])
      input_address = input_json["lead"]["address"].split(',')
      expect(actual[:address_attributes][:line1]).to eq(input_address[0])
      expect(actual[:address_attributes][:postal_code]).to eq(input_address[1])
      expect(actual[:address_attributes][:city]).to eq(input_address[2])
    end
  end

end
