class LeadParser::RecruitmentParser < LeadParser::Parser

  attr_accessor :output_json, :input_json

  def initialize(input_json)
    @input_json = input_json
  end

  def parse
    @output_json = {
      epid: epid,
      trade_slug: trade_slug,
      order_type: order_type,
      cipid: cipid,
      address_attributes: address_attributes
    }
  end

  private

  def epid
    @input_json["lead"]["cipid"]
  end

  def trade_slug
    @input_json["lead"]["category"]
  end

  def order_type
    @input_json["lead"]["request_type"]
  end

  def cipid
    @input_json["lead"]["cipid"]
  end

  def description
  end

  def contract_attributes
  end

  def address_attributes
    address_array = @input_json["lead"]["address"].split(',')
    {
      line1: address_array[0],
      postal_code: address_array[1],
      city: address_array[2]
    }
  end

  def address_line1
    @input_json["lead"]["address"]
  end

  def address_postal_code
  end

  def address_city
  end
end
