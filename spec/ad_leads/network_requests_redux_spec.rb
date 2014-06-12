require 'spec_helper'
require 'pry'

describe AdLeads::Client do
  let!(:client) { AdLeads::Client.new }
  let(:connection) { client.connection }
  let(:token) { 'ba29c63f-985a-4c64-a1d4-9455a2f967ad' }
  let(:file) { './spec/fixtures/test.jpg' }

  before do
    client.stub(:token).and_return(token)
    AdLeads::Client.stub(:new) { client }
  end

  context 'Network Requests' do
    describe 'Ad Campaign' do
      it 'uploads logo image, creates campaign using logo image, verifies and launches ad campaign' do

        options = {
          'name' => 'Creative Group Name',
          'productName' =>  'amazing product',
          'privacyPolicyUrl' => 'http://privacy_url'
        }

        response = client.create_creative_group(options)
        creative_id = JSON.parse(response.body)['data'].first

        options = {
          'type' => 'Mobile',
          'name' =>  'Ad name',
          'headerText' => 'get your ad on this phone today',
          'bodyText' => 'this is mobile ad body copy'
        }

        response = client.create_ad(creative_id, options)
        ad_id = JSON.parse(response.body)['data'].first

        options = { 'type' => 'LogoImage' }

        response = client.create_image(creative_id, ad_id, options)
        image_id = JSON.parse(response.body)['data'].first
        client.upload_image(creative_id, ad_id, image_id, file)

        options = {
          'name' => 'Campaign name',
          'verticals' =>  82,
          'offerIncentiveCategory' => 5,
          'collectedFields' => 'firstname,lastname,email,companyname',
          'budget' => 50,
          'creativeGroups' => creative_id
        }

        response = client.create_campaign(options)
        campaign_id = JSON.parse(response.body)['data'].first

        client.verify_campaign(campaign_id)
        response = client.launch_campaign(campaign_id)

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['result']).to eq true
      end
    end
  end

end
