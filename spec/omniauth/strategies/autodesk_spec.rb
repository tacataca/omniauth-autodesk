require 'spec_helper'

describe OmniAuth::Strategies::Autodesk do
  subject do
    OmniAuth::Strategies::Autodesk.new({})
  end

  context 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('autodesk')
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://developer.api.autodesk.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://developer.api.autodesk.com/authentication/v1/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://developer.api.autodesk.com/authentication/v1/gettoken')
    end
  end

  describe '#info' do
    before do
      allow(subject).to receive(:raw_info).and_return(raw_info_hash)
    end

    it 'should returns the username' do
      expect(subject.info[:username]).to eq(raw_info_hash['screen_name'])
    end

    it 'should returns the first name' do
      expect(subject.info[:first_name]).to eq(raw_info_hash['firstName'])
    end

    it 'should returns the last name' do
      expect(subject.info[:last_name]).to eq(raw_info_hash['lastName'])
    end

    it 'should returns the email' do
      expect(subject.info[:email]).to eq(raw_info_hash['emailId'])
    end

    it 'should returns the country' do
      expect(subject.info[:country]).to eq(raw_info_hash['countryCode'])
    end

    it 'should returns the language' do
      expect(subject.info[:language]).to eq(raw_info_hash['language'])
    end
  end

  describe '#callback_url' do
    it 'is a combination of host, script name, and callback path' do
      allow(subject).to receive(:full_host).and_return('https://example.com')
      allow(subject).to receive(:script_name).and_return('/sub_uri')

      expect(subject.callback_url).to eq('https://example.com/sub_uri/auth/autodesk/callback')
    end
  end

  # let(:access_token) { double('AccessToken') }
  # let(:parsed_response) { double('ParsedResponse') }
  # let(:response) { double('Response', parsed: parsed_response) }
  # let(:autodesk_service) { OmniAuth::Strategies::Autodesk.new({}) }


  # subject { autodesk_service }

  # before(:each) do
  #   allow(subject).to receive(:access_token).and_return(access_token)
  # end

  # describe 'client options' do
  #   context 'with defaults' do
  #     subject { gitlab_service.options.client_options }

  #     its(:site) { is_expected.to eq 'https://gitlab.com/api/v4' }
  #   end

  #   context 'with override' do
  #     subject { enterprise.options.client_options }

  #     its(:site) { is_expected.to eq enterprise_site }
  #   end
  # end

  # describe 'redirect_url' do
  #   context 'with defaults' do
  #     subject { gitlab_service.options }
  #     its(:redirect_url) { is_expected.to be_nil }
  #   end

  #   context 'with customs' do
  #     subject { enterprise.options }
  #     its(:redirect_url) { is_expected.to eq 'http://localhost:9292/callback_url' }
  #   end
  # end

  # describe '#raw_info' do
  #   it 'sent request to current user endpoint' do
  #     expect(access_token).to receive(:get).with('user').and_return(response)
  #     expect(subject.raw_info).to eq(parsed_response)
  #   end
  # end
end

private

def raw_info_hash
  {
    'firstName' => 'Foo',
    'lastName' => 'Bar',
    'username' => 'foo',
    'emailId' => 'foo@example.com',
    'countryCode' => 'CA',
    'language' => 'en',
  }
end
